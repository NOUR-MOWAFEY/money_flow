import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_flow/core/widgets/custom_text.dart';

class TransactionsHistoryDateHeader extends StatelessWidget {
  const TransactionsHistoryDateHeader({
    super.key,
    required this.date,
    required this.dayTotal,
  });

  final DateTime date;
  final double dayTotal;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final checkDate = DateTime(date.year, date.month, date.day);

    String label;
    if (checkDate.isAtSameMomentAs(today)) {
      label = 'Today';
    } else if (checkDate.isAtSameMomentAs(yesterday)) {
      label = 'Yesterday';
    } else {
      label = DateFormat('EEEE, d MMM y').format(date);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8, left: 4, right: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
          CustomText(
            '${dayTotal >= 0 ? '+' : ''}${dayTotal.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: dayTotal >= 0 ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
