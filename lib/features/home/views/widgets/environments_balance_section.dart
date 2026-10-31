import 'package:flutter/material.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';
import 'package:money_flow/features/home/views/widgets/closed_environments_collapsible_list.dart';
import 'package:money_flow/features/home/views/widgets/environment_balance_item_card.dart';
import 'package:money_flow/features/home/views/widgets/environments_section_header.dart';
import 'package:money_flow/features/home/views/widgets/no_environments_card.dart';

class EnvironmentsBalanceSection extends StatelessWidget {
  const EnvironmentsBalanceSection({
    super.key,
    required this.environments,
    required this.currency,
    required this.isHidden,
    required this.onTapEnvironment,
    required this.onManageEnvironments,
    required this.onCreateEnvironment,
  });

  final List<EnvironmentModel> environments;
  final String currency;
  final bool isHidden;
  final void Function(String id) onTapEnvironment;
  final VoidCallback onManageEnvironments;
  final VoidCallback onCreateEnvironment;

  @override
  Widget build(BuildContext context) {
    final activeEnvironments =
        environments.where((e) => !e.isClosed).toList();
    final closedEnvironments =
        environments.where((e) => e.isClosed).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EnvironmentsSectionHeader(
          activeCount: activeEnvironments.length,
          onManage: onManageEnvironments,
        ),
        const SizedBox(height: 12),
        if (activeEnvironments.isEmpty)
          NoEnvironmentsCard(
            onCreateEnvironment: onCreateEnvironment,
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: activeEnvironments.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final env = activeEnvironments[index];
              return EnvironmentBalanceItemCard(
                environment: env,
                currency: currency,
                isHidden: isHidden,
                onTap: () => onTapEnvironment(env.id),
              );
            },
          ),
        ClosedEnvironmentsCollapsibleList(
          closedEnvironments: closedEnvironments,
          currency: currency,
          isHidden: isHidden,
          onTapEnvironment: onTapEnvironment,
        ),
      ],
    );
  }
}
