import 'package:flutter/material.dart';

import '../util.dart';

class SJScrollingMoudle extends StatelessWidget {

  bool debug = false;

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


  var breakpoints = {
    '0': 1250,
    '1': 1400,
    '2': 1850,
  };

  double _getTop(BuildContext context) {
    String deviceType = getDeviceType(context);

    // max 949
    // min 950 max 1249
    // min 1250 max 1399
    // min 1440 max 1849
    // min 1850

    // 1850x1440

    //rec <1250:4/8  >=1250:4/8    >=1850:5/10
    //top <1250:5/10  >=1250:5/10    >=1850:6/12
    //hit <1250:2  >=1250:3    >=1850:4

    // <1250:88 >=1250:116  >=1400:152
    // <1250:704 >=1250:884  >=1400:1002

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
      color: !debug ? Colors.transparent : Colors.green.withOpacity(0.5),
      padding: EdgeInsets.fromLTRB(0, _getTop(context), 0, _getBottom(context)),
      child: Container(
        color: !debug ? Colors.transparent : Colors.blue.withOpacity(0.5),
        width: _getWidth(context),
        child: Container(
          color: !debug ? Colors.transparent : Colors.orange.withOpacity(0.5),
          child: child,
        ),
      ),
    );
  }
}
