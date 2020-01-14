// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'package:digital_clock/clock_number.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum _Element {
  background,
  text,
  shadow,
}

final _lightTheme = {
  _Element.background: Color(0xFF3e206d),
  _Element.text: Colors.white,
  _Element.shadow: Colors.black,
};

final _darkTheme = {
  _Element.background: Color(0xFF2B173B),
  _Element.text: Colors.white,
  _Element.shadow: Colors.black,
};

class DigitalClock extends StatefulWidget {
  const DigitalClock(this.model);

  final ClockModel model;

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  DateTime _dateTime = DateTime.now();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(DigitalClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      // Cause the clock to rebuild when the model changes.
    });
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();

      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).brightness == Brightness.light
        ? _lightTheme
        : _darkTheme;

    // Time
    final hour =
        DateFormat(widget.model.is24HourFormat ? 'HH' : 'hh').format(_dateTime);
    final minute = DateFormat('mm').format(_dateTime);
    final seconds = DateFormat('ss').format(_dateTime);
    final height = MediaQuery.of(context).size.height;

    // Date
    final month = DateFormat('MM').format(_dateTime);
    final day = DateFormat('dd').format(_dateTime);
    final year = DateFormat('yyyy').format(_dateTime);

    // Sizes
    final width = MediaQuery.of(context).size.width;
    final timeNumberWidth = width * 0.10;
    final dateNumberWidth = width * 0.05;

    return Container(
      height: height,
      width: width,
      color: colors[_Element.background],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: height * 0.50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClockNumber(
                  width: timeNumberWidth,
                  number: int.parse(hour[0]),
                ),
                ClockNumber(
                  width: timeNumberWidth,
                  number: int.parse(hour[1]),
                ),
                SizedBox(width: 16),
                ClockNumber(
                  width: timeNumberWidth,
                  number: int.parse(minute[0]),
                ),
                ClockNumber(
                  width: timeNumberWidth,
                  number: int.parse(minute[1]),
                ),
                SizedBox(width: 32),
                ClockNumber(
                  width: timeNumberWidth,
                  number: int.parse(seconds[0]),
                ),
                ClockNumber(
                  width: timeNumberWidth,
                  number: int.parse(seconds[1]),
                ),
              ],
            ),
          ),
          Container(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClockNumber(
                  width: dateNumberWidth,
                  number: int.parse(month[0]),
                ),
                ClockNumber(
                  width: dateNumberWidth,
                  number: int.parse(month[1]),
                ),
                SizedBox(width: 32),
                ClockNumber(
                  width: dateNumberWidth,
                  number: int.parse(day[0]),
                ),
                ClockNumber(
                  width: dateNumberWidth,
                  number: int.parse(day[1]),
                ),
                SizedBox(width: 32),
                ClockNumber(
                  width: dateNumberWidth,
                  number: int.parse(year[0]),
                ),
                ClockNumber(
                  width: dateNumberWidth,
                  number: int.parse(year[1]),
                ),
                ClockNumber(
                  width: dateNumberWidth,
                  number: int.parse(year[2]),
                ),
                ClockNumber(
                  width: dateNumberWidth,
                  number: int.parse(year[3]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
