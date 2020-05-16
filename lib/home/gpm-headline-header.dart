import 'package:flutter/material.dart';

import '../util.dart';

class HeadlineHeader extends StatelessWidget {
  HeadlineHeader({
    Key key,
    this.brightness = Brightness.light,
    this.title,
    this.subtitle,
  });

  final Brightness brightness;
  final String title;
  String subtitle;

  @override
  Widget build(BuildContext context) {
    final bool dark = brightness == Brightness.dark;

    EdgeInsets _margin() {
      EdgeInsets edgeInsets = EdgeInsets.only(bottom: 32);
      if (MediaQuery.of(context).size.width < 450) {
        edgeInsets = EdgeInsets_only(context, 950, bottom: 32);
      }
      return edgeInsets;
    }

    return Container(
      margin: _margin(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              title ?? '',
              maxLines: 1,
              overflow: TextOverflow.clip,
              style: TextStyle(
                color: dark ? Colors.white : Colors.grey[900],
                fontSize: 34,
                fontWeight: FontWeight.w400,
              ),
//              style: Theme.of(context)
//                  .textTheme
//                  .display1
//                  .apply(color: selected ? Colors.white : Colors.grey[900]),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 12),
            width: 100,
            height: 2,
            color: const Color.fromRGBO(153, 153, 153, 1),
          ),
          Container(
            margin: EdgeInsets.only(top: 12),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width < 950
                    ? scaleSize(context, 950, 384)
                    : 384),
            child: Visibility(
              visible: subtitle?.isNotEmpty ?? false,
              child: Text(
                subtitle ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  height: 17 / (13 + 2),
                  fontStyle: FontStyle.italic,
                  color: dark
                      ? const Color.fromRGBO(255, 255, 255, 0.7)
                      : const Color.fromRGBO(0, 0, 0, 0.7),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
