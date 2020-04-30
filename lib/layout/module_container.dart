import 'package:flutter/material.dart';
import 'package:flutter_app_golden_time/util.dart';

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

class ModuleContainer extends StatefulWidget {
  final List<Module> modules;
  final Brightness brightness;

  final int selection;
  final ValueChanged<int> onSelectionChanged;

  ModuleContainer(
      {this.modules,
      this.brightness = Brightness.light,
      this.selection,
      this.onSelectionChanged});

  @override
  State<StatefulWidget> createState() {
    return ModuleContainerState();
  }
}

class ModuleContainerState extends State<ModuleContainer> {
  GlobalObjectKey _key4SingleChildScrollView = GlobalObjectKey('abc');

  var _controller = ScrollController(initialScrollOffset: 0.0);

  List<Key> keys = [];

  List<Widget> children = [];

  Brightness _brightness;

  ModuleContainerState();

  @override
  void initState() {
    super.initState();
    _handleDataSourceChanged();

    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      print('timeStamp = ${timeStamp}');
      print('_controller.position = ${_controller.position}');

      _controller.position.isScrollingNotifier.addListener(() {
        print(
            'isScrollingNotifier listener position.isScrollingNotifier = ${_controller.position.isScrollingNotifier}');

//        _controller.position.isScrollingNotifier.value
      });
    });

//    _controller.addListener(() {
////      print('callback');
//
//      if (!_controller.position.isScrollingNotifier.hasListeners) {
//        _controller.position.isScrollingNotifier.addListener(() {
//          print(
//              'isScrollingNotifier listener position.isScrollingNotifier = ${_controller.position.isScrollingNotifier}');
//        });
//      }
//
////      print('offset = ${_controller.offset}');
////      print('position = ${_controller.position}');
////      print(
////          'position.isScrollingNotifier = ${_controller.position.isScrollingNotifier}');
////
////      keys.asMap().forEach((index, key) {
////        print('========');
////
////        print('${index}: ${key}');
////        GlobalKey globalKey = key;
////        RenderObject renderObject = globalKey.currentContext.findRenderObject();
////        print('${index} renderObject: ${renderObject}');
////
////        RenderBox renderBox = renderObject;
////        print('${index} renderBox.size = ${renderBox.size}');
////        Offset localToGlobal = renderBox.localToGlobal(Offset.zero);
////        print('${index} localToGlobal = ${localToGlobal}');
////
////        print('========');
////      });
////
////      RenderObject renderObject =
////          _key4SingleChildScrollView.currentContext.findRenderObject();
////      print('scroll renderObject: ${renderObject}');
////
////      RenderBox renderBox = renderObject;
////      print('scroll renderBox.size = ${renderBox.size}');
////      Offset localToGlobal = renderBox.localToGlobal(Offset.zero);
////      print('scroll localToGlobal = ${localToGlobal}');
//    });
  }

  @override
  void didUpdateWidget(ModuleContainer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget != widget) {
      _handleDataSourceChanged();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleDataSourceChanged() {
    setState(() {
      _brightness = widget.brightness;
    });
  }

  Widget _buildSJScrollingMoudleHistory(BuildContext context, Key key) {
    bool light = _brightness == Brightness.light;

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
        ],
      ),
    );
  }

  Widget _buildSJScrollingMoudleNow(BuildContext context, Key key) {
    String deviceType = getDeviceType(context);
    int _crossAxisCount() {
      if (deviceType == 'xs') {
        return 1;
      }
      if (deviceType == 'xl') {
        return 3;
      }
      return 2;
    }

    List<Module> _modules = modules;

    if (_crossAxisCount() == 1) {
      _modules = modules.sublist(0, 1);
    } else if (_crossAxisCount() == 2) {
      _modules = modules.sublist(0, 4);
    } else if (_crossAxisCount() == 3) {
      _modules = modules.sublist(0, 6);
    }

    return SJScrollingMoudle(
      key: key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          HeadlineHeader(
            brightness: _brightness,
            title: '今日推荐',
            subtitle: null,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Opacity(
                opacity: 0.3,
                child: RawMaterialButton(
                  constraints: BoxConstraints.tightFor(
                    width: 48.0,
                    height: 48.0,
                  ),
                  onPressed: null,
                  fillColor: Color.fromRGBO(0, 0, 0, 0.1),
                  elevation: 0,
                  shape: CircleBorder(),
                  child: Icon(
                    Icons.chevron_left,
                    color: Color.fromRGBO(0, 0, 0, 0.54),
                  ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Opacity(
                opacity: 1.0,
                child: RawMaterialButton(
                  constraints: BoxConstraints.tightFor(
                    width: 48.0,
                    height: 48.0,
                  ),
                  onPressed: null,
                  fillColor: Color.fromRGBO(0, 0, 0, 0.1),
                  elevation: 0,
                  shape: CircleBorder(),
                  child: Icon(
                    Icons.chevron_right,
                    color: Color.fromRGBO(0, 0, 0, 0.54),
                  ),
                ),
              ),
            ],
          ),
          GPMCardGrid(
            // 右 0， 上 0
            crossAxisCount: _crossAxisCount(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: _modules
                .map((Module module) => ColoredNowCard(
                      header: module.header,
                      reason: module.reason,
                      title: module.title,
                      description: module.description,
                      backgroundImage: module.backgroundImage,
                      backgroundColor: module.backgroundColor,
                      separatorColor: module.separatorColor ?? (getBrightness(module.backgroundColor) == Brightness.light ? Colors.grey[900] : Colors.white),
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
      key: key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          HeadlineHeader(
            brightness: _brightness,
            title: module.header,
            subtitle: module.reason,
          ),
          GPMCardGrid(
            // 右 16， 上 24
            crossAxisCount: 4,
            mainAxisSpacing: 24,
            crossAxisSpacing: 16,
            children: module.dataList
                .map((e) => RecordItemTall(
                      brightness: _brightness,
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
      key: key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          HeadlineHeader(
            brightness: _brightness,
            title: module.header,
            subtitle: module.reason,
          ),
          GPMCardGrid(
            // 右 16， 上 24
            crossAxisCount: 5,
            mainAxisSpacing: 24,
            crossAxisSpacing: 16,
            children: module.dataList
                .map((e) => RecordItem(
                      brightness: _brightness,
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
    int _crossAxisCount() {
      if (getDeviceType(context) == 'xl') {
        return 3;
      }
      return 2;
    }

    return SJScrollingMoudle(
      key: key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          HeadlineHeader(
            brightness: _brightness,
            title: module.header,
            subtitle: module.reason,
          ),
          GPMCardGrid(
            crossAxisCount: _crossAxisCount(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
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
      return _buildSJScrollingMoudleRecommended(context, key, module);
    }
    if (module.type == 'top') {
      return _buildSJScrollingMoudleTop(context, key, module);
    }
    if (module.type == 'hits') {
      return _buildSJScrollingMoudleHits(context, key, module);
    }
    return null;
  }

  List<Widget> _build(BuildContext context) {
    List<Widget> children = [];
    keys = [];

    GlobalKey keyHistory = GlobalKey();
    keys.add(keyHistory);
    children.add(_buildSJScrollingMoudleHistory(context, keyHistory));

    GlobalKey keyNow = GlobalKey();
    keys.add(keyNow);
    children.add(_buildSJScrollingMoudleNow(context, keyNow));

    children.addAll(_buildSJScrollingMoudles(context));

    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        key: _key4SingleChildScrollView,
        controller: _controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _build(context),
        ),
      ),
    );
  }
}
