import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/constants/app_currencies.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/profile/view_model/profile_cubit/profile_cubit.dart';
import 'package:money_flow/features/settings/views/currency_view.dart';

class ProfileCurrencyTile extends StatelessWidget {
  const ProfileCurrencyTile({super.key, required this.currencyCode});

  final String currencyCode;

  @override
  Widget build(BuildContext context) {
    final currency = AppCurrencies.currencies.firstWhere(
      (c) => c.code == currencyCode,
      orElse: () => AppCurrencies.currencies.first,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          'Default Currency',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final selectedCode = await Navigator.of(context).push<String>(
              MaterialPageRoute(builder: (_) => const CurrencyView()),
            );
            if (selectedCode != null && context.mounted) {
              context.read<ProfileCubit>().updateCurrency(selectedCode);
            }
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.black1,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white10),
            ),
            child: Row(
              children: [
                CustomText(
                  currency.flag,
                  style: const TextStyle(fontSize: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        currency.code,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CustomText(
                        currency.name,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ),
                CustomText(
                  currency.code,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.white38,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
