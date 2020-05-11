import 'package:flutter/material.dart';

bool isLargeScreen(BuildContext context) {
  return MediaQuery.of(context).size.width > 600;
}

EdgeInsets EdgeInsets_fromLTRB(BuildContext context, double size, double left,
    double top, double right, double bottom) {
  double l = scaleSize(context, size, left);
  double t = scaleSize(context, size, top);
  double r = scaleSize(context, size, right);
  double b = scaleSize(context, size, bottom);
  return EdgeInsets.fromLTRB(l, t, r, b);
}

EdgeInsets EdgeInsets_all(BuildContext context, double size, double value) {
  return EdgeInsets.all(scaleSize(context, size, value));
}

EdgeInsets EdgeInsets_only(
  BuildContext context,
  double size, {
  double left = 0.0,
  double top = 0.0,
  double right = 0.0,
  double bottom = 0.0,
}) {
  double l = scaleSize(context, size, left);
  double t = scaleSize(context, size, top);
  double r = scaleSize(context, size, right);
  double b = scaleSize(context, size, bottom);
  return EdgeInsets.only(left: l, top: t, right: r, bottom: b);
}

Brightness getBrightness(Color color) {
  double luminance = color.computeLuminance();
  if (luminance >= 0.5) {
    return Brightness.light;
  } else if (luminance < 0.5) {
    return Brightness.dark;
  }
  return Brightness.light;
}

// https://baike.baidu.com/item/%E5%88%86%E8%BE%A8%E7%8E%87/213523#1

// [0, 950)
// [950, 1250)
// [1250, 1400)
// [1400, 1850)
// [1850, infinity)

// max 949
// min 950 max 1249
// min 1250 max 1399
// min 1400 max 1849
// min 1850

//now <1400:2/10 >=1400:3/10
//rec <1250:4/8  >=1250:4/8    >=1850:5/10
//top <1250:5/10  >=1250:5/10    >=1850:6/12
//hit <1250:2  >=1250:3    >=1850:4

// sj_scrolling_moudle.dart
// history now 32
// <1250:88 >=1250:116  >=1400:152
// <1250:704 >=1250:884  >=1400:1002  >=1850:1404

T querySize<T>(BuildContext context, Map<double, T> parameters,
    [Axis axis = Axis.horizontal]) {
  bool debug = false;

  if (debug) {
    print('querySize parameters:${parameters}');
  }

  if (parameters == null && parameters.length != 0) {
    return null;
  }

  List<double> keys = parameters.keys.toList()..sort();

  Size screenSize = MediaQuery.of(context).size;
  double axisSize = screenSize.width;
  if (axis == Axis.horizontal) {
    axisSize = screenSize.width;
  } else if (axis == Axis.vertical) {
    axisSize = screenSize.height;
  }

  T result;
  for (int i = 0; i < keys.length; i++) {
    double key = keys[i];
    result = parameters[key];

    if (key > axisSize) {
      break;
    }
  }
  if (debug) {
    print('querySize parameters.keys:${parameters.keys}');
    print('querySize keys:${keys}');
    print('querySize screenSize:${screenSize}');
    print('querySize result:${result}');
  }
  return result;
}

double scaleSize(BuildContext context, double size, double value,
    [Axis axis = Axis.horizontal]) {
  bool debug = false;

  Size screenSize = MediaQuery.of(context).size;
  double axisSize = screenSize.width;
  if (axis == Axis.horizontal) {
    axisSize = screenSize.width;
  } else if (axis == Axis.vertical) {
    axisSize = screenSize.height;
  }

  if (debug) {
    print('scaleSize size:${size} value:${value}');
    print('scaleSize ${axisSize}:${size} - ${axisSize / size}');
    print('scaleSize ${size}:${axisSize} - ${size / axisSize}');
    print('scaleSize result:${value * axisSize / size}');
  }

  return value * axisSize / size;
}

EdgeInsets getListContainerMargin(BuildContext context) {
  var _margin = EdgeInsets.fromLTRB(96, 32, 96, 32);

  if (MediaQuery.of(context).size.width < 950) {
    _margin = EdgeInsets_fromLTRB(context, 950, 96, 32, 96, 32);
  }

  if (MediaQuery.of(context).size.width < 450) {
    _margin = EdgeInsets.fromLTRB(16, 16, 16, 16);
  }

  return _margin;
}

EdgeInsets getDetailContainerMargin(BuildContext context) {
  var _margin = EdgeInsets.fromLTRB(96, 32, 96, 32);

  if (MediaQuery.of(context).size.width < 950) {
    _margin = EdgeInsets_fromLTRB(context, 950, 96, 32, 96, 32);
  }

  if (!isLargeScreen(context)) {
    _margin = EdgeInsets.fromLTRB(0, 0, 0, 0);
  }

  return _margin;
}