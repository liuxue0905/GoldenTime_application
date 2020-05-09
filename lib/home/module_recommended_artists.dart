import 'package:flutter/material.dart';
import 'sj_card_recommended.dart';
import '../model/artist.dart';
import '../layout/gpm-card-grid.dart';
import '../layout/gpm-headline-header.dart';
import 'sj_scrolling_moudle.dart';
import '../model/module.dart';
import '../util.dart';
import '../widget_util.dart';

class ModuleRecommendedArtists extends StatelessWidget {
  final Brightness brightness;
  final Module<Artist> module;

  ModuleRecommendedArtists(
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
                .map((Artist e) => SJCardRecommended(
                      brightness: brightness,
                      url: getArtistCover(e, size: 80 * MediaQuery.of(context).devicePixelRatio),
                      title: e.name,
                      subtitle: '${e.recordsCount}张',
                      tag: null,
                      onTap: () {
                        openArtist(context, e);
                      },
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
