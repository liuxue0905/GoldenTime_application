import 'package:flutter/material.dart';

import '../model/hits.dart';
import '../model/module.dart';
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
  final Brightness brightness;

  ModuleContainer({this.modules, this.brightness = Brightness.light});

  GlobalKey _singleChildScrollViewKey = GlobalKey();

  var _controller = ScrollController(initialScrollOffset: 0.0);

//    _controller.position.isScrollingNotifier.addListener(() {
//      print('_controller.position.isScrollingNotifier.value: $_controller.position.isScrollingNotifier.value');
//    });

  List<Key> keys = [];

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
      key: key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          HeadlineHeader(
            brightness: brightness,
            title: '今日推荐',
            subtitle: null,
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
    return SJScrollingMoudle(
      // 右 16， 上 24
      key: key,
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
            crossAxisCount: 4,
            children: module.dataList
                .map((e) => RecordItemTall(
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

  Widget _buildSJScrollingMoudleTop(
      BuildContext context, Key key, Module module) {
    return SJScrollingMoudle(
      // 右 16， 上 24
      key: key,
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
            crossAxisCount: 5,
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

  Widget _buildSJScrollingMoudleHits(
      BuildContext context, Key key, Module<Hits> module) {
    return SJScrollingMoudle(
      key: key,
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

  List<Widget> _buildSJScrollingMoudles(BuildContext context) {
    return modules.map((Module e) {
      GlobalKey key = GlobalKey();
      keys.add(key);
      return _buildSJScrollingMoudle(context, key, e);
    }).toList();
  }

  Widget _buildSJScrollingMoudle(BuildContext context, Key key, Module module) {
    if (module.type == 'recommended') {
      return _buildSJScrollingMoudleRecommended(context, null, module);
    }
    if (module.type == 'top') {
      return _buildSJScrollingMoudleTop(context, null, module);
    }
    if (module.type == 'hits') {
      return _buildSJScrollingMoudleHits(context, null, module);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    GlobalKey keyHistory = GlobalKey();
    keys.add(keyHistory);
    children.add(_buildSJScrollingMoudleHistory(context, keyHistory));

    GlobalKey keyNow = GlobalKey();
    keys.add(keyNow);
    children.add(_buildSJScrollingMoudleNow(context, keyNow));

    children.addAll(_buildSJScrollingMoudles(context));

    return Container(
      child: SingleChildScrollView(
        key: _singleChildScrollViewKey,
        controller: _controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
  }
}
