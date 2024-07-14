import 'package:flutter/material.dart';

void main() {
  runApp(CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: CurrencyConverterScreen(),
    );
  }
}

class CurrencyConverterScreen extends StatefulWidget {
  @override
  _CurrencyConverterScreenState createState() => _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final TextEditingController _controller = TextEditingController();
  String _convertedAmount = '';
  String _selectedCurrency = 'USD';
  double _conversionRate = 0.0;

  final Map<String, double> _conversionRates = {
    'USD': 1.0,
    'EUR': 0.85,
    'GBP': 0.75,
    'INR': 74.0,
  };

  void _convertCurrency() {
    String input = _controller.text;
    double? amount = double.tryParse(input);

    if (amount != null) {
      double convertedAmount = amount * _conversionRate;
      setState(() {
        _convertedAmount = convertedAmount.toStringAsFixed(2);
      });
      print('Input amount: $amount');
      print('Conversion rate: $_conversionRate');
      print('Converted amount: $convertedAmount');
    } else {
      setState(() {
        _convertedAmount = 'Invalid input';
      });
      print('Invalid input: $input');
    }
  }

  @override
  void initState() {
    super.initState();
    _conversionRate = _conversionRates[_selectedCurrency]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade200, Colors.teal.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount in USD',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16.0),
              DropdownButton<String>(
                value: _selectedCurrency,
                dropdownColor: Colors.teal,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCurrency = newValue!;
                    _conversionRate = _conversionRates[_selectedCurrency]!;
                    print('Selected currency: $_selectedCurrency');
                    print('New conversion rate: $_conversionRate');
                  });
                },
                items: _conversionRates.keys.map((String currency) {
                  return DropdownMenuItem<String>(
                    value: currency,
                    child: Text(
                      currency,
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _convertCurrency,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.teal,
                  textStyle: TextStyle(fontSize: 16),
                ),
                child: Text('Convert'),
              ),
              SizedBox(height: 16.0),
              Text(
                'Converted Amount: $_convertedAmount $_selectedCurrency',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
