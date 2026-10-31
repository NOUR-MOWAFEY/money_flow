import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/environments/data/models/environment_model.dart';
import 'package:money_flow/features/home/views/widgets/environment_balance_item_card.dart';

class ClosedEnvironmentsCollapsibleList extends StatefulWidget {
  const ClosedEnvironmentsCollapsibleList({
    super.key,
    required this.closedEnvironments,
    required this.currency,
    required this.isHidden,
    required this.onTapEnvironment,
  });

  final List<EnvironmentModel> closedEnvironments;
  final String currency;
  final bool isHidden;
  final void Function(String id) onTapEnvironment;

  @override
  State<ClosedEnvironmentsCollapsibleList> createState() =>
      _ClosedEnvironmentsCollapsibleListState();
}

class _ClosedEnvironmentsCollapsibleListState
    extends State<ClosedEnvironmentsCollapsibleList> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    if (widget.closedEnvironments.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 18),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            borderRadius: BorderRadius.circular(14),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.archive_outlined,
                        size: 16,
                        color: Colors.white38,
                      ),
                      const SizedBox(width: 8),
                      CustomText(
                        'Closed Environments (${widget.closedEnvironments.length})',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    size: 20,
                    color: Colors.white38,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (_isExpanded) ...[
          const SizedBox(height: 8),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.closedEnvironments.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final env = widget.closedEnvironments[index];
              return EnvironmentBalanceItemCard(
                environment: env,
                currency: widget.currency,
                isHidden: widget.isHidden,
                onTap: () => widget.onTapEnvironment(env.id),
              );
            },
          ),
        ],
      ],
    );
  }
}
