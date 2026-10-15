import 'package:flutter/material.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';
import 'package:money_flow/features/environments/views/create_environment_view.dart';

/// Reuses [CreateEnvironmentView] to provide an edit environment screen.
class EditEnvironmentView extends StatelessWidget {
  const EditEnvironmentView({super.key, required this.environment});

  final EnvironmentModel environment;

  @override
  Widget build(BuildContext context) {
    return CreateEnvironmentView(environment: environment);
  }
}
