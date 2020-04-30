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

String getDeviceType(BuildContext context) {
  final double width = MediaQuery.of(context).size.width;

  // 1850x1440
  // 1850

  print('getDeviceType() size: ${MediaQuery.of(context).size}');

  // COL AL10
  // portrait xs 360.0x716.6666666666666 isLargeScreen false
  // landscape sm 687.0x360 isLargeScreen true

  String type = 'xs';

  // Extra small devices (portrait phones, less than 576px)
  // No media query for `xs` since this is the default in Bootstrap

  // Small devices (landscape phones, 576px and up)
  if (width >= 576) {
    type = 'sm';
  }

  // Medium devices (tablets, 768px and up)
  if (width >= 768) {
    type = 'md';
  }

  // Large devices (desktops, 992px and up)
  if (width >= 992) {
    type = 'lg';
  }

  // Extra large devices (large desktops, 1200px and up)
  if (width >= 1200) {
    type = 'xl';
  }

  print('getDeviceType() type: $type');

  return type;
}

double getScale(BuildContext context, String deviceType) {
  String currentDeviceType = getDeviceType(context);

  var minWidthMap = {'xl': 1200, 'lg': 992, 'md': 768, 'sm': 576, 'xs': 576};

  return minWidthMap[currentDeviceType] / minWidthMap[deviceType];
}

double getSize(BuildContext context, double size, String deviceType) {
  String currentDeviceType = getDeviceType(context);

  var minWidthMap = {'xl': 1200, 'lg': 992, 'md': 768, 'sm': 576, 'xs': 576};

  return size * minWidthMap[currentDeviceType] / minWidthMap[deviceType];
}

EdgeInsets EdgeInsets_fromLTRB(BuildContext context, String deviceType, double left, double top, double right, double bottom) {
  double l = getSize(context, left, deviceType);
  double t = getSize(context, top, deviceType);
  double r = getSize(context, right, deviceType);
  double b = getSize(context, bottom, deviceType);
  return EdgeInsets.fromLTRB(l, t, r, b);
}

EdgeInsets EdgeInsets_all(BuildContext context, String deviceType, double value) {
  double value = getSize(context, 72, deviceType);
  return EdgeInsets.all(value);
}