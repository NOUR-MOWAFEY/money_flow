import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money_flow/features/reports/data/models/pie_chart_item.dart';
import 'package:money_flow/features/reports/views/widgets/reports_pie_chart.dart';

void main() {
  testWidgets('ReportsPieChart renders long category names without overflow',
      (tester) async {
    final items = [
      PieChartItem(
        title: 'Very Long Category Name That Would Previously Overflow The Row In Breakdown',
        value: 50.0,
        color: Colors.red,
      ),
      PieChartItem(
        title: 'Environment: Summer Vacation Shopping Fund',
        value: 30.0,
        color: Colors.blue,
      ),
      PieChartItem(
        title: 'Food',
        value: 20.0,
        color: Colors.green,
      ),
    ];

    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: ReportsPieChart(items: items),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('Spending Breakdown'), findsOneWidget);
    expect(find.byType(ReportsPieChart), findsOneWidget);
  });
}
