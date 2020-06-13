import 'package:flutter/material.dart';

class BmiCalculator extends StatefulWidget {
  @override
  _BmiCalculatorState createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  String _bodyMassIndex;

  final _sizeController = TextEditingController();

  final _weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Fitness App'), actions: [
          IconButton(
            icon: Icon(Icons.announcement),
            onPressed: () {
              showAboutDialog(
                  context: context, applicationVersion: "Version 1.0");
            },
          )
        ]),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    Flexible(
                        child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _weightController,
                            decoration: InputDecoration(hintText: "Weight"))),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                        child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _sizeController,
                            decoration: InputDecoration(hintText: "Size"))),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RaisedButton(
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        final sizeString = _sizeController.text;
                        final weightString = _weightController.text;
                        if (sizeString.isEmpty) return;
                        if (weightString.isEmpty) return;
                        setState(() {
                          _bodyMassIndex = calculateBodyMassIndex(
                                  double.parse(sizeString),
                                  double.parse(weightString))
                              .toStringAsFixed(2);
                        });
                      },
                      child: Text("Calculate"),
                    )
                  ],
                )
              ]),
              _bodyMassIndex != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "BMI: " + _bodyMassIndex,
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    )
                  : Row()
            ],
          ),
        ));
  }

  double calculateBodyMassIndex(size, weight) {
    return weight / (size * size) * 10000;
  }
}
