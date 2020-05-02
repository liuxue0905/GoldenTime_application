import 'package:flutter/material.dart';
import '../model/record.dart';
import '../layout/gpm-card-grid.dart';
import '../layout/headline_header.dart';
import '../layout/record_item_tall.dart';
import '../layout/sj_scrolling_moudle.dart';
import '../model/module.dart';
import '../widget_util.dart';

class ModuleRecommendedAlbums extends StatelessWidget {
  final Brightness brightness;
  final Module<Record> module;

  ModuleRecommendedAlbums(
      {Key key, this.brightness = Brightness.light, this.module})
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
            crossAxisCount: 4,
            mainAxisSpacing: 24,
            crossAxisSpacing: 16,
            children: module.dataList
                .map((Record e) => RecordItemTall(
                      brightness: brightness,
                      url: getRecordImage(e),
                      title: e.title,
                      subtitle: getArtistsString(e.artists),
                      description: '${e.songsCount}首',
                      tag: e.getFormatText(),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
