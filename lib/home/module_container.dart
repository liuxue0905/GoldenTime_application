import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../model/module.dart';
import 'module_hits.dart';
import 'module_now.dart';
import 'module_recent.dart';
import 'module_recommended_albums.dart';
import 'module_recommended_artists.dart';
import 'module_top_albums.dart';

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

class ModuleContainer extends StatefulWidget {
  final List<Module> modules;
  final Brightness brightness;

  final int selection;
  final ValueChanged<int> onSelectionChanged;

  final List<dynamic> historyList;

  ModuleContainer({
    this.modules,
    this.brightness = Brightness.light,
    this.selection,
    this.onSelectionChanged,
    this.historyList,
  });

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

    RenderBox _getRenderBox(Key key) {
      GlobalKey globalKey = key;
      RenderObject renderObject = globalKey?.currentContext?.findRenderObject();
      RenderBox renderBox = renderObject;
      return renderBox;
    }

    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      print('timeStamp = ${timeStamp}');
      print('_controller.position = ${_controller.position}');

      RenderBox singleChildScrollViewRenderBox =
          _getRenderBox(_key4SingleChildScrollView);
      Offset singleChildScrollViewOffset =
          singleChildScrollViewRenderBox.localToGlobal(Offset.zero);
      print(
          'singleChildScrollViewRenderBox.size: ${singleChildScrollViewRenderBox.size}');
      print('singleChildScrollViewOffset: ${singleChildScrollViewOffset}');

      keys.asMap().forEach((index, key) {
        RenderBox moduleRenderBox = _getRenderBox(key);
        print(
            'index: ${index} moduleRenderBox?.size: ${moduleRenderBox?.size}');
        Offset moduleOffset = moduleRenderBox
            ?.localToGlobal(singleChildScrollViewOffset.scale(0, -1));
        print('index: ${index} moduleOffset: ${moduleOffset}');
      });

      _controller.position.isScrollingNotifier.addListener(() {
        print(
            'isScrollingNotifier listener position.isScrollingNotifier.value = ${_controller.position.isScrollingNotifier.value}');

        if (_controller.position.isScrollingNotifier.value == false) {
          RenderBox singleChildScrollViewRenderBox =
              _getRenderBox(_key4SingleChildScrollView);
          Offset singleChildScrollViewOffset =
              singleChildScrollViewRenderBox.localToGlobal(Offset.zero);
          print(
              'singleChildScrollViewRenderBox.size: ${singleChildScrollViewRenderBox.size}');
          print('singleChildScrollViewOffset: ${singleChildScrollViewOffset}');

          keys.asMap().forEach((index, key) {
            RenderBox moduleRenderBox = _getRenderBox(key);
            print(
                'index: ${index} moduleRenderBox?.size: ${moduleRenderBox?.size}');
            Offset moduleOffset = moduleRenderBox
                ?.localToGlobal(singleChildScrollViewOffset.scale(0, -1));
            print('index: ${index} moduleOffset: ${moduleOffset}');
          });
        }
      });
    });
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

  Widget _itemBuilder(BuildContext context, int index) {
    bool hasHistory = (widget.historyList?.length ?? 0) != 0;

    if (hasHistory) {
      if (index == 0) {
        GlobalKey keyHistory = GlobalKey();
        keys.add(keyHistory);
        return ModuleRecent(
          key: keyHistory,
          brightness: _brightness,
          historyList: widget.historyList,
        );
      }
      if (index == 1) {
        GlobalKey keyNow = GlobalKey();
        keys.add(keyNow);
        return ModuleNow(
          key: keyNow,
          brightness: _brightness,
          modules: modules,
        );
      }
    } else {
      if (index == 0) {
        GlobalKey keyNow = GlobalKey();
        keys.add(keyNow);
        return ModuleNow(
          key: keyNow,
          brightness: _brightness,
          modules: modules,
        );
      }
    }

    int readIndex = index - 1 - (hasHistory ? 1 : 0);

    Module module = modules[readIndex];

    GlobalKey key = GlobalKey();
    keys.add(key);

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

  @override
  Widget build(BuildContext context) {
    keys = [];

    int count = 0;

    if ((widget.historyList?.length ?? 0) != 0) {
      count++;
    }

    if ((widget.modules?.length ?? 0) != 0) {
      count += 1;
      count += widget.modules.length;
    }

//    return Container(
//      child: SingleChildScrollView(
//        key: _key4SingleChildScrollView,
//        controller: _controller,
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.stretch,
//          children: Iterable.generate(count)
//              .map((e) => _itemBuilder(context, e))
//              .toList(),
//        ),
//      ),
//    );

    return Container(
      child: StaggeredGridView.countBuilder(
        key: _key4SingleChildScrollView,
        controller: _controller,
        crossAxisCount: 1,
        itemCount: count,
        itemBuilder: _itemBuilder,
        staggeredTileBuilder: (int index) {
          return StaggeredTile.fit(1);
        },
      ),
    );
  }
}
