import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/reports/data/models/pie_chart_item.dart';
import 'package:money_flow/features/reports/views/widgets/reports_card.dart';

class ReportsPieChart extends StatefulWidget {
  const ReportsPieChart({super.key, this.items});

  final List<PieChartItem>? items;

  @override
  State<ReportsPieChart> createState() => _ReportsPieChartState();
}

class _ReportsPieChartState extends State<ReportsPieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final chartItems = widget.items ?? const [];
    final hasData = chartItems.isNotEmpty;

    return ReportsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            'Spending Breakdown',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 20),
          if (!hasData)
            const SizedBox(
              height: 180,
              child: Center(
                child: CustomText(
                  'No expenses for this period',
                  style: TextStyle(color: Colors.white54, fontSize: 14),
                ),
              ),
            )
          else ...[
            SizedBox(
              height: 180,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!
                            .touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 3,
                  centerSpaceRadius: 42,
                  sections: _buildSections(chartItems),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _PieChartLegend(items: chartItems, touchedIndex: touchedIndex),
          ],
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildSections(List<PieChartItem> items) {
    return List.generate(items.length, (i) {
      final isTouched = i == touchedIndex;
      final item = items[i];

      return PieChartSectionData(
        color: item.color,
        value: item.value,
        title: '${item.value.toInt()}%',
        radius: isTouched ? 58.0 : 50.0,
        titleStyle: TextStyle(
          fontSize: isTouched ? 16.0 : 12.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: const [Shadow(color: Colors.black45, blurRadius: 2)],
        ),
      );
    });
  }
}

class _PieChartLegend extends StatelessWidget {
  const _PieChartLegend({required this.items, required this.touchedIndex});

  final List<PieChartItem> items;
  final int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 10,
      alignment: WrapAlignment.start,
      children: items.asMap().entries.map((entry) {
        final isSelected = entry.key == touchedIndex;
        final item = entry.value;

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: item.color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            CustomText(
              item.title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? Colors.white : AppColors.text,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
