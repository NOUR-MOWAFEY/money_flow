import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/settings/data/models/currency_model.dart';
import 'package:money_flow/features/settings/view_model/currency_picker_cubit/currency_picker_cubit.dart';

class CurrencyListViewItem extends StatelessWidget {
  const CurrencyListViewItem({
    super.key,
    required this.isSelected,
    required this.currency,
    required this.isLastItem,
  });

  final bool isSelected;
  final CurrencyModel currency;
  final bool isLastItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        context.read<CurrencyPickerCubit>().selectCurrency(currency);
      },

      child: Padding(
        padding: EdgeInsetsGeometry.only(
          top: 12,
          bottom: isLastItem ? AppDimensions.viewBottomSpace : 0,
        ),

        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.transparentPrimary.withValues(alpha: .4)
                : AppColors.black1,

            border: Border.all(
              color: isSelected ? AppColors.primary : Colors.transparent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
          ),

          padding: const EdgeInsets.all(12),

          child: Row(
            children: [
              // flag
              CircleAvatar(
                radius: 24,
                backgroundColor: isSelected
                    ? AppColors.transparentPrimary
                    : AppColors.black2,
                child: Text(currency.flag, style: TextStyle(fontSize: 20)),
              ),

              const SizedBox(width: 12),

              // name + symbol
              Column(
                crossAxisAlignment: .start,
                children: [
                  // name
                  CustomText(currency.name),

                  const SizedBox(height: 4),

                  // symbol
                  CustomText(currency.symbol),
                ],
              ),

              const Spacer(),

              // check icon
              isSelected
                  ? const FaIcon(FontAwesomeIcons.check, size: 18)
                  : const SizedBox(),

              const SizedBox(width: 12),
            ],
          ),
        ),
      ),
    );
  }
}
