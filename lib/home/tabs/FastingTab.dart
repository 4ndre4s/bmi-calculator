import 'package:flutter/material.dart';
import 'package:quiver/async.dart';

class FastingTab extends StatefulWidget {
  @override
  _FastingTabState createState() => _FastingTabState();
}

class _FastingTabState extends State<FastingTab> {
  TimeOfDay _startTime;
  int _intervalLength;

  int _start = 10;
  int _current = 10;

  void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: _start),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() {
        _current = _start - duration.elapsed.inSeconds;
      });
    });

    sub.onDone(() {
      print("Done");
      sub.cancel();
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(children: <Widget>[
          _buildTimePickerButton(
              "Fasten beginnt um?", _startTime, "Start", _updateStartTime)
        ]),
        Row(
          children: <Widget>[
            Text("Wie lange möchtest du fasten?"),
          ],
        ),
        Row(
          children: <Widget>[
            DropdownButton(
              hint: Text(_intervalLength != null
                  ? _intervalLength.toString() + "h"
                  : "Dauer"),
              items: List<int>.generate(8, (i) {
                return i + 16;
              }).map((hour) {
                return DropdownMenuItem(
                  value: hour.toString(),
                  child: Text(hour.toString() + "h"),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _intervalLength = int.parse(value);
                });
              },
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 200,
              height: 200,
              child: Stack(
                children: [
                  SizedBox.expand(
                    child: CircularProgressIndicator(
                      strokeWidth: 10,
                      value: 5 / 100,
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(_current.toString()),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  void _updateStartTime(time) {
    setState(() {
      _startTime = time;
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
