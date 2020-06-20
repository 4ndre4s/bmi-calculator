import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weightloss_mate/UserData.dart';

class WeighingTab extends StatefulWidget {
  @override
  _WeighingTabState createState() => _WeighingTabState();
}

class _WeighingTabState extends State<WeighingTab> {
  Map<String, dynamic> _userData;

  int _weight;

  @override
  void initState() {
    super.initState();
    _setUserData();
  }

  void _setUserData() async {
    final userData = await UserData.getData();
    setState(() {
      _userData = userData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(children: <Widget>[
            FaIcon(FontAwesomeIcons.rulerVertical),
            Text(_userData != null
                ? " Your size: " + _userData["size"].toString() + " cm"
                : ""),
          ]),
          Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "Your current weight"),
                  onChanged: (newWeight) {
                    setState(() {
                      _weight = int.parse(newWeight);
                    });
                  },
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _weight != null
                  ? Text(
                      "Body Mass Index: " + getBmi(),
                      style: TextStyle(fontSize: 30),
                    )
                  : Column()
            ],
          )
        ],
      ),
    );
  }

  String getBmi() {
    return (_weight / (_userData["size"] * _userData["size"]) * 10000)
        .toStringAsFixed(1);
  }
}
