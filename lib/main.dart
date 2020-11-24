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

  String targetCurrency = 'EUR';

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
              Image.network(
                  'https://media3.s-nbcnews.com/j/newscms/2019_06/2746941/190208-stock-money-fanned-out-ew-317p_fa445b2f6f3e86a3ffa18707e6a8adcb.fit-2000w.jpg'),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: DropdownButton<String>(
                        onChanged: (String newValue) {
                          setState(() {});
                        },
                        value: 'RON',
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        items: <String>['RON', 'EUR', 'USD']
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
                          });
                        },
                        value: 'EUR',
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
                    hintText: 'Amount',
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
