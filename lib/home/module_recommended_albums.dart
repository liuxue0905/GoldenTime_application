import 'package:flutter/material.dart';
import '../model/record.dart';
import '../layout/gpm-card-grid.dart';
import '../layout/gpm-headline-header.dart';
import 'sj_card_recommended_tall.dart';
import 'sj_scrolling_moudle.dart';
import '../model/module.dart';
import '../util.dart';
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
            mainAxisSpacing: isLargeScreen(context) ? 24 : 12,
            crossAxisSpacing: isLargeScreen(context) ? 16 : 8,
            children: module.dataList
                .map((Record e) => SJCardRecommendedTall(
                      brightness: brightness,
                      url: getRecordCover(e, size: 48 * MediaQuery.of(context).devicePixelRatio),
                      title: e.title,
                      subtitle: getArtistsString(e.artists),
                      description: '${e.songsCount}首',
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
