/// Investment experience levels.
///
/// Each value maps to a [SelectableCard] option on the profiling experience
/// screen and to a specific icon from [AppIcons].
enum InvestmentExperience {
  beginner,
  some,
  experienced;

  /// Human-readable label shown on the card.
  String get label {
    switch (this) {
      case InvestmentExperience.beginner:
        return 'Beginner';
      case InvestmentExperience.some:
        return 'Some experience';
      case InvestmentExperience.experienced:
        return 'Experienced';
    }
  }

  /// Supporting subtitle shown on the card.
  String get subtitle {
    switch (this) {
      case InvestmentExperience.beginner:
        return 'I\'m new to investing';
      case InvestmentExperience.some:
        return 'I\'ve invested before';
      case InvestmentExperience.experienced:
        return 'I invest regularly';
    }
  }
}

// ────────────────────────────────────────────────────────────────────────────

/// Financial goals the user can pursue with CashKu.
///
/// Each value maps to a [SelectableCard] option on the profiling goals screen
/// and to a specific icon from [AppIcons].
enum FinancialGoal {
  longTermWealth,
  majorSaving,
  passiveIncome,
  preserveCapital;

  /// Human-readable label shown on the card.
  String get label {
    switch (this) {
      case FinancialGoal.longTermWealth:
        return 'Long-term wealth';
      case FinancialGoal.majorSaving:
        return 'Major savings';
      case FinancialGoal.passiveIncome:
        return 'Passive income';
      case FinancialGoal.preserveCapital:
        return 'Preserve capital';
    }
  }

  /// Supporting subtitle shown on the card.
  String get subtitle {
    switch (this) {
      case FinancialGoal.longTermWealth:
        return 'Build wealth over time';
      case FinancialGoal.majorSaving:
        return 'Save for a big purchase';
      case FinancialGoal.passiveIncome:
        return 'Generate recurring income';
      case FinancialGoal.preserveCapital:
        return 'Protect what I have';
    }
  }
}
