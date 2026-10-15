import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/features/environments/view_models/environment_details_cubit/environment_details_cubit.dart';
import 'package:money_flow/features/environments/views/widgets/environment_details_view_body.dart';

class EnvironmentDetailsView extends StatelessWidget {
  const EnvironmentDetailsView({super.key, required this.environmentId});

  final String environmentId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EnvironmentDetailsCubit(
        hiveService: HiveService.instance,
        environmentId: environmentId,
      ),
      child: const EnvironmentDetailsViewBody(),
    );
  }
}
