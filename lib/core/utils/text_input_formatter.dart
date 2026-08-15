import 'package:flutter/services.dart';

class InputFormatters {
  InputFormatters._(); // prevent instantiation

  /// Restricts input to numbers with at most 8 digits before the decimal
  /// point and up to 2 digits after it (e.g. for prices/amounts).
  static TextInputFormatter maxDigitsFormatter() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      final regExp = RegExp(r'^\d{0,8}(\.\d{0,2})?$');

      if (regExp.hasMatch(newValue.text)) {
        return newValue;
      }

      return oldValue;
    });
  }

  /// Restricts input to at most 2 lines (e.g. for category names).
  static TextInputFormatter categoryNameInputFormatter() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      final lines = newValue.text.split('\n');

      if (lines.length > 2) {
        return oldValue;
      }

      return newValue;
    });
  }
}
