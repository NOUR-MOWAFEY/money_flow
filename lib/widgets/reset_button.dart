import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/constants/app_colors.dart';
import 'package:money_flow/cubits/transactions_cubit/transactions_cubit.dart';

class ResetButton extends StatelessWidget {
  const ResetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () => ShowConfirmationDialog.showConfirmationDialog(context),
      onTap: () async =>
          await context.read<TransactionsCubit>().clearTransactions(),
      borderRadius: BorderRadius.circular(32),

      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: AppColors.greyTrasparent,
          borderRadius: BorderRadius.circular(70),
        ),
        child: const Icon(Icons.restart_alt_outlined, color: AppColors.icon),
      ),
    );
  }
}
