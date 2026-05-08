import 'package:flutter/material.dart';
import 'package:money_flow/widgets/add_transaction_view_body.dart';
import 'package:money_flow/widgets/custom_back_button.dart';
import 'package:money_flow/widgets/custom_button.dart';

class AddTransactionView extends StatelessWidget {
  const AddTransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        leading: CustomBackButton(),
        title: Text('Add Transaction'),
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: CustomButton(title: 'Save', onTap: () {}),
        ),
      ),

      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: const AddTransactionViewBody(),
      ),
    );
  }
}
