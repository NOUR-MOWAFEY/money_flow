import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_flow/features/security/data/services/pin_service.dart';
import 'package:money_flow/features/security/view_model/lock_shake_animation.dart';
import 'package:money_flow/features/security/views/pin_view.dart';

/// Manages PIN entry state, steps, animations, and validation for PinScreen.
class PinScreenController extends ChangeNotifier {
  PinScreenController({
    required TickerProvider vsync,
    required this.mode,
    this.customTitle,
    this.pinLength = 6,
    required this.onSuccessCallback,
    PinService? pinService,
  }) : _pinService = pinService ?? PinService(),
       _shakeController = AnimationController(
         duration: const Duration(milliseconds: 400),
         vsync: vsync,
       ) {
    _shakeAnimation = buildShakeAnimation(_shakeController);
  }

  final PinScreenMode mode;
  final String? customTitle;
  final int pinLength;
  final ValueChanged<String> onSuccessCallback;
  final PinService _pinService;

  final AnimationController _shakeController;
  late final Animation<double> _shakeAnimation;
  Animation<double> get shakeAnimation => _shakeAnimation;

  int _currentStep = 0;
  int get currentStep => _currentStep;

  String _enteredPin = '';
  String get enteredPin => _enteredPin;

  String _firstNewPin = '';
  String get firstNewPin => _firstNewPin;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  void triggerError(String message) {
    HapticFeedback.vibrate();
    _errorMessage = message;
    notifyListeners();

    _shakeController.forward(from: 0.0).then((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
        _enteredPin = '';
        _errorMessage = '';
        notifyListeners();
      });
    });
  }

  void onDigit(String digit) {
    if (_enteredPin.length >= pinLength) return;

    HapticFeedback.lightImpact();
    _errorMessage = '';
    _enteredPin += digit;
    notifyListeners();

    if (_enteredPin.length == pinLength) {
      _handlePinComplete(_enteredPin);
    }
  }

  void onBackspace() {
    if (_enteredPin.isEmpty) return;
    HapticFeedback.selectionClick();
    _errorMessage = '';
    _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
    notifyListeners();
  }

  void onClear() {
    if (_enteredPin.isEmpty) return;
    HapticFeedback.selectionClick();
    _errorMessage = '';
    _enteredPin = '';
    notifyListeners();
  }

  Future<void> _handlePinComplete(String pin) async {
    switch (mode) {
      case PinScreenMode.createPin:
        if (_currentStep == 0) {
          _firstNewPin = pin;
          _enteredPin = '';
          _currentStep = 1;
          notifyListeners();
        } else {
          if (pin == _firstNewPin) {
            _finishSuccess(pin);
          } else {
            triggerError('PINs do not match. Try again.');
            _firstNewPin = '';
            _currentStep = 0;
            notifyListeners();
          }
        }
        break;

      case PinScreenMode.changePin:
        if (_currentStep == 0) {
          final isCorrect = await _pinService.verifyPin(pin);
          if (isCorrect) {
            _enteredPin = '';
            _currentStep = 1;
            notifyListeners();
          } else {
            triggerError('Current PIN is incorrect');
          }
        } else if (_currentStep == 1) {
          _firstNewPin = pin;
          _enteredPin = '';
          _currentStep = 2;
          notifyListeners();
        } else {
          if (pin == _firstNewPin) {
            _finishSuccess(pin);
          } else {
            triggerError('PINs do not match. Try again.');
            _firstNewPin = '';
            _currentStep = 1;
            notifyListeners();
          }
        }
        break;

      case PinScreenMode.verifyPin:
        final isCorrect = await _pinService.verifyPin(pin);
        if (isCorrect) {
          _finishSuccess(pin);
        } else {
          triggerError('Incorrect PIN');
        }
        break;
    }
  }

  void _finishSuccess(String pin) {
    HapticFeedback.mediumImpact();
    onSuccessCallback(pin);
  }

  String get stepTitle {
    switch (mode) {
      case PinScreenMode.createPin:
        return _currentStep == 0 ? 'Create 6-Digit PIN' : 'Confirm Your PIN';
      case PinScreenMode.changePin:
        if (_currentStep == 0) return 'Enter Current PIN';
        if (_currentStep == 1) return 'Enter New 6-Digit PIN';
        return 'Confirm New PIN';
      case PinScreenMode.verifyPin:
        return customTitle ?? 'Enter Your PIN';
    }
  }

  String get stepSubtitle {
    switch (mode) {
      case PinScreenMode.createPin:
        return _currentStep == 0
            ? 'Set a 6-digit PIN to secure your financial data'
            : 'Re-enter your 6-digit PIN to confirm';
      case PinScreenMode.changePin:
        if (_currentStep == 0) return 'Enter your existing PIN to continue';
        if (_currentStep == 1) return 'Choose a new 6-digit security PIN';
        return 'Re-enter your new 6-digit PIN to confirm';
      case PinScreenMode.verifyPin:
        return 'Enter your 6-digit PIN to authorize this action';
    }
  }

  FaIconData get stepIcon {
    switch (mode) {
      case PinScreenMode.createPin:
        return _currentStep == 0
            ? FontAwesomeIcons.shieldHalved
            : FontAwesomeIcons.circleCheck;
      case PinScreenMode.changePin:
        if (_currentStep == 0) return FontAwesomeIcons.lock;
        if (_currentStep == 1) return FontAwesomeIcons.key;
        return FontAwesomeIcons.circleCheck;
      case PinScreenMode.verifyPin:
        return FontAwesomeIcons.shieldHalved;
    }
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }
}
