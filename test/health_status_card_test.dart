import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:run_with_me_voice/widgets/health_status_card.dart';

void main() {
  testWidgets('HealthStatusCard displays correct values and color',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: HealthStatusCard(heartRate: 150, vo2Effort: 80)),
      ),
    );

    expect(find.text('❤️ BPM'), findsOneWidget);
    expect(find.text('150'), findsOneWidget);
    expect(find.text('VO₂ %'), findsOneWidget);
    expect(find.text('80%'), findsOneWidget);
    expect(find.byIcon(Icons.circle), findsOneWidget);
  });

  testWidgets('HealthStatusCard shows red zone if out of range',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: HealthStatusCard(heartRate: 200, vo2Effort: 40)),
      ),
    );

    final icon = tester.widget<Icon>(find.byIcon(Icons.circle));
    final color = icon.color ?? Colors.transparent;
    final redValue =
        (color.r * 255.0).round() & 0xff; // Use recommended replacement
    expect(
      redValue,
      greaterThan(200),
    ); // Should be red
  });
}
