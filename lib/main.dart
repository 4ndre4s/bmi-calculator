import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'BMI-Calculator',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Color(0xff343434),
          accentColor: Color(0xff58B09C),
          fontFamily: 'Georgia',
        ),
        home: HomeWidget());
  }
}

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  String _bodyMassIndex;

  final _sizeController = TextEditingController();

  final _weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('BMI-Calculator'), actions: [
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
