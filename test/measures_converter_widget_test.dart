import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:measures_converter/main.dart';

void main() {
  testWidgets('converts meters to feet and supports repeated input', (
    tester,
  ) async {
    await tester.pumpWidget(const MeasuresConverterApp());

    await tester.enterText(find.byKey(const Key('valueInput')), '100');
    await tester.tap(find.byKey(const Key('convertButton')));
    await tester.pump();

    expect(find.text('100 meters are 328.084 feet'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('valueInput')), '1');
    await tester.tap(find.byKey(const Key('convertButton')));
    await tester.pump();

    expect(find.text('1 meter is 3.28084 feet'), findsOneWidget);
  });

  testWidgets('shows an error for empty or invalid input', (tester) async {
    await tester.pumpWidget(const MeasuresConverterApp());

    await tester.tap(find.byKey(const Key('convertButton')));
    await tester.pump();
    expect(find.text('Enter a numeric value.'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('valueInput')), 'not a number');
    await tester.tap(find.byKey(const Key('convertButton')));
    await tester.pump();
    expect(find.text('Enter a numeric value.'), findsOneWidget);
  });

  testWidgets('limits destination units to the selected category', (
    tester,
  ) async {
    await tester.pumpWidget(const MeasuresConverterApp());

    await tester.tap(find.byKey(const Key('sourceDropdown')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('kilograms (kg)').last);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('destinationDropdown')));
    await tester.pumpAndSettle();

    expect(find.text('pounds (lb)'), findsOneWidget);
    expect(find.text('ounces (oz)'), findsOneWidget);
    expect(find.text('meters (m)'), findsNothing);
    expect(find.text('miles (mi)'), findsNothing);
  });
}
