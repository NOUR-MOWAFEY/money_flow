import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/features/environments/views/widgets/environment_details_action_card.dart';

class EnvironmentDetailsActionsRow extends StatelessWidget {
  const EnvironmentDetailsActionsRow({
    super.key,
    required this.isClosed,
    required this.onSettle,
    required this.onDelete,
  });

  final bool isClosed;
  final VoidCallback onSettle;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!isClosed) ...[
          Expanded(
            child: EnvironmentDetailsActionCard(
              icon: Icons.check_circle_outline,
              title: 'Settle / Close',
              color: Colors.green,
              onTap: onSettle,
            ),
          ),
          const SizedBox(width: 12),
        ],
        Expanded(
          child: EnvironmentDetailsActionCard(
            icon: Icons.delete_outline_rounded,
            title: isClosed ? 'Delete Environment' : 'Delete',
            color: AppColors.error,
            onTap: onDelete,
          ),
        ),
      ],
    );
  }
}
