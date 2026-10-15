import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/widgets/custom_app_bar.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';
import 'package:money_flow/features/environments/view_models/create_environment_cubit/create_environment_cubit.dart';
import 'package:money_flow/features/environments/views/widgets/create_environment_view_body.dart';

class CreateEnvironmentView extends StatelessWidget {
  const CreateEnvironmentView({super.key, this.environment});

  final EnvironmentModel? environment;

  @override
  Widget build(BuildContext context) {
    final isEditing = environment != null;

    return BlocProvider(
      create: (context) => CreateEnvironmentCubit(
        HiveService.instance,
        environment: environment,
      ),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: CustomAppBar(
            title: isEditing ? 'Edit Environment' : 'New Environment',
          ),
          body: const CreateEnvironmentViewBody(),
        ),
      ),
    );
  }
}
