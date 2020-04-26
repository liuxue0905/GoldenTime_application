import 'package:flutter/material.dart';

import '../util.dart';

class SJScrollingMoudle extends StatelessWidget {
  /// mini huge small medium
  final String clazz;
  final Widget child;

  SJScrollingMoudle({Key key, this.clazz = 'medium', this.child})
      : super(key: key);

  double _getBottom(BuildContext context) {
    if (clazz == 'mini') {
      return 0;
    } else {
      return 32;
    }
  }

  double _getTop(BuildContext context) {
    String deviceType = getDeviceType(context);

    double top = 0;

    if (clazz == 'mini' || clazz == 'huge') {
      top = 32;
    } else {
      var tops = {'xs': 32.0, 'sm': 40.0, 'md': 88.0, 'lg': 116.0, 'xl': 152.0};
      top = tops[deviceType];
      if (top == null) {
        top = tops['xl'];
      }
    }
    return top;
  }

  double _getWidth(BuildContext context) {
    String deviceType = getDeviceType(context);
    var widths = {
      'xs': 604.0,
      'sm': 604.0,
      'md': 704.0,
      'lg': 884.0,
      'xl': 1002.0
    };
    double width = widths[deviceType];
    if (width == null) {
      width = widths['xl'];
    }
    return width;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.green.withOpacity(0.5),
      padding: EdgeInsets.fromLTRB(0, _getTop(context), 0, _getBottom(context)),
      child: Container(
        color: Colors.blue.withOpacity(0.5),
        width: _getWidth(context),
        child: Container(
          color: Colors.orange.withOpacity(0.5),
          child: child,
        ),
      ),
    );
  }
}
