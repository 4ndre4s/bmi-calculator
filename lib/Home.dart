import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'UserData.dart';

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
              icon: FaIcon(FontAwesomeIcons.utensils), title: Text("Fasting")),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.glassWhiskey),
              title: Text("Drinking")),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.weight), title: Text("Weighing"))
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

class FastingTab extends StatefulWidget {
  @override
  _FastingTabState createState() => _FastingTabState();
}

class _FastingTabState extends State<FastingTab> {
  TimeOfDay _startTime;
  TimeOfDay _endTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildTimePickerButton(
            "Pick start time!", _startTime, "Start", _updateStartTime),
        _buildTimePickerButton(
            "Pick end time!", _endTime, "End", _updateEndTime)
      ],
    );
  }

  void _updateStartTime(time) {
    setState(() {
      _startTime = time;
    });
  }

  void _updateEndTime(time) {
    setState(() {
      _endTime = time;
    });
  }

  String formatTime(int time) {
    final String timeString = time.toString();
    return (time < 10 ? "0" + timeString : timeString);
  }

  _buildTimePickerButton(String initialText, TimeOfDay timeOfDay, String suffix,
      Function updateFunction) {
    return FlatButton(
      child: Text(timeOfDay == null
          ? initialText
          : suffix +
              ": " +
              formatTime(timeOfDay.hour) +
              ":" +
              formatTime(timeOfDay.minute)),
      onPressed: () async {
        final pickedTime = await showTimePicker(
            context: (context),
            initialTime: TimeOfDay.now(),
            builder: (BuildContext context, Widget child) {
              return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: true),
                child: child,
              );
            });
        updateFunction(pickedTime);
      },
    );
  }
}

class DrinkingTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column();
  }
}

class WeighingTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column();
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
