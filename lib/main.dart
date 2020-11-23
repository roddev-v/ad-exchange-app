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
  double rate = 4.5;
  double convertedAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Currency convertor'),
          centerTitle: true,
        ),
        body: Padding(
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              TextField(
                onChanged: (String value) {
                  print(value.trim());
                  setState(() {
                    convertedAmount = double.parse(value) * rate;
                  });
                },
                decoration: const InputDecoration(hintText: 'Amount'),
                keyboardType: TextInputType.number,
              ),
              Center(
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '$convertedAmount EUR',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      )))
            ],
          ),
          padding: const EdgeInsets.all(10.0),
        ));
  }
}
