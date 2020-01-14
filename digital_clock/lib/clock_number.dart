// Copyright 2020 Joshua de Guzman (https://joshuadeguzman.github.io). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

enum ClockNumberEnum {
  NAN,
  ZERO,
  ONE,
  TWO,
  THREE,
  FOUR,
  FIVE,
  SIX,
  SEVEN,
  EIGHT,
  NINE,
}

enum ClockNumberAnimationEnum { IN, OUT, STOP }

class ClockNumber extends StatefulWidget {
  final double width;
  final int number;

  const ClockNumber({
    Key key,
    @required this.width,
    @required this.number,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ClockNumberState();
  }
}

class ClockNumberState extends State<ClockNumber> {
  double get _width => widget.width;
  int get _number => widget.number;
  ClockNumberAnimationEnum clockNumberAnimationEnum =
      ClockNumberAnimationEnum.IN;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      child: FlareActor(
        _getFlareFile(_getEnumNumberEquivalent(_number)),
        alignment: Alignment.center,
        fit: BoxFit.contain,
        animation: _getFlareAnimation(clockNumberAnimationEnum),
      ),
    );
  }

  ClockNumberEnum _getEnumNumberEquivalent(int number) {
    switch (number) {
      case 0:
        return ClockNumberEnum.ZERO;
        break;
      case 1:
        return ClockNumberEnum.ONE;
        break;
      case 2:
        return ClockNumberEnum.TWO;
        break;
      case 3:
        return ClockNumberEnum.THREE;
        break;
      case 4:
        return ClockNumberEnum.FOUR;
        break;
      case 5:
        return ClockNumberEnum.FIVE;
        break;
      case 6:
        return ClockNumberEnum.SIX;
        break;
      case 7:
        return ClockNumberEnum.SEVEN;
        break;
      case 8:
        return ClockNumberEnum.EIGHT;
        break;
      case 9:
        return ClockNumberEnum.NINE;
        break;
      default:
        return ClockNumberEnum.NAN;
    }
  }

  String _getFlareFile(ClockNumberEnum clockNumberEnum) {
    switch (clockNumberEnum) {
      case ClockNumberEnum.ZERO:
        return "assets/clock_0.flr";
        break;
      case ClockNumberEnum.ONE:
        return "assets/clock_1.flr";
        break;
      case ClockNumberEnum.TWO:
        return "assets/clock_2.flr";
        break;
      case ClockNumberEnum.THREE:
        return "assets/clock_3.flr";
        break;
      case ClockNumberEnum.FOUR:
        return "assets/clock_4.flr";
        break;
      case ClockNumberEnum.FIVE:
        return "assets/clock_5.flr";
        break;
      case ClockNumberEnum.SIX:
        return "assets/clock_6.flr";
        break;
      case ClockNumberEnum.SEVEN:
        return "assets/clock_7.flr";
        break;
      case ClockNumberEnum.EIGHT:
        return "assets/clock_8.flr";
        break;
      case ClockNumberEnum.NINE:
        return "assets/clock_9.flr";
        break;
      default:
        throw Exception("Number invalid!");
    }
  }

  String _getFlareAnimation(ClockNumberAnimationEnum clockNumberAnimationEnum) {
    switch (clockNumberAnimationEnum) {
      case ClockNumberAnimationEnum.IN:
        return "in";
      case ClockNumberAnimationEnum.OUT:
        return "out";
      case ClockNumberAnimationEnum.STOP:
        return "stop";
    }
  }
}
