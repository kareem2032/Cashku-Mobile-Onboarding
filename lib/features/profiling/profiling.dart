/// Profiling feature — public exports.
///
/// Screens should import this barrel rather than deep-linking to
/// individual files.
library;

export 'domain/profiling_models.dart';
export 'presentation/controller/profiling_controller.dart'
    show
        ProfilingState,
        ProfilingController,
        profilingControllerProvider;
