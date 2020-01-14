// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:digital_clock/clock_number.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum _Element {
  background,
  text,
  shadow,
}

class _Animation {
  static final anim_in = "in";
  static final anim_out = "out";
  static final anim_stop = "stop";
}

final _lightTheme = {
  _Element.background: Color(0xFF81B3FE),
  _Element.text: Colors.white,
  _Element.shadow: Colors.black,
};

final _darkTheme = {
  _Element.background: Color(0xFF2B173B),
  _Element.text: Colors.white,
  _Element.shadow: Color(0xFF2B173B),
};

/// A basic digital clock.
///
/// You can do better than this!
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
      // Update once per minute. If you want to update every second, use the
      // following code.
      _timer = Timer(
        Duration(minutes: 1) -
            Duration(seconds: _dateTime.second) -
            Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
      // Update once per second, but make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      // _timer = Timer(
      //   Duration(seconds: 1) - Duration(milliseconds: _dateTime.millisecond),
      //   _updateTime,
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = _darkTheme;
    // final colors = Theme.of(context).brightness == Brightness.light
    //     ? _lightTheme
    //     : _darkTheme;
    final hour =
        DateFormat(widget.model.is24HourFormat ? 'HH' : 'hh').format(_dateTime);
    final minute = DateFormat('mm').format(_dateTime);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    Widget _buildDateNumber(String flareFile, String flareAction) {
      return Container(
        width: width * 0.05,
        child: FlareActor(
          flareFile,
          alignment: Alignment.center,
          fit: BoxFit.contain,
          animation: flareAction,
        ),
      );
    }

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
                  rootWidth: width,
                  number: int.parse(hour[0]),
                ),
                ClockNumber(
                  rootWidth: width,
                  number: int.parse(hour[1]),
                ),
                SizedBox(width: 32),
                ClockNumber(
                  rootWidth: width,
                  number: int.parse(minute[0]),
                ),
                ClockNumber(
                  rootWidth: width,
                  number: int.parse(minute[1]),
                ),
              ],
            ),
          ),
          // TODO: Make this dynamic
          Container(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildDateNumber("assets/clock_0.flr", _Animation.anim_in),
                _buildDateNumber("assets/clock_1.flr", _Animation.anim_in),
                SizedBox(width: 32),
                _buildDateNumber("assets/clock_1.flr", _Animation.anim_in),
                _buildDateNumber("assets/clock_4.flr", _Animation.anim_in),
                SizedBox(width: 32),
                _buildDateNumber("assets/clock_2.flr", _Animation.anim_in),
                _buildDateNumber("assets/clock_0.flr", _Animation.anim_in),
                _buildDateNumber("assets/clock_2.flr", _Animation.anim_in),
                _buildDateNumber("assets/clock_0.flr", _Animation.anim_in),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
