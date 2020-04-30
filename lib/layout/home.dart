import 'package:flutter/material.dart';

import './background_container.dart';
import './pageIndicator_container.dart';
import '../layout/module_container.dart';
import '../model/artist.dart';
import '../model/module.dart';
import '../model/record.dart';
import '../util.dart';
import 'quick_nav_container.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.onSelectionChanged, this.onBrightnessChanged});

  final ValueChanged<int> onSelectionChanged;
  final ValueChanged<Brightness> onBrightnessChanged;

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

  void _setSelection(int selection) {
    setState(() {
      _selection = selection;

      _backgroundColor = _backgroundColors[_selection];
      _brightness = getBrightness(_backgroundColor);
    });

    if (widget.onBrightnessChanged != null) {
      widget.onBrightnessChanged(_brightness);
    }
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
  }

  @override
  Widget build(BuildContext context) {
    double scale = getScale(context, 'xl');

    return Container(
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
              selection: _selection,
              onSelectionChanged: (int position) {

              },
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            child: QuickNavContainer(
              brightness: _brightness,
              selection: 0,
              onSelectionChanged: (int position) {
                if (widget.onSelectionChanged != null) {
                  widget.onSelectionChanged(position);
                }
              },
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
              onSelectionChanged: (int position) {

              },
            ),
          ),
          Positioned.fill(
            child: Center(
              child: RaisedButton(
                onPressed: _incrementSelection,
                child: Text('incrementSelection($_selection)'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
