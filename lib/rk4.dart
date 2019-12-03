library rk4;

import 'package:flutter/foundation.dart';

typedef K1 = double Function(double x, double y);

typedef L1 = double Function(double x, double y, double yd);

// RK4运行的结果
class RK4Result {
  RK4Result({
    this.x,
    this.y,
  });
  final double x;
  final double y;
}

/// RK4方法类,具体的K1,K2,K3,K4,L1,L2,L3,L4
/// 含义请自己上浏览器查看龙格库塔方法
class RK4 {
  // 默认解析一阶微分方程
  RK4({
    @required double xInit,
    @required double yInit,
    double h,
    @required K1 k1,
    @required double criticalValue,
  })  : _x0 = xInit,
        _y0 = yInit,
        _h = h ?? 0.1,
        _k1 = k1,
        _cv = criticalValue,
        _z0 = 0;

  //解析二阶微分方程
  RK4.second({
    @required double xInit,
    @required double yInit,
    @required double yDInit,
    double h,
    @required L1 l1,
    @required double criticalValue,
  })  : _x0 = xInit,
        _y0 = yInit,
        _z0 = yDInit,
        _h = h ?? 0.1,
        _cv = criticalValue,
        _l1 = l1,
        _second = true;
  // x初始值
  final double _x0;
  // y初始值
  final double _y0;
  // y的导数的初始值
  final double _z0;
  // 步长
  final double _h;
  // 临界值
  final _cv;
  // 是否是二阶
  bool _second = false;
  K1 _k1;
  double _k2(x, y) => _k1(x + _h / 2, y + _h / 2 * _k1(x, y));
  double _k3(x, y) => _k1(x + _h / 2, y + _h / 2 * _k2(x, y));
  double _k4(x, y) => _k1(x + _h, y + _h * _k3(x, y));
  double _y(x, y) =>
      y + _h / 6 * (_k1(x, y) + 2 * _k2(x, y) + 2 * _k3(x, y) + _k4(x, y));

  // 下面是应用于二阶微分方程的
  double _k1_2(x, y, z) => z;
  double _k2_2(x, y, z) =>
      _k1_2(x + _h / 2, y + _h / 2 * _k1_2(x, y, z), z + _h / 2 * _l1(x, y, z));
  double _k3_2(x, y, z) =>
      _k1_2(x + _h / 2, y + _h / 2 * _k2_2(x, y, z), z + _h / 2 * _l2(x, y, z));
  double _k4_2(x, y, z) =>
      _k1_2(x + _h, y + _h * _k3_2(x, y, z), z + _h * _l3(x, y, z));
  L1 _l1;
  double _l2(x, y, z) =>
      _l1(x + _h / 2, y + _h / 2 * _k1_2(x, y, z), z + _h / 2 * _l1(x, y, z));
  double _l3(x, y, z) =>
      _l1(x + _h / 2, y + _h / 2 * _k2_2(x, y, z), z + _h / 2 * _l2(x, y, z));
  double _l4(x, y, z) =>
      _l1(x + _h, y + _h * _k3_2(x, y, z), z + _h * _l3(x, y, z));

  double _z(x, y, z) =>
      z +
          _h /
              6 *
              (_l1(x, y, z) + 2 * _l2(x, y, z) + 2 * _l3(x, y, z) + _l4(x, y, z));
  double _y_2(x, y, z) =>
      y +
          _h /
              6 *
              (_k1_2(x, y, z) +
                  2 * _k2_2(x, y, z) +
                  2 * _k3_2(x, y, z) +
                  _k4_2(x, y, z));

  Iterable<RK4Result> run() sync* {
    double x = _x0;
    double y = _y0;
    double z = _z0;
    while (x < _cv) {
      yield RK4Result(x: x, y: y);
      if (_second) {
        double __y = _y_2(x, y, z);
        z = _z(x, y, z);
        y = __y;
      } else {
        y = _y(x, y);
      }
      x += _h;
    }
  }
}