import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_app_bar.dart';
import 'package:money_flow/features/security/view_model/pin_screen_controller.dart';
import 'package:money_flow/features/security/views/widgets/pin_screen_body.dart';

enum PinScreenMode { createPin, changePin, verifyPin }

class PinView extends StatefulWidget {
  const PinView({super.key, required this.mode, this.title, this.onSuccess});

  final PinScreenMode mode;
  final String? title;
  final ValueChanged<String>? onSuccess;

  static const int pinLength = 6;

  @override
  State<PinView> createState() => _PinViewState();
}

class _PinViewState extends State<PinView> with SingleTickerProviderStateMixin {
  late final PinScreenController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PinScreenController(
      vsync: this,
      mode: widget.mode,
      customTitle: widget.title,
      pinLength: PinView.pinLength,
      onSuccessCallback: (pin) {
        if (widget.onSuccess != null) {
          widget.onSuccess!(pin);
        }
        Navigator.of(context).pop(pin);
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: CustomAppBar(
        title:
            widget.title ??
            (widget.mode == PinScreenMode.changePin
                ? 'Change PIN'
                : widget.mode == PinScreenMode.createPin
                ? 'Set Up PIN'
                : 'Verify PIN'),
      ),
      body: SafeArea(child: PinScreenBody(controller: _controller)),
    );
  }
}
