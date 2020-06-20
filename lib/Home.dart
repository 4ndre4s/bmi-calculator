import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weightloss_mate/home/tabs/WeighingTab.dart';

import 'UserData.dart';
import 'home/tabs/DrinkingTab.dart';
import 'home/tabs/FastingTab.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = <Widget>[
    FastingTab(),
    DrinkingTab(),
    WeighingTab()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(),
      ),
      body: Container(
        child: _tabs.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.utensils), title: Text("Fasten")),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.glassWhiskey),
              title: Text("Trinken")),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.weight), title: Text("Wiegen"))
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

class AppBarTitle extends StatefulWidget {
  @override
  _AppBarTitleState createState() => _AppBarTitleState();
}

class _AppBarTitleState extends State<AppBarTitle> {
  Map<String, dynamic> _userData;

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
    if (_userData == null) {
      return Text("Hello!");
    }
    return Text("Howdy " + _userData['name'] + "!");
  }
}
