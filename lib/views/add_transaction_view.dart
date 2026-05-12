import 'package:flutter/material.dart';
import 'package:money_flow/widgets/add_transaction_view_body.dart';
import 'package:money_flow/widgets/custom_back_button.dart';

class AddTransactionView extends StatelessWidget {
  const AddTransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text('Add Transaction'),
      ),

      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: const AddTransactionViewBody(),
      ),
    );
  }
}

