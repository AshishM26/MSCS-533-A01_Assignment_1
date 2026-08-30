import 'package:flutter_test/flutter_test.dart';
import 'package:measures_converter/models/conversion_unit.dart';
import 'package:measures_converter/services/conversion_service.dart';

void main() {
  const service = ConversionService();

  group('ConversionService', () {
    test('converts 100 meters to feet', () {
      final result = service.convert(
        value: 100,
        from: ConversionUnit.meters,
        to: ConversionUnit.feet,
      );

      expect(result, closeTo(328.084, 0.001));
    });

    test('converts 1 mile to kilometers', () {
      final result = service.convert(
        value: 1,
        from: ConversionUnit.miles,
        to: ConversionUnit.kilometers,
      );

      expect(result, closeTo(1.609344, 0.0000001));
    });

    test('converts 1 kilogram to pounds', () {
      final result = service.convert(
        value: 1,
        from: ConversionUnit.kilograms,
        to: ConversionUnit.pounds,
      );

      expect(result, closeTo(2.204623, 0.000001));
    });

    test('converts 1 pound to kilograms', () {
      final result = service.convert(
        value: 1,
        from: ConversionUnit.pounds,
        to: ConversionUnit.kilograms,
      );

      expect(result, closeTo(0.45359237, 0.00000001));
    });

    test('returns the original value for a same-unit conversion', () {
      final result = service.convert(
        value: 42.5,
        from: ConversionUnit.ounces,
        to: ConversionUnit.ounces,
      );

      expect(result, 42.5);
    });

    test('converts feet to meters', () {
      final result = service.convert(
        value: 10,
        from: ConversionUnit.feet,
        to: ConversionUnit.meters,
      );

      expect(result, closeTo(3.048, 0.0000001));
    });

    test('converts grams to ounces', () {
      final result = service.convert(
        value: 100,
        from: ConversionUnit.grams,
        to: ConversionUnit.ounces,
      );

      expect(result, closeTo(3.527396, 0.000001));
    });

    test('rejects conversions between different categories', () {
      expect(
        () => service.convert(
          value: 1,
          from: ConversionUnit.meters,
          to: ConversionUnit.pounds,
        ),
        throwsArgumentError,
      );
    });
  });
}
