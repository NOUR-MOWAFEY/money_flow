import 'package:flutter/material.dart';
import 'package:money_flow/utils/add_transaction_save_button.dart';
import 'package:money_flow/widgets/add_transaction_body.dart';
import 'package:money_flow/widgets/custom_button.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AddTransactionView extends StatefulWidget {
  const AddTransactionView({super.key});

  @override
  State<AddTransactionView> createState() => _AddTransactionViewState();
}

class _AddTransactionViewState extends State<AddTransactionView> {
  late TextEditingController categoryController;
  late TextEditingController dateController;
  late TextEditingController amountController;
  late ValueNotifier<int> transactionType;
  late ValueNotifier<String> categoryTitle;
  late ValueNotifier<String> dateTitle;
  late ValueNotifier<IconData?> iconNotifier;

  @override
  void initState() {
    categoryController = TextEditingController();
    dateController = TextEditingController();
    amountController = TextEditingController();
    transactionType = ValueNotifier<int>(0);
    categoryTitle = ValueNotifier<String>('Category');
    dateTitle = ValueNotifier<String>('Date');
    iconNotifier = ValueNotifier<IconData?>(Icons.category_rounded);
    super.initState();
  }

  @override
  void dispose() {
    categoryController.dispose();
    dateController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: CustomButton(
            title: 'Save',
            onTap: () {
              onSave(
                amountController,
                categoryController,
                dateController,
                transactionType,
                context,
              );
            },
          ),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            Navigator.pop(context);
            await Future.delayed(Duration(seconds: 1));
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(
          'Add Transaction',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            ToggleSwitch(
              minWidth: double.infinity,
              initialLabelIndex: 0,
              totalSwitches: 2,
              labels: ['Expenses', 'Income'],
              onToggle: (index) {
                transactionType.value = index!;
                categoryController.clear();
                dateController.clear();
                categoryTitle.value = 'Category';
                dateTitle.value = 'Date';
                iconNotifier.value = Icons.category_rounded;
              },
            ),
            const SizedBox(height: 32),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 28),
                child: AddTransactionBody(
                  amountController: amountController,
                  categoryController: categoryController,
                  dateController: dateController,
                  transactionType: transactionType,
                  categoryTitle: categoryTitle,
                  dateTitle: dateTitle,
                  iconNotifier: iconNotifier,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
