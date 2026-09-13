import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/home/view_models/balance_visibility_cubit/balance_visibility_cubit.dart';

class CurrentBalanceText extends StatelessWidget {
  const CurrentBalanceText({super.key, this.balance = 0, this.text});
  final double balance;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: HiveService.watchUserModel(),
      builder: (context, _) {
        final currency = HiveService.getUserModel()?.defaultCurrency ?? 'EGP';

        return BlocBuilder<BalanceVisibilityCubit, bool>(
          builder: (context, isHidden) {
            final displayText =
                text ??
                (isHidden
                    ? '$currency ••••••'
                    : '$currency ${balance.toStringAsFixed(2)}');

            return FittedBox(
              fit: BoxFit.scaleDown,
              child: CustomText(
                displayText,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.bg,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
