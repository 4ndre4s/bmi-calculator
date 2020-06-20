import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:weightloss_mate/Home.dart';

import 'UserData.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isUserdataEmpty;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Weightloss',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xff343434),
          accentColor: Color(0xff58B09C),
          fontFamily: 'Georgia',
        ),
        home: this._isUserdataEmpty == null
            ? Scaffold()
            : this._isUserdataEmpty ? WelcomeScreen() : Home());
  }

  @override
  initState() {
    super.initState();
    _setIsUserdataEmpty();
  }

  Future<void> _setIsUserdataEmpty() async {
    final bool isEmpty = await UserData.isEmpty();
    setState(() {
      this._isUserdataEmpty = isEmpty;
    });
  }
}

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _formKey = GlobalKey<FormState>();

  String _name;
  int _age;
  String _selectedGender;
  int _size;
  int _weight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("You are?"),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Row(children: <Widget>[
                  Flexible(
                      child: TextFormField(
                    decoration: InputDecoration(hintText: "Name"),
                    onChanged: (name) => setState(() {
                      _name = name;
                    }),
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter(RegExp("[a-zA-Z]"))
                    ],
                  )),
                  Spacer(),
                  Flexible(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: "Alter"),
                      onChanged: (age) => setState(() {
                        _age = int.parse(age);
                      }),
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                    ),
                  )
                ]),
                Row(children: <Widget>[
                  DropdownButton(
                    hint: Text(_selectedGender != null
                        ? _selectedGender
                        : "Geschlecht"),
                    items: <String>["männlich", "weiblich", "divers"]
                        .map((String gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  )
                ]),
                Row(children: <Widget>[
                  Flexible(
                      child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: "Größe (cm)"),
                    onChanged: (size) => setState(() {
                      _size = int.parse(size);
                    }),
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                  )),
                  Flexible(
                      child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: "Gewicht (kg)"),
                    onChanged: (weight) => setState(() {
                      _weight = int.parse(weight);
                    }),
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                  )),
                ]),
                Row(
                  children: <Widget>[
                    RaisedButton(
                      child: Text("Los geht's!"),
                      onPressed: () async {
                        UserData(_name, _age, _selectedGender, _size, _weight)
                            .persist();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
