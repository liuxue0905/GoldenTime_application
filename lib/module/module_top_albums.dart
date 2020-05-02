import 'package:flutter/material.dart';
import '../layout/gpm-card-grid.dart';
import '../layout/headline_header.dart';
import '../layout/record_item.dart';
import '../layout/sj_scrolling_moudle.dart';
import '../model/module.dart';

import '../util.dart';
import '../widget_util.dart';

class ModuleTopAlbums extends StatelessWidget {
  final Brightness brightness;
  final Module module;

  ModuleTopAlbums({Key key, this.brightness = Brightness.light, this.module})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SJScrollingMoudle(
      moduleType: module.type,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          HeadlineHeader(
            brightness: brightness,
            title: module.header,
            subtitle: module.reason,
          ),
          GPMCardGrid(
            // 右 16， 上 24
            crossAxisCount: 5,
            mainAxisSpacing: isLargeScreen(context) ? 24 : 12,
            crossAxisSpacing: isLargeScreen(context) ? 16 : 8,
            children: module.dataList
                .map((e) => RecordItem(
                      brightness: brightness,
                      url: getRecordImage(e),
                      title: e.title,
                      subtitle: getArtistsString(e.artists),
                      tag: e.getFormatText(),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
