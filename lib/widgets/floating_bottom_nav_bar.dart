import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_colors.dart';

class CustomFloatingBottomNavBar extends StatelessWidget {
  const CustomFloatingBottomNavBar({
    super.key,
    this.indexZeroOnPressed,
    this.indexOneOnPressed,
    this.addButtonOnPressed,
    this.addButtonColor,
    this.addButtonIconColor,
    this.bottomPositioned,
  });
  final void Function()? indexZeroOnPressed;
  final void Function()? indexOneOnPressed;
  final void Function()? addButtonOnPressed;
  final Color? addButtonColor;
  final Color? addButtonIconColor;
  final double? bottomPositioned;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: AlignmentGeometry.bottomCenter,
      children: [
        _FloatingBottomNavBar(
          indexZeroOnPressed: indexZeroOnPressed,
          indexOneOnPressed: indexOneOnPressed,
        ),
        Positioned(
          bottom: bottomPositioned,
          child: _FloatingButton(
            onPressed: addButtonOnPressed,
            color: addButtonColor,
            iconColor: addButtonIconColor,
          ),
        ),
      ],
    );
  }
}

class _FloatingBottomNavBar extends StatefulWidget {
  const _FloatingBottomNavBar({
    required this.indexZeroOnPressed,
    required this.indexOneOnPressed,
  });

  @override
  State<_FloatingBottomNavBar> createState() => _FloatingBottomNavBarState();
  final void Function()? indexZeroOnPressed;
  final void Function()? indexOneOnPressed;
}

class _FloatingBottomNavBarState extends State<_FloatingBottomNavBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 64, vertical: 24),
      height: 55,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(237, 224, 224, 224),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Row(
        children: [
          const SizedBox(width: 30),
          IconButton(
            onPressed: () {
              selectedIndex = 0;
              setState(() {
                widget.indexZeroOnPressed?.call();
              });
            },
            icon: Icon(
              Icons.home,
              color: selectedIndex == 0
                  ? AppColors.primaryColor
                  : AppColors.grey,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              selectedIndex = 1;
              setState(() {
                widget.indexOneOnPressed?.call();
              });
            },
            icon: Icon(
              Icons.analytics,
              color: selectedIndex == 1
                  ? AppColors.primaryColor
                  : AppColors.grey,
            ),
          ),
          const SizedBox(width: 30),
        ],
      ),
    );
  }
}

class _FloatingButton extends StatelessWidget {
  const _FloatingButton({required this.onPressed, this.color, this.iconColor});
  final void Function()? onPressed;
  final Color? color;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      height: 52,
      width: 52,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(Icons.add, color: iconColor),
      ),
    );
  }
}
