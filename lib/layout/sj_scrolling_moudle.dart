import 'package:flutter/material.dart';
import 'package:flutter_app_golden_time/model/module.dart';

import '../util.dart';

class SJScrollingMoudle extends StatelessWidget {
  bool debug = false;

  final String moduleType;
  final Widget child;

  SJScrollingMoudle({Key key, this.moduleType, this.child})
      : super(key: key);

  double _getBottom(BuildContext context) {
    if (moduleType == Module.MODULE_TOKEN_RECENT) {
      return 0;
    } else {
      return 32;
    }
  }

  double _getTop(BuildContext context) {
    double top = 0;
    if (moduleType == Module.MODULE_TOKEN_RECENT || moduleType == Module.MODULE_TOKEN_NOW) {
      top = 32;
    } else {
      top = querySize<double>(context, {950: 88, 1250: 116, 1400: 152});

      if (MediaQuery.of(context).size.width < 950) {
        top = scaleSize(context, 950, 88);
      }
    }
    return top;
  }

  double _getWidth(BuildContext context) {
    return querySize<double>(context, {950: 704, 1250: 884, 1400: 1002});
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
