import 'package:flutter/material.dart';
import 'package:flutter_app_golden_time/module/module_hits.dart';
import 'package:flutter_app_golden_time/module/module_recent.dart';
import 'package:flutter_app_golden_time/module/module_now.dart';
import 'package:flutter_app_golden_time/module/module_recommended_albums.dart';
import 'package:flutter_app_golden_time/module/module_recommended_artists.dart';
import 'package:flutter_app_golden_time/module/module_top_albums.dart';
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
//        print(
//            'isScrollingNotifier listener position.isScrollingNotifier = ${_controller.position.isScrollingNotifier}');

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

  List<Widget> _buildSJScrollingMoudles(BuildContext context) {
    return modules.map((Module e) {
      GlobalKey key = GlobalKey();
      keys.add(key);
      return _buildSJScrollingMoudle(context, key, e);
    }).toList();
  }

  Widget _buildSJScrollingMoudle(BuildContext context, Key key, Module module) {
    if (module.type == Module.MODULE_TOKEN_RECOMMENDED_ALBUMS) {
      return ModuleRecommendedAlbums(
        key: key,
        brightness: _brightness,
        module: module,
      );
    }
    if (module.type == Module.MODULE_TOKEN_RECOMMENDED_ARTISTS) {
      return ModuleRecommendedArtists(
        key: key,
        brightness: _brightness,
        module: module,
      );
    }
    if (module.type == Module.MODULE_TOKEN_TOP_ALBUMS) {
      return ModuleTopAlbums(
        key: key,
        brightness: _brightness,
        module: module,
      );
    }
    if (module.type == Module.MODULE_TOKEN_HITS) {
      return ModuleHits(
        key: key,
        brightness: _brightness,
        module: module,
      );
    }
    return null;
  }

  List<Widget> _build(BuildContext context) {
//    // now
////    querySize<int>(context, {1400: 3});
//    querySize<int>(context, {1250: 2, 1400: 3});
//    // rec
//    querySize<int>(context, {1250: 4, 1850: 5});
//    // top
//    querySize<int>(context, {1250: 5, 1850: 6});
//    // hit
////    querySize<int>(context, {1250: 3, 1850: 4});
//    querySize<int>(context, {950: 2, 1250: 3, 1850: 4});
//
//    // sj_scrolling_moudle top
////    querySize<double>(context, {1250: 116, 1400: 152});
//    querySize<double>(context, {950: 88, 1250: 116, 1400: 152});
//    // sj_scrolling_moudle width
////    querySize<double>(context, {1250: 884, 1400: 1002});
//    querySize<double>(context, {950: 704, 1250: 884, 1400: 1002});

    List<Widget> children = [];
    keys = [];

    GlobalKey keyHistory = GlobalKey();
    keys.add(keyHistory);
    children.add(ModuleRecent(
      key: keyHistory,
      brightness: _brightness,
    ));

    GlobalKey keyNow = GlobalKey();
    keys.add(keyNow);
    children.add(ModuleNow(
      key: keyNow,
      brightness: _brightness,
      modules: modules,
    ));

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
