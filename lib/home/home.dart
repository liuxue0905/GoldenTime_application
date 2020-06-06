import 'package:flutter/material.dart';

import '../constants.dart';
import '../model/module.dart';
import '../models.dart';
import '../util.dart';
import 'background_container.dart';
import 'module_container.dart';
import 'page_indicator_container.dart';
import 'quick_nav_container.dart';

class HomePage extends StatefulWidget {
//  static const String route = '/home';

  final List<GPMQuickNavItem> gpmQuickNavItems;
  final ValueChanged<String> onRouteNameChanged;
  final ValueChanged<Brightness> onBrightnessChanged;

  const HomePage({
    Key key,
    this.gpmQuickNavItems = kGPMQuickNavItems,
    this.onRouteNameChanged,
    this.onBrightnessChanged,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  //  CLIENT_SIDE_RECENTS
  List<dynamic> historyList = [
    'abc1',
    'abc2',
    'abc3',
    'abc4',
    'abc5',
    'abc6',
    'abc7',
    'abc8',
    'abc9',
    'abc10',
    'abc11',
    'abc12',
    'abc13',
    'abc14',
  ];

  bool history = true;

  int _selection = 0;
  Color _backgroundColor;
  Brightness _brightness = Brightness.light;

  void _incrementSelection() {
    setState(() {
//      print('_incrementSelection old _selection = ${_selection}');
      _selection = (_selection + 1) % _backgroundCount;
//      print('_incrementSelection new _selection = ${_selection}');

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
      _backgroundImages.add(null);
    }
    _backgroundColors.add(Color.fromRGBO(250, 250, 250, 1.0));
    _backgroundImages.add(null);
    modules.forEach((element) {
      _backgroundColors.add(element.backgroundColor);
      _backgroundImages.add(element.backgroundImage);
    });

    print('_backgroundColors = $_backgroundColors');
    print('_backgroundImages = $_backgroundImages');
  }

  @override
  Widget build(BuildContext context) {
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
              historyList: historyList,
              modules: this.modules,
              brightness: _brightness,
              selection: _selection,
              onSelectionChanged: (int position) {},
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            child: Visibility(
              visible: isLargeScreen(context),
              child: QuickNavContainer(
                brightness: _brightness,
                items: widget.gpmQuickNavItems,
                selection: 0,
                onSelectionChanged: (int position) {
                  if (widget.onRouteNameChanged != null) {
                    widget.onRouteNameChanged(widget.gpmQuickNavItems[position].routeName);
                  }
                },
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: MediaQuery.of(context).size.width >= 950
                ? 36.0
                : scaleSize(context, 950, 36.0),
            child: Visibility(
              visible: isLargeScreen(context),
              child: PageIndicatorContainer(
                count: modules.length,
                selection: _selection,
                brightness: _brightness,
                backgroundColor: _backgroundColor,
                history: (historyList?.length ?? 0) != 0,
                onSelectionChanged: (int position) {},
              ),
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
