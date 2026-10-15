// ignore_for_file: non_const_argument_for_const_parameter

import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';
import 'package:money_flow/features/environments/views/widgets/environment_status_badge.dart';

class EnvironmentCardHeader extends StatelessWidget {
  const EnvironmentCardHeader({
    super.key,
    required this.environment,
  });

  final EnvironmentModel environment;

  @override
  Widget build(BuildContext context) {
    final cardColor = Color(environment.colorValue);
    final isClosed = environment.isClosed;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: cardColor.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            IconData(
              environment.iconCodePoint,
              fontFamily: 'MaterialIcons',
            ),
            color: cardColor,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                environment.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isClosed ? Colors.white54 : AppColors.text,
                  decoration: isClosed ? TextDecoration.lineThrough : null,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
              if (environment.description.isNotEmpty) ...[
                const SizedBox(height: 4),
                CustomText(
                  environment.description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              ],
            ],
          ),
        ),
        const SizedBox(width: 8),
        EnvironmentStatusBadge(isClosed: isClosed),
      ],
    );
  }
}
