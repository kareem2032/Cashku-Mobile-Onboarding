import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/profiling_models.dart';

// ────────────────────────────────────────────────────────────────────────────
// State
// ────────────────────────────────────────────────────────────────────────────

/// Immutable state for the profiling (user questionnaire) flow.
///
/// Both fields start as null — the user must actively make a selection
/// before the continue button is enabled.
class ProfilingState {
  const ProfilingState({
    this.experience,
    this.goal,
  });

  /// Selected investment experience level. Null until the user picks one.
  final InvestmentExperience? experience;

  /// Selected financial goal. Null until the user picks one.
  final FinancialGoal? goal;

  ProfilingState copyWith({
    InvestmentExperience? experience,
    FinancialGoal? goal,
  }) =>
      ProfilingState(
        experience: experience ?? this.experience,
        goal: goal ?? this.goal,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfilingState &&
          experience == other.experience &&
          goal == other.goal;

  @override
  int get hashCode => Object.hash(experience, goal);

  @override
  String toString() =>
      'ProfilingState(experience: $experience, goal: $goal)';
}

// ────────────────────────────────────────────────────────────────────────────
// Notifier
// ────────────────────────────────────────────────────────────────────────────

class ProfilingController extends Notifier<ProfilingState> {
  @override
  ProfilingState build() => const ProfilingState();

  // ── Mutations ─────────────────────────────────────────────────────────────

  /// Select (or deselect, if already selected) an experience level.
  void setExperience(InvestmentExperience value) {
    // Toggle: tapping the already-selected item deselects it.
    final next = state.experience == value ? null : value;
    state = state.copyWith(experience: next);
  }

  /// Select (or deselect) a financial goal.
  void setGoal(FinancialGoal value) {
    final next = state.goal == value ? null : value;
    state = state.copyWith(goal: next);
  }

  /// Clear all profiling selections (e.g. on flow restart).
  void reset() => state = const ProfilingState();

  // ── Computed ─────────────────────────────────────────────────────────────

  /// True when the user has selected an experience level and may proceed
  /// from the experience step.
  bool get canContinueExperience => state.experience != null;

  /// True when the user has selected a financial goal and may proceed
  /// from the goals step.
  bool get canContinueGoal => state.goal != null;

  /// True when the entire profiling flow (both steps) is complete.
  bool get isComplete => canContinueExperience && canContinueGoal;
}

// ────────────────────────────────────────────────────────────────────────────
// Provider
// ────────────────────────────────────────────────────────────────────────────

/// Provides [ProfilingController] and exposes [ProfilingState].
///
/// Usage in screens:
/// ```dart
/// final state = ref.watch(profilingControllerProvider);
/// final ctrl  = ref.read(profilingControllerProvider.notifier);
///
/// // Experience step
/// ctrl.setExperience(InvestmentExperience.beginner);
/// final canProceed = ctrl.canContinueExperience;
///
/// // Goal step
/// ctrl.setGoal(FinancialGoal.longTermWealth);
/// final canProceed = ctrl.canContinueGoal;
/// ```
final profilingControllerProvider =
    NotifierProvider<ProfilingController, ProfilingState>(
  ProfilingController.new,
);
