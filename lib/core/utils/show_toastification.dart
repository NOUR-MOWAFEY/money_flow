import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:toastification/toastification.dart';

class ShowToastification {
  static void _dismissCurrent() {
    toastification.dismissAll(delayForAnimation: false);
  }

  static ToastificationItem failure(BuildContext context, String text) {
    _dismissCurrent();

    return toastification.show(
      alignment: Alignment.topCenter,
      icon: const FaIcon(FontAwesomeIcons.circleExclamation, color: Colors.white),
      foregroundColor: Colors.white,
      backgroundColor: Colors.red,
      borderSide: const BorderSide(color: Colors.transparent),
      context: context,
      title: CustomText(text),
      autoCloseDuration: const Duration(seconds: 5),
      pauseOnHover: true,
      applyBlurEffect: true,
      closeOnClick: true,
    );
  }

  static ToastificationItem success(BuildContext context, String text) {
    _dismissCurrent();

    return toastification.show(
      alignment: Alignment.topCenter,
      icon: const FaIcon(FontAwesomeIcons.circleCheck, color: Colors.white),
      foregroundColor: Colors.white,
      backgroundColor: Colors.green,
      borderSide: const BorderSide(color: Colors.transparent),
      context: context,
      title: CustomText(text),
      autoCloseDuration: const Duration(seconds: 3),
      pauseOnHover: true,
      applyBlurEffect: true,
      closeOnClick: true,
    );
  }

  static ToastificationItem warning(BuildContext context, String text) {
    _dismissCurrent();

    return toastification.show(
      alignment: Alignment.topCenter,
      icon: const FaIcon(FontAwesomeIcons.circleExclamation, color: Colors.white),
      foregroundColor: Colors.white,
      backgroundColor: Colors.orangeAccent,
      borderSide: const BorderSide(color: Colors.orangeAccent),
      context: context,
      title: CustomText(text),
      autoCloseDuration: const Duration(seconds: 5),
      pauseOnHover: true,
      applyBlurEffect: true,
      closeOnClick: true,
    );
  }

  static ToastificationItem popUp(
    BuildContext context,
    String text, [
    Color? bgColor,
  ]) {
    _dismissCurrent();

    return toastification.show(
      closeOnClick: true,
      closeButton: const ToastCloseButton(showType: CloseButtonShowType.none),
      padding: const EdgeInsets.only(left: 14, right: 10, top: 8, bottom: 8),
      style: ToastificationStyle.simple,
      alignment: Alignment.bottomCenter,
      foregroundColor: Colors.white,
      backgroundColor: bgColor ?? Colors.black45,
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(32),
      context: context,
      title: CustomText(text),
      autoCloseDuration: const Duration(seconds: 2),
      pauseOnHover: true,
      applyBlurEffect: true,
    );
  }
}
