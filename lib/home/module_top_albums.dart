import 'package:flutter/material.dart';

import '../layout/gpm-card-grid.dart';
import 'gpm-headline-header.dart';
import '../model/module.dart';
import '../util.dart';
import '../widget_util.dart';
import 'sj_card_recommended.dart';
import 'sj_scrolling_moudle.dart';

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
            crossAxisCount: querySize<int>(context, {1250: 5, 1400:5, 1850: 6}),
            mainAxisSpacing: isLargeScreen(context) ? 24 : 12,
            crossAxisSpacing: isLargeScreen(context) ? 16 : 8,
            children: module.dataList
                .map((e) => SJCardRecommended(
                      brightness: brightness,
                      url: getRecordCover(e, size: 48 * MediaQuery.of(context).devicePixelRatio),
                      title: e.title,
                      subtitle: getArtistsString(e.artists),
                      tag: e.getFormatText(),
                      onTap: () {
                        openRecord(context, e);
                      },
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
