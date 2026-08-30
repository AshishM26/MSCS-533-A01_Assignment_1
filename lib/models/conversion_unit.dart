enum MeasurementCategory { length, mass }

class ConversionUnit {
  const ConversionUnit({
    required this.name,
    required this.singularName,
    required this.symbol,
    required this.category,
    required this.toBaseFactor,
  });

  final String name;
  final String singularName;
  final String symbol;
  final MeasurementCategory category;

  /// Number of category base units represented by one source unit.
  final double toBaseFactor;

  String labelFor(double value) => value.abs() == 1 ? singularName : name;

  static const meters = ConversionUnit(
    name: 'meters',
    singularName: 'meter',
    symbol: 'm',
    category: MeasurementCategory.length,
    toBaseFactor: 1,
  );

  static const kilometers = ConversionUnit(
    name: 'kilometers',
    singularName: 'kilometer',
    symbol: 'km',
    category: MeasurementCategory.length,
    toBaseFactor: 1000,
  );

  static const feet = ConversionUnit(
    name: 'feet',
    singularName: 'foot',
    symbol: 'ft',
    category: MeasurementCategory.length,
    toBaseFactor: 0.3048,
  );

  static const miles = ConversionUnit(
    name: 'miles',
    singularName: 'mile',
    symbol: 'mi',
    category: MeasurementCategory.length,
    toBaseFactor: 1609.344,
  );

  static const kilograms = ConversionUnit(
    name: 'kilograms',
    singularName: 'kilogram',
    symbol: 'kg',
    category: MeasurementCategory.mass,
    toBaseFactor: 1,
  );

  static const grams = ConversionUnit(
    name: 'grams',
    singularName: 'gram',
    symbol: 'g',
    category: MeasurementCategory.mass,
    toBaseFactor: 0.001,
  );

  static const pounds = ConversionUnit(
    name: 'pounds',
    singularName: 'pound',
    symbol: 'lb',
    category: MeasurementCategory.mass,
    toBaseFactor: 0.45359237,
  );

  static const ounces = ConversionUnit(
    name: 'ounces',
    singularName: 'ounce',
    symbol: 'oz',
    category: MeasurementCategory.mass,
    toBaseFactor: 0.028349523125,
  );

  static const all = <ConversionUnit>[
    meters,
    kilometers,
    feet,
    miles,
    kilograms,
    grams,
    pounds,
    ounces,
  ];

  static List<ConversionUnit> unitsFor(MeasurementCategory category) =>
      all.where((unit) => unit.category == category).toList(growable: false);
}
