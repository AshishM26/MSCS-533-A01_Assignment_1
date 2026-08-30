import '../models/conversion_unit.dart';

class ConversionService {
  const ConversionService();

  /// Converts through the category base unit after validating compatibility.
  double convert({
    required double value,
    required ConversionUnit from,
    required ConversionUnit to,
  }) {
    if (!value.isFinite) {
      throw ArgumentError.value(value, 'value', 'Value must be finite.');
    }
    if (from.category != to.category) {
      throw ArgumentError('Units must belong to the same category.');
    }

    final valueInBaseUnit = value * from.toBaseFactor;
    return valueInBaseUnit / to.toBaseFactor;
  }
}
