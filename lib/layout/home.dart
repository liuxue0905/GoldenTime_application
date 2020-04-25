import 'package:flutter/material.dart';

import './background_container.dart';
import './colored_now_card.dart';
import './headline_header.dart';
import './pageIndicator_container.dart';
import '../constants.dart';
import '../layout/sj_card.dart';
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
  List<String> pageLabelList = [
    'AAAAA',
    'BBBBB',
    'CCCCC',
    'DDDDD',
    'EEEEE',
    'FFFFF',
    'GGGGG',
    'DDDDD',
    'DDDDD',
    'DDDDD',
    'DDDDD',
    'DDDDD',
    'DDDDD',
    'DDDDD',
    'DDDDD',
    'DDDDD',
  ];

  List<Color> backgroundColorList = Constants.backgroundColorList;
  List<String> backgroundImagesList = Constants.backgroundImagesList;

  int _selection = 0;

  Color _backgroundColor = Colors.white;
  Brightness _brightness = Brightness.light;

  void _incrementSelection() {
    setState(() {
      _selection++;
      _selection = _selection % backgroundColorList.length;

      _backgroundColor = backgroundColorList[_selection];
      double luminance = _backgroundColor.computeLuminance();

      print('_backgroundColor: $_backgroundColor');
      print('luminance: $luminance');

      if (luminance == 0.5) {}

      if (luminance < 0.5) {
        _brightness = Brightness.dark;
      }

      if (luminance > 0.5) {
        _brightness = Brightness.light;
      }

      widget.onBackgroundChanged(_brightness);
    });
  }

  @override
  Widget build(BuildContext context) {
    double scale = getScale(context, 'xl');

//    Color.fromRGBO(250, 250, 250, 1.0).computeLuminance();

    var _controller = ScrollController(initialScrollOffset: 0.0);
//    _controller.position.isScrollingNotifier.addListener(() {
//      print('_controller.position.isScrollingNotifier.value: $_controller.position.isScrollingNotifier.value');
//    });

    GlobalKey _singleChildScrollViewKey = GlobalKey();
    GlobalKey _key = GlobalKey();

    return Container(
//      color: Colors.grey[100],
      child: Stack(
        children: <Widget>[
          Positioned.fill(
              child: BackgroundContainer(
            backgroundColorList: backgroundColorList,
            backgroundImagesList: backgroundImagesList,
            selection: _selection,
          )),
          Positioned.fill(
              child: Container(
            child: SingleChildScrollView(
              key: _singleChildScrollViewKey,
              controller: _controller,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    height: 206.5,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  Container(
                    height: 723.0,
                    color: Colors.grey[600].withOpacity(0.5),
                  ),
                  Container(
                    key: _key,
                    height: 646.0,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    color: Colors.orange.withOpacity(0.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          color: Colors.grey,
                          child: HeadlineHeader(
                            title: 'Top Albums',
                            subtitle:
                                'Popular this week Popular this week Popular this week Popular this week Popular this week Popular this week Popular this week Popular this week Popular this week Popular this week Popular this week Popular this week',
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        ColoredNowCard(),
                        SizedBox(
                          height: 8,
                        ),
                        SJCard(),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
          Positioned(
            top: 0,
            right: 36.0 * scale,
            child: PageIndicatorContainer(
              pageLabelList: pageLabelList,
              selection: _selection,
              brightness: _brightness,
              backgroundColor: _backgroundColor,
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
