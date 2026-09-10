import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/widgets/custom_app_bar.dart';
import 'package:money_flow/features/data_management/view_model/restore_cubit/restore_cubit.dart';
import 'package:money_flow/features/data_management/views/widgets/restore_view_body.dart';

class RestoreView extends StatelessWidget {
  const RestoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RestoreCubit(),
      child: const Scaffold(
        appBar: CustomAppBar(title: 'Restore Data'),
        body: RestoreViewBody(),
      ),
    );
  }
}
