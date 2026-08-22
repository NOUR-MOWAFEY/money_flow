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
    return Padding(
      padding: EdgeInsetsGeometry.only(
        top: 12,
        bottom: isLastItem ? AppDimensions.viewBottomSpace : 0,
      ),

      child: _CurrencyListViewItemContainer(
        currency: currency,
        isSelected: isSelected,
        child: Row(
          children: [
            // flag
            _CurrencyFlag(isSelected: isSelected, currency: currency),

            const SizedBox(width: 12),

            // name + symbol
            _CurrencyTitles(currency: currency),

            const Spacer(),

            // check icon
            isSelected
                ? const FaIcon(FontAwesomeIcons.check, size: 18)
                : const SizedBox(),

            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}

class _CurrencyListViewItemContainer extends StatelessWidget {
  const _CurrencyListViewItemContainer({
    required this.currency,
    required this.isSelected,
    required this.child,
  });

  final CurrencyModel currency;
  final bool isSelected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),

      onTap: () {
        context.read<CurrencyPickerCubit>().selectCurrency(currency);
      },

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

        child: child,
      ),
    );
  }
}

class _CurrencyTitles extends StatelessWidget {
  const _CurrencyTitles({required this.currency});

  final CurrencyModel currency;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        // name
        CustomText(
          currency.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 4),

        // symbol
        CustomText(currency.symbol),
      ],
    );
  }
}

class _CurrencyFlag extends StatelessWidget {
  const _CurrencyFlag({required this.isSelected, required this.currency});

  final bool isSelected;
  final CurrencyModel currency;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 24,
      backgroundColor: isSelected
          ? AppColors.transparentPrimary
          : AppColors.black2,
      child: Text(currency.flag, style: TextStyle(fontSize: 20)),
    );
  }
}
