import 'package:flutter/material.dart';
import 'package:money_flow/constants/app_colors.dart';

class FloatingBottomNavBar extends StatefulWidget {
  const FloatingBottomNavBar({
    super.key,
    required this.indexZeroOnPressed,
    required this.indexOneOnPressed,
    required this.addButtonOnPressed,
    this.addButtonColor,
    this.addButtonIconColor,
  });

  @override
  State<FloatingBottomNavBar> createState() => _FloatingBottomNavBarState();
  final void Function()? indexZeroOnPressed;
  final void Function()? indexOneOnPressed;
  final void Function()? addButtonOnPressed;
  final Color? addButtonColor;
  final Color? addButtonIconColor;
}

class _FloatingBottomNavBarState extends State<FloatingBottomNavBar> {
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
      child: Stack(
        clipBehavior: Clip.none,
        alignment: AlignmentGeometry.center,
        children: [
          Row(
            children: [
              const SizedBox(width: 30),
              IconButton(
                onPressed: () {
                  selectedIndex = 0;
                  setState(() {});
                  widget.indexZeroOnPressed?.call();
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
                  setState(() {});
                  widget.indexOneOnPressed?.call();
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
          Positioned(
            bottom: 10,
            child: AddButton(
              onPressed: widget.addButtonOnPressed,
              color: widget.addButtonColor,
              iconColor: widget.addButtonIconColor,
            ),
          ),
        ],
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
    required this.onPressed,
    this.color,
    this.iconColor,
  });
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
