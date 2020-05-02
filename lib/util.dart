import 'package:flutter/material.dart';

bool isLargeScreen(BuildContext context) {
  bool isLargeScreen = false;

  if (MediaQuery.of(context).size.width > 600) {
    isLargeScreen = true;
  } else {
    isLargeScreen = false;
  }

  print('isLargeScreen() isLargeScreen: $isLargeScreen');

  return isLargeScreen;
}

//String getDeviceType(BuildContext context) {
//  final double width = MediaQuery.of(context).size.width;
//
//  // 1850x1440
//  // 1850
//
//  print('getDeviceType() size: ${MediaQuery.of(context).size}');
//
//  // COL AL10
//  // portrait xs 360.0x716.6666666666666 isLargeScreen false
//  // landscape sm 687.0x360 isLargeScreen true
//
//  String type = 'xs';
//
//  // Extra small devices (portrait phones, less than 576px)
//  // No media query for `xs` since this is the default in Bootstrap
//
//  // Small devices (landscape phones, 576px and up)
//  if (width >= 576) {
//    type = 'sm';
//  }
//
//  // Medium devices (tablets, 768px and up)
//  if (width >= 768) {
//    type = 'md';
//  }
//
//  // Large devices (desktops, 992px and up)
//  if (width >= 992) {
//    type = 'lg';
//  }
//
//  // Extra large devices (large desktops, 1200px and up)
//  if (width >= 1200) {
//    type = 'xl';
//  }
//
//  print('getDeviceType() type: $type');
//
//  return type;
//}

double getSize(BuildContext context, double size, String deviceType) {
//  String currentDeviceType = getDeviceType(context);
  String currentDeviceType = 'sm';

  var minWidthMap = {'xl': 1200, 'lg': 992, 'md': 768, 'sm': 576, 'xs': 576};

  return size * minWidthMap[currentDeviceType] / minWidthMap[deviceType];
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
// <1250:704 >=1250:884  >=1400:1002

T querySize<T>(BuildContext context, Map<double, T> parameters,
    [Axis axis = Axis.horizontal]) {
  print('querySize parameters:${parameters}');

  if (parameters == null && parameters.length != 0) {
    return null;
  }

  print('querySize parameters.keys:${parameters.keys}');

  List<double> keys = parameters.keys.toList()..sort();

  print('querySize keys:${keys}');

  Size screenSize = MediaQuery.of(context).size;
  double axisSize = screenSize.width;
  if (axis == Axis.horizontal) {
    axisSize = screenSize.width;
  } else if (axis == Axis.vertical) {
    axisSize = screenSize.height;
  }

  print('querySize screenSize:${screenSize}');

  T result;
  for (int i = 0; i < keys.length; i++) {
    double key = keys[i];
    result = parameters[key];

    if (key > axisSize) {
      break;
    }
  }
  print('querySize result:${result}');
  return result;
}

double scaleSize(BuildContext context, double size, double value,
    [Axis axis = Axis.horizontal]) {
  print('scaleSize size:${size} value:${value}');

  Size screenSize = MediaQuery.of(context).size;
  double axisSize = screenSize.width;
  if (axis == Axis.horizontal) {
    axisSize = screenSize.width;
  } else if (axis == Axis.vertical) {
    axisSize = screenSize.height;
  }

  print('scaleSize ${axisSize}:${size}');
  print('scaleSize result:${value * axisSize / size}');

  return value * axisSize / size;
}
