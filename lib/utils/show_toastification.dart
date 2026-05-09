import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toastification/toastification.dart';

class ShowToastification {
  static ToastificationItem failure(BuildContext context, String text) {
    return toastification.show(
      alignment: Alignment.topCenter,
      icon: FaIcon(FontAwesomeIcons.circleExclamation, color: Colors.white),
      foregroundColor: Colors.white,
      backgroundColor: Colors.red,
      borderSide: BorderSide(color: Colors.transparent),
      context: context,
      title: Text(text, style: TextStyle(color: Colors.white)),
      autoCloseDuration: const Duration(seconds: 5),
      pauseOnHover: true,
      applyBlurEffect: true,
      closeOnClick: true,
    );
  }

  static ToastificationItem success(BuildContext context, String text) {
    return toastification.show(
      alignment: Alignment.topCenter,
      icon: FaIcon(FontAwesomeIcons.circleCheck, color: Colors.white),
      foregroundColor: Colors.white,
      backgroundColor: Colors.green,
      borderSide: BorderSide(color: Colors.transparent),
      context: context,
      title: Text(text, style: TextStyle(color: Colors.white)),
      autoCloseDuration: const Duration(seconds: 3),
      pauseOnHover: true,
      applyBlurEffect: true,
      closeOnClick: true,
    );
  }

  static ToastificationItem warning(BuildContext context, String text) {
    return toastification.show(
      alignment: Alignment.topCenter,
      icon: FaIcon(FontAwesomeIcons.circleExclamation, color: Colors.white),
      foregroundColor: Colors.white,
      backgroundColor: Colors.orangeAccent,
      borderSide: BorderSide(color: Colors.orangeAccent),
      context: context,
      title: Text(text, style: TextStyle(color: Colors.white)),
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
    return toastification.show(
      closeOnClick: true,
      closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
      padding: EdgeInsets.only(left: 14, right: 10, top: 8, bottom: 8),
      style: ToastificationStyle.simple,
      alignment: Alignment.bottomCenter,
      foregroundColor: Colors.white,
      backgroundColor: bgColor ?? Colors.black45,
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(32),
      context: context,
      title: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      autoCloseDuration: const Duration(seconds: 2),
      pauseOnHover: true,
      applyBlurEffect: true,
    );
  }
}
