import 'package:flutter/material.dart';

import 'models/conversion_unit.dart';
import 'services/conversion_service.dart';

void main() {
  runApp(const MeasuresConverterApp());
}

class MeasuresConverterApp extends StatelessWidget {
  const MeasuresConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Measures Converter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const MeasuresConverterPage(),
    );
  }
}

class MeasuresConverterPage extends StatefulWidget {
  const MeasuresConverterPage({super.key});

  @override
  State<MeasuresConverterPage> createState() => _MeasuresConverterPageState();
}

class _MeasuresConverterPageState extends State<MeasuresConverterPage> {
  final TextEditingController _valueController = TextEditingController();
  final ConversionService _conversionService = const ConversionService();

  ConversionUnit _sourceUnit = ConversionUnit.meters;
  ConversionUnit _destinationUnit = ConversionUnit.feet;
  String? _inputError;
  String? _result;

  List<ConversionUnit> get _destinationUnits =>
      ConversionUnit.unitsFor(_sourceUnit.category);

  @override
  void dispose() {
    _valueController.dispose();
    super.dispose();
  }

  void _changeSourceUnit(ConversionUnit? unit) {
    if (unit == null) {
      return;
    }

    setState(() {
      _sourceUnit = unit;
      if (_destinationUnit.category != unit.category) {
        _destinationUnit = ConversionUnit.unitsFor(unit.category)
            .firstWhere((candidate) => candidate != unit, orElse: () => unit);
      }
      _inputError = null;
      _result = null;
    });
  }

  void _convert() {
    final input = double.tryParse(_valueController.text.trim());

    if (input == null || !input.isFinite) {
      setState(() {
        _inputError = 'Enter a numeric value.';
        _result = null;
      });
      return;
    }

    final convertedValue = _conversionService.convert(
      value: input,
      from: _sourceUnit,
      to: _destinationUnit,
    );

    setState(() {
      _inputError = null;
      final sourceLabel = _sourceUnit.labelFor(input);
      final destinationLabel = _destinationUnit.labelFor(convertedValue);
      final verb = input.abs() == 1 ? 'is' : 'are';
      _result =
          '${_formatNumber(input)} $sourceLabel $verb '
          '${_formatNumber(convertedValue)} $destinationLabel';
    });
  }

  String _formatNumber(double value) {
    final absoluteValue = value.abs();
    final decimalPlaces = switch (absoluteValue) {
      >= 100 => 3,
      >= 1 => 6,
      _ => 8,
    };

    return value
        .toStringAsFixed(decimalPlaces)
        .replaceFirst(RegExp(r'\.?0+$'), '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Measures Converter'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Convert a measurement',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Choose compatible length or mass units.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 24),
                      TextField(
                        key: const Key('valueInput'),
                        controller: _valueController,
                        decoration: InputDecoration(
                          labelText: 'Value',
                          hintText: 'Enter a number',
                          errorText: _inputError,
                          border: const OutlineInputBorder(),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                          signed: true,
                        ),
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => _convert(),
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<ConversionUnit>(
                        key: const Key('sourceDropdown'),
                        initialValue: _sourceUnit,
                        decoration: const InputDecoration(
                          labelText: 'From',
                          border: OutlineInputBorder(),
                        ),
                        items: ConversionUnit.all
                            .map(
                              (unit) => DropdownMenuItem(
                                value: unit,
                                child: Text('${unit.name} (${unit.symbol})'),
                              ),
                            )
                            .toList(),
                        onChanged: _changeSourceUnit,
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<ConversionUnit>(
                        key: const Key('destinationDropdown'),
                        initialValue: _destinationUnit,
                        decoration: const InputDecoration(
                          labelText: 'To',
                          border: OutlineInputBorder(),
                        ),
                        items: _destinationUnits
                            .map(
                              (unit) => DropdownMenuItem(
                                value: unit,
                                child: Text('${unit.name} (${unit.symbol})'),
                              ),
                            )
                            .toList(),
                        onChanged: (unit) {
                          if (unit == null) {
                            return;
                          }
                          setState(() {
                            _destinationUnit = unit;
                            _result = null;
                          });
                        },
                      ),
                      const SizedBox(height: 24),
                      FilledButton.icon(
                        key: const Key('convertButton'),
                        onPressed: _convert,
                        icon: const Icon(Icons.swap_horiz),
                        label: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          child: Text('Convert'),
                        ),
                      ),
                      if (_result != null) ...[
                        const SizedBox(height: 24),
                        Semantics(
                          liveRegion: true,
                          child: Container(
                            key: const Key('resultContainer'),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              _result!,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
