import 'package:flutter/material.dart';
import 'package:flutter_app_golden_time/home/recent_item.dart';
import 'sj_scrolling_moudle.dart';
import '../model/module.dart';

class ModuleRecent extends StatelessWidget {
  final Brightness brightness;
  final List<dynamic> historyList;

  ModuleRecent({Key key, this.brightness = Brightness.light, this.historyList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool light = brightness == Brightness.light;

    return SJScrollingMoudle(
      moduleType: Module.MODULE_TOKEN_RECENT,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  '最近活动',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .apply(color: light ? Colors.black : Colors.white),
                ),
                Icon(Icons.chevron_right,
                    color: light ? Colors.grey[900] : Colors.white),
              ],
            ),
          ),
          Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: historyList
                    .map((e) => Container(
                          child: RecentItem(),
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
