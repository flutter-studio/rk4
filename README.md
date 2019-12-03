English | [简体中文](./README_zh-CN.md)

# rk4

[![pub package](https://img.shields.io/pub/v/rk4.svg)](https://pub.dartlang.org/packages/rk4)

The fourth order runge kutta method is used to solve the first and second order differential equations

## Usage
To use this plugin, add `rk4` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).


## Example

``` dart
// Import package
import 'package:rk4/rk4.dart';
import 'package:flutter/material.dart';

 RK4(
    xInit: 0,
    yInit: 0,
    criticalValue: 1,
    k1: (x, y) => 1 - y,
  ).run().forEach((rr) {
    print("------ x: ${rr.x} y: ${rr.y}");
  });

  RK4
      .second(
        xInit: 0,
        yInit: -0.4,
        yDInit: -0.6,
        l1: (x, y, yd) => pow(e, 2 * x) * sin(x) - 2 * y + 2 * yd,
        criticalValue: 1,
      )
      .run()
      .forEach((rr) {
    print("------ x: ${rr.x} y: ${rr.y}");
  });
```

