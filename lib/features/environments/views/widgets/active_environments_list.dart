import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';
import 'package:money_flow/features/environments/views/widgets/environment_card.dart';

class ActiveEnvironmentsList extends StatelessWidget {
  const ActiveEnvironmentsList({
    super.key,
    required this.activeEnvironments,
    required this.onTapEnvironment,
    this.onLongPressEnvironment,
  });

  final List<EnvironmentModel> activeEnvironments;
  final ValueChanged<String> onTapEnvironment;
  final ValueChanged<EnvironmentModel>? onLongPressEnvironment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          'Active Environments',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 12),
        ...activeEnvironments.map(
          (env) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: EnvironmentCard(
              environment: env,
              onTap: () => onTapEnvironment(env.id),
              onLongPress: onLongPressEnvironment != null
                  ? () => onLongPressEnvironment!(env)
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
