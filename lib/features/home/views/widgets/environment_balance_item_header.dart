// ignore_for_file: non_const_argument_for_const_parameter

import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';

class EnvironmentBalanceItemHeader extends StatelessWidget {
  const EnvironmentBalanceItemHeader({
    super.key,
    required this.environment,
    required this.currency,
    required this.isHidden,
  });

  final EnvironmentModel environment;
  final String currency;
  final bool isHidden;

  @override
  Widget build(BuildContext context) {
    final envColor = Color(environment.colorValue);
    final isClosed = environment.isClosed;

    final balanceText = isHidden
        ? '$currency ••••••'
        : '$currency ${environment.currentBalance.toStringAsFixed(2)}';

    final initialText = isHidden
        ? '$currency ••••••'
        : '$currency ${environment.initialAmount.toStringAsFixed(2)}';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: envColor.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: envColor.withValues(alpha: 0.35),
            ),
          ),
          child: Icon(
            IconData(
              environment.iconCodePoint,
              fontFamily: 'MaterialIcons',
            ),
            color: envColor,
            size: 22,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: CustomText(
                      environment.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  if (isClosed) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const CustomText(
                        'Closed',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white60,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 3),
              CustomText(
                environment.description.isNotEmpty
                    ? environment.description
                    : (environment.deductedFromMain
                        ? 'Deducted from Main'
                        : 'Not deducted from Main'),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomText(
              balanceText,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isClosed ? Colors.white60 : Colors.white,
              ),
            ),
            const SizedBox(height: 2),
            CustomText(
              'of $initialText',
              style: const TextStyle(
                fontSize: 11,
                color: Colors.white38,
              ),
            ),
          ],
        ),
        const SizedBox(width: 4),
        const Icon(
          Icons.chevron_right_rounded,
          size: 18,
          color: Colors.white38,
        ),
      ],
    );
  }
}
