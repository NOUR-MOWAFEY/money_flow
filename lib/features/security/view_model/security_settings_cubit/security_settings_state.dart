class SecuritySettingsState {
  const SecuritySettingsState({
    this.isAppLockEnabled = false,
    this.isBiometricEnabled = false,
    this.isBiometricSupported = false,
    this.hasPin = false,
    this.isLoading = false,
  });

  final bool isAppLockEnabled;
  final bool isBiometricEnabled;
  final bool isBiometricSupported;
  final bool hasPin;
  final bool isLoading;

  SecuritySettingsState copyWith({
    bool? isAppLockEnabled,
    bool? isBiometricEnabled,
    bool? isBiometricSupported,
    bool? hasPin,
    bool? isLoading,
  }) {
    return SecuritySettingsState(
      isAppLockEnabled: isAppLockEnabled ?? this.isAppLockEnabled,
      isBiometricEnabled: isBiometricEnabled ?? this.isBiometricEnabled,
      isBiometricSupported: isBiometricSupported ?? this.isBiometricSupported,
      hasPin: hasPin ?? this.hasPin,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
