import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/widgets/custom_app_bar.dart';
import 'package:money_flow/features/data_management/view_model/reset_cubit/reset_cubit.dart';
import 'package:money_flow/features/data_management/views/widgets/reset_view_body.dart';

class ResetView extends StatelessWidget {
  const ResetView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ResetCubit(),
      child: const Scaffold(
        appBar: CustomAppBar(title: 'Reset Data'),
        body: ResetViewBody(),
      ),
    );
  }
}
