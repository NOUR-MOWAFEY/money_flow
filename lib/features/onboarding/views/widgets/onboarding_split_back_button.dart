import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';

class OnboardingSplitBackButton extends StatelessWidget {
  const OnboardingSplitBackButton({
    super.key,
    required this.hasBack,
    required this.isSubmitting,
    required this.onBack,
  });

  final bool hasBack;
  final bool isSubmitting;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubic,
      width: hasBack ? 52 : 0,
      height: 52,
      margin: EdgeInsets.only(right: hasBack ? 12 : 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: OverflowBox(
          minWidth: 0,
          maxWidth: 52,
          minHeight: 0,
          maxHeight: 52,
          alignment: Alignment.center,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            opacity: hasBack ? 1.0 : 0.0,
            child: Material(
              color: AppColors.black1,
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: isSubmitting ? null : onBack,
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
