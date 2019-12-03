[English](./README.md) | 简体中文

# rk4

[![pub package](https://img.shields.io/pub/v/rk4.svg)](https://pub.dartlang.org/packages/rk4)

四阶龙格库塔法求解一阶和二阶线型微分方程


## 使用
要使用此插件包,请将`rk4`作为依赖项添加到您的`pubspec.yaml`文件中,详见[dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).


## 示例

``` dart
// 引入包
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
