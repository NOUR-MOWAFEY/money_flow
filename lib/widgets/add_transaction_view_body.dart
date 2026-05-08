import 'package:flutter/material.dart';
import 'package:money_flow/utils/date_formatter.dart';
import 'package:money_flow/widgets/amount_field.dart';
import 'package:money_flow/widgets/category_field.dart';
import 'package:money_flow/widgets/custom_animated_toggle.dart';
import 'package:money_flow/widgets/date_field.dart';

class AddTransactionViewBody extends StatefulWidget {
  const AddTransactionViewBody({super.key});

  @override
  State<AddTransactionViewBody> createState() => _AddTransactionViewBodyState();
}

class _AddTransactionViewBodyState extends State<AddTransactionViewBody> {
  late TextEditingController amountController;
  late Map<String, IconData> category;
  late TextEditingController dateController;
  late TransactionType transactionType;

  @override
  void initState() {
    amountController = TextEditingController();
    category = {'Category': Icons.category_rounded};
    dateController = TextEditingController();
    dateController.text = DateFormatter.dateNow;
    transactionType = TransactionType.expenses;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: ListView(
          children: [
            const SizedBox(height: 12),

            // toggle switch
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomAnimatedToggle(
                onChange: (TransactionType transactionType) =>
                    setState(() => this.transactionType = transactionType),
              ),
            ),

            const SizedBox(height: 32),

            // amount field
            AmountField(amountController: amountController),

            const SizedBox(height: 32),

            // Category field
            CategoryField(transactionType: transactionType),

            const SizedBox(height: 16),

            // Date Field
            DateField(dateController: dateController),
          ],
        ),
      ),
    );
  }
}
