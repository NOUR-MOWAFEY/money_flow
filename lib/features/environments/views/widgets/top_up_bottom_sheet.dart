import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/environments/views/widgets/top_up_amount_field.dart';
import 'package:money_flow/features/environments/views/widgets/top_up_button.dart';
import 'package:money_flow/features/environments/views/widgets/top_up_deduct_switch.dart';
import 'package:money_flow/features/environments/views/widgets/top_up_sheet_header.dart';

class TopUpBottomSheet extends StatefulWidget {
  const TopUpBottomSheet({super.key, required this.onTopUp});

  final void Function(double amount, bool deductFromMain) onTopUp;

  @override
  State<TopUpBottomSheet> createState() => _TopUpBottomSheetState();
}

class _TopUpBottomSheetState extends State<TopUpBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  bool _deductFromMain = true;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currency = HiveService.getUserModel()?.defaultCurrency ?? 'EGP';

    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: const BoxDecoration(
        color: AppColors.bg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopUpSheetHeader(),
            const SizedBox(height: 16),
            TopUpAmountField(
              controller: _amountController,
              currency: currency,
            ),
            const SizedBox(height: 20),
            TopUpDeductSwitch(
              value: _deductFromMain,
              onChanged: (val) => setState(() => _deductFromMain = val),
            ),
            const SizedBox(height: 24),
            TopUpButton(
              formKey: _formKey,
              amountController: _amountController,
              deductFromMain: _deductFromMain,
              onTopUp: widget.onTopUp,
            ),
          ],
        ),
      ),
    );
  }
}
