import 'package:flutter/material.dart';

import './background_container.dart';
import './pageIndicator_container.dart';
import '../layout/module_container.dart';
import '../model/artist.dart';
import '../model/module.dart';
import '../model/record.dart';
import '../util.dart';

typedef OnBackgroundChanged = void Function(Brightness brightness);

class HomePage extends StatefulWidget {
  HomePage({Key key, this.onBackgroundChanged});

  final OnBackgroundChanged onBackgroundChanged;

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  //  CLIENT_SIDE_RECENTS
  var historyList = [
    Record(
        id: 1836,
        title: '一颗不变心',
        artists: [Artist(id: 148, name: '张学友')],
        songsCount: 12),
    Record(
        id: 1836,
        title: '一颗不变心',
        artists: [Artist(id: 148, name: '张学友')],
        songsCount: 12),
  ];

  bool history = true;

  int _selection = 0;
  Color _backgroundColor;
  Brightness _brightness = Brightness.light;

  void _incrementSelection() {
    setState(() {
      print('_incrementSelection old _selection = ${_selection}');
      _selection = (_selection + 1) % _backgroundCount;
      print('_incrementSelection new _selection = ${_selection}');

      _setSelection(_selection);
    });
  }

  Brightness getBrightness(Color color) {
    double luminance = color.computeLuminance();
    if (luminance >= 0.5) {
      return Brightness.light;
    } else if (luminance < 0.5) {
      return Brightness.dark;
    }
    return Brightness.light;
  }

  void _setSelection(int selection) {
    setState(() {
      _selection = selection;

      _backgroundColor = _backgroundColors[_selection];
      _brightness = getBrightness(_backgroundColor);

      if (widget.onBackgroundChanged != null) {
        widget.onBackgroundChanged(_brightness);
      }
    });
  }

  List<Module> modules;
  int _backgroundCount;
  List<Color> _backgroundColors = <Color>[];
  List<String> _backgroundImages = <String>[];

  @override
  void initState() {
    super.initState();

    this.modules = Module.getModules();

    _backgroundCount = modules.length + 1 + (history ? 1 : 0);

    if (history) {
      _backgroundColors.add(Color.fromRGBO(250, 250, 250, 1.0));
    }
    _backgroundColors.add(Color.fromRGBO(250, 250, 250, 1.0));
    modules.forEach((element) {
      _backgroundColors.add(element.backgroundColor);
    });

    if (history) {
      _backgroundImages.add(null);
    }
    _backgroundImages.add(null);
    modules.forEach((element) {
      _backgroundImages.add(element.backgroundImage);
    });

    print('_backgroundColors = $_backgroundColors');
    print('_backgroundImages = $_backgroundImages');

//    _setSelection(0);
  }

  @override
  Widget build(BuildContext context) {
    double scale = getScale(context, 'xl');

//    Color.fromRGBO(250, 250, 250, 1.0).computeLuminance();

    GlobalKey _singleChildScrollViewKey = GlobalKey();
    GlobalKey _key = GlobalKey();

    return Container(
//      color: Colors.grey[100],
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: BackgroundContainer(
              backgroundColors: _backgroundColors,
              backgroundImages: _backgroundImages,
              selection: _selection,
            ),
          ),
          Positioned.fill(
            child: ModuleContainer(
              modules: this.modules,
              brightness: _brightness,
            ),
          ),
          Positioned(
            top: 0,
            right: 36.0 * scale,
            child: PageIndicatorContainer(
              count: modules.length,
              selection: _selection,
              brightness: _brightness,
              backgroundColor: _backgroundColor,
              history: true,
            ),
          ),
          Positioned(
            child: FlatButton(
              onPressed: _incrementSelection,
              child: Text('incrementSelection($_selection)'),
            ),
          ),
          Positioned.fill(
            child: Center(
              child: FlatButton(
                onPressed: () {
                  print(_key.currentContext.size.toString());

                  RenderBox abc = _singleChildScrollViewKey.currentContext
                      .findRenderObject();

                  RenderBox _renderObject =
                      _key.currentContext.findRenderObject();

                  Offset localToGlobal =
                      _renderObject.localToGlobal(Offset.zero);
//                  Offset localToGlobal = _renderObject.localToGlobal(abc.localToGlobal(Offset.zero));

                  Offset efg = abc.localToGlobal(Offset.zero);

                  print("localToGlobal = $localToGlobal");
                  print("efg = $efg");
                  print("efg = ${efg.dy - localToGlobal.dy}");
                },
                child: Text('get size'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
