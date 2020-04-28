import 'package:flutter/material.dart';
import 'package:flutter_app_golden_time/model/hits.dart';
import 'package:flutter_app_golden_time/model/module.dart';

import '../widget_util.dart';
import 'colored_now_card.dart';
import 'gpm-card-grid.dart';
import 'headline_header.dart';
import 'record_item.dart';
import 'record_item_tall.dart';
import 'sj_card.dart';
import 'sj_scrolling_moudle.dart';

class ModuleContainer extends StatelessWidget {
  final List<Module> modules;

  ModuleContainer({this.modules});

  GlobalKey _singleChildScrollViewKey = GlobalKey();

  var _controller = ScrollController(initialScrollOffset: 0.0);

//    _controller.position.isScrollingNotifier.addListener(() {
//      print('_controller.position.isScrollingNotifier.value: $_controller.position.isScrollingNotifier.value');
//    });

  Widget _buildSJScrollingMoudleHistory(BuildContext context, Key key) {
    return SJScrollingMoudle(
      key: key,
      clazz: 'mini',
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
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSJScrollingMoudleNow(BuildContext context, Key key) {
    return SJScrollingMoudle(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          HeadlineHeader(
            title: 'Top Albums',
            subtitle:
                'Popular this week Popular this week Popular this week Popular this week Popular this week Popular this week Popular this week Popular this week Popular this week Popular this week Popular this week Popular this week',
          ),
          GPMCardGrid(
            crossAxisCount: 2,
            children: modules
                .sublist(0, 4)
                .map((Module module) => ColoredNowCard(
                      header: module.header,
                      reason: module.reason,
                      title: module.title,
                      description: module.description,
                      backgroundImage: module.backgroundImage,
                      backgroundColor: module.backgroundColor,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSJScrollingMoudleRecommended(
      BuildContext context, Key key, Module module) {
    return // 右 16， 上 24
        SJScrollingMoudle(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          HeadlineHeader(
            title: module.header,
            subtitle: module.reason,
          ),
          GPMCardGrid(
            crossAxisCount: 4,
            children: module.dataList
                .map((e) => RecordItemTall(
                      url: getRecordImage(e),
                      title: e.title,
                      subtitle: getArtistsString(e.artists),
                      description: '${e.songsCount}首',
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSJScrollingMoudleTop(
      BuildContext context, Key key, Module module) {
    return // 右 16， 上 24
        SJScrollingMoudle(
      key: key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          HeadlineHeader(
            title: module.header,
            subtitle: module.reason,
          ),
          GPMCardGrid(
            crossAxisCount: 5,
            children: module.dataList
                .map((e) => RecordItem(
                      url: getRecordImage(e),
                      title: e.title,
                      subtitle: getArtistsString(e.artists),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSJScrollingMoudleHits(
      BuildContext context, Key key, Module<Hits> module) {
    return SJScrollingMoudle(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          HeadlineHeader(
            title: module.header,
            subtitle: module.reason,
          ),
          GPMCardGrid(
            crossAxisCount: 2,
            children: module.dataList
                .map((e) => SJCard4(
                      image: e.image,
                      title: e.title,
                      description: e.description,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        key: _singleChildScrollViewKey,
        controller: _controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildSJScrollingMoudleHistory(context, null),
            _buildSJScrollingMoudleNow(context, null),
            _buildSJScrollingMoudleRecommended(context, null, modules[0]),
            _buildSJScrollingMoudleTop(context, null, modules[1]),
            _buildSJScrollingMoudleHits(context, null, modules[2]),
            _buildSJScrollingMoudleHits(context, null, modules[3]),
            _buildSJScrollingMoudleHits(context, null, modules[4]),
            _buildSJScrollingMoudleHits(context, null, modules[5]),
            _buildSJScrollingMoudleHits(context, null, modules[6]),
            _buildSJScrollingMoudleHits(context, null, modules[7]),
          ],
        ),
      ),
    );
  }
}
