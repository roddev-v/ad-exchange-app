import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(CurrencyConvertor());

class CurrencyConvertor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Convertor(),
    );
  }
}

class Convertor extends StatefulWidget {
  @override
  _ConvertorState createState() => _ConvertorState();
}

class _ConvertorState extends State<Convertor> {
  bool isValid = false;
  double rate = 4.5;
  double convertedAmount = 0.0;

  String sourceCurrency = 'RON';
  String targetCurrency = 'EUR';

  String imageUrl =
      'https://media3.s-nbcnews.com/j/newscms/2019_06/2746941/190208-stock-money-fanned-out-ew-317p_fa445b2f6f3e86a3ffa18707e6a8adcb.fit-2000w.jpg';

  void updateRate() {
    final String code = '$sourceCurrency-$targetCurrency';
    print(code);
    if (code == 'RON-EUR') {
      rate = 4.5;
    } else if (code == 'RON-USD') {
      rate = 4.4;
    } else if (code == 'GBP-EUR') {
      rate = 1.1;
    } else {
      rate = 1.2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Currency convertor'),
          centerTitle: true,
        ),
        body: Padding(
          child: Column(
            children: <Widget>[
              Image.network(imageUrl),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: DropdownButton<String>(
                        onChanged: (String newValue) {
                          setState(() {
                            sourceCurrency = newValue;
                            updateRate();
                          });
                        },
                        value: sourceCurrency,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        items: <String>['RON', 'GBP']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: DropdownButton<String>(
                        onChanged: (String newValue) {
                          setState(() {
                            targetCurrency = newValue;
                            updateRate();
                          });
                        },
                        value: targetCurrency,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        items: <String>['EUR', 'USD']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              TextField(
                onChanged: (String value) {
                  setState(() {
                    print(value);
                    if (isNumeric(value) || value == '0.0') {
                      isValid = true;
                      convertedAmount = double.parse(value) * rate;
                      print(convertedAmount);
                      return;
                    }

                    if (value == '') {
                      convertedAmount = 0;
                    }
                    isValid = false;
                  });
                },
                decoration: InputDecoration(
                    prefix: Text(sourceCurrency),
                    errorText: !isValid ? 'Enter a valid number' : null),
                keyboardType: TextInputType.number,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    '$convertedAmount $targetCurrency',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              )
            ],
          ),
          padding: const EdgeInsets.all(10.0),
        ));
  }
}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}
