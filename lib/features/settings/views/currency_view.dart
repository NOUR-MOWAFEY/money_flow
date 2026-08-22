import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/features/settings/view_model/currency_picker_cubit/currency_picker_cubit.dart';
import 'package:money_flow/features/settings/views/widgets/currency_view_body.dart';

class CurrencyView extends StatelessWidget {
  const CurrencyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => CurrencyPickerCubit(),
        child: const SafeArea(child: CurrencyViewBody()),
      ),
    );
  }
}
