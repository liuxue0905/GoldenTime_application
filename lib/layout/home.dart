import 'package:flutter/material.dart';
import 'package:flutter_app_golden_time/layout/record_item_tall.dart';
import 'package:flutter_app_golden_time/model/artist.dart';
import 'package:flutter_app_golden_time/widget_util.dart';

import '../layout/gpm-card-grid.dart';
import '../layout/record_item.dart';
import '../model/record.dart';
import './background_container.dart';
import './colored_now_card.dart';
import './headline_header.dart';
import './pageIndicator_container.dart';
import '../constants.dart';
import '../layout/sj_card.dart';
import '../util.dart';
import 'sj_scrolling_moudle.dart';

typedef OnBackgroundChanged = void Function(Brightness brightness);

class HomePage extends StatefulWidget {
  HomePage({Key key, this.onBackgroundChanged});

  final OnBackgroundChanged onBackgroundChanged;

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class Module<T> {
  final String header;
  final String reason;
  final String title;
  final String description;

  final String backgroundImage;
  final Color backgroundColor;

  final List<T> dataList;

  Module(
      {this.header,
      this.reason,
      this.title,
      this.description,
      this.backgroundImage,
      this.backgroundColor,
      this.dataList});
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
      double luminance = _backgroundColor.computeLuminance();

      print('_setSelection _backgroundColor: $_backgroundColor');
      print('_setSelection luminance: $luminance');

      if (luminance == 0.5) {}

      if (luminance < 0.5) {
        _brightness = Brightness.dark;
      }

      if (luminance > 0.5) {
        _brightness = Brightness.light;
      }

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

    List<Module> modules = [
      Module<Record>(
        header: 'Recommended new releases',
        reason: null,
        title: 'New Release Radio',
        description: null,
        backgroundImage:
            'https://lh3.googleusercontent.com/f-m-m5tQ9knrY3lPJQgFFhrdeoefL3FzY2SgEQjkxPP2HlcsI1FQd9A-Yxj8_HIOqjYPhrLf=w700-h560-n-e100-rwu-v1',
        backgroundColor: Color.fromRGBO(0, 0, 0, 1),
        dataList: <Record>[
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
        ],
      ),
      Module<Record>(
        header: 'Top Albums',
        reason: 'Popular this week',
        title: 'BLAME IT ON BABY',
        description: 'Album by DaBaby • 13 songs',
        backgroundImage:
            'https://lh3.googleusercontent.com/2j1Cse4obFQSlJjVbNi9FOXNHVgE27NiVccPUCQCdgnThqihDHXboUWqYnpN3qpTFg4HBYN8HA=w700-h560-n-e100-rwu-v1',
        backgroundColor: Color.fromRGBO(22, 17, 16, 1),
        dataList: <Record>[
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
        ],
      ),
      Module(
        header: 'Romantic moods',
        reason: null,
        title: 'Sweetheart Pop',
        description: null,
        backgroundImage:
            'https://lh3.googleusercontent.com/_8EG31lZMoy4IDmwvCvDvjuapJN77vw-NBDDob5tS0i5jI0RKV0sgi-SVqeu3UjA4-HdBi3DZ7M=w700-h560-n-e100-rwu-v1',
        backgroundColor: Color.fromRGBO(81, 34, 87, 1),
      ),
      Module(
        header: 'Feel-good favorites',
        reason: null,
        title: 'Cloud Nine R&B',
        description: null,
        backgroundImage:
            'https://lh3.googleusercontent.com/WwnaSyZar1s7gJWNsjWf-xmaLDDKpSs4i4bkbMtWGqFj24m-ucOwj3ltVjVy6NUsy5fTprCY=w700-h560-n-e100-rwu-v1',
        backgroundColor: Color.fromRGBO(93, 206, 214, 1),
      ),
      Module(
        header: 'All the feelings',
        reason: null,
        title: 'All-Night Goth Pop',
        description: null,
        backgroundImage:
            'https://lh3.googleusercontent.com/jSui6tIhAbLrf4Bl5BAUzjMpxAChWAGU5WeS_0LLOgevP8XJvH8vbqfuBaVlVyrp-AylAKtn=w700-h560-n-e100-rwu-v1',
        backgroundColor: Color.fromRGBO(57, 34, 145, 1),
      ),
      Module(
        header: 'Throwback jams',
        reason: null,
        title: '\'00s Biggest Hits',
        description: null,
        backgroundImage:
            'https://lh3.googleusercontent.com/3rSsn09XlksGOUhWrgB7vSJwPWzmlS0Zp7FZZ1o1cipRdFyJ_mQ0bbXg6KKeNaebF1OiXZKz=w700-h560-n-e100-rwu-v1',
        backgroundColor: Color.fromRGBO(198, 251, 229, 1),
      ),
      Module(
        header: 'Mellow moods',
        reason: null,
        title: 'Acoustic Campfire',
        description: null,
        backgroundImage:
            'https://lh3.googleusercontent.com/kkSI0jxnAYZ6_3jeLT7aZ9A9ITBaA5MQjGNS1jmhtdSCorKCgouBuUXg1Yvktfb_l6wflXDiFWI=w700-h560-n-e100-rwu-v1',
        backgroundColor: Color.fromRGBO(84, 33, 95, 1),
      ),
      Module(
        header: 'Today\'s biggest hits',
        reason: null,
        title: 'Teen Pop Today',
        description: null,
        backgroundImage:
            'https://lh3.googleusercontent.com/1aN6mX4KtTKKOBfGwSftr-hxuHhHIUyxPoN7R1fEZYwZ02GrVCONCTQxtbLWxF85rUs49HCMaQ=w700-h560-n-e100-rwu-v1',
        backgroundColor: Color.fromRGBO(83, 30, 101, 1),
      ),
    ];

    this.modules = modules;

    _backgroundCount = modules.length + 1 + (history ? 1 : 0);

    if (history) {
      _backgroundColors.add(Color.fromRGBO(250, 250, 250, 1.0));
    }
    _backgroundColors.add(Color.fromRGBO(250, 250, 250, 1.0));
    modules.forEach((element) {_backgroundColors.add(element.backgroundColor);});

    if (history) {
      _backgroundImages.add(null);
    }
    _backgroundImages.add(null);
    modules.forEach((element) {_backgroundImages.add(element.backgroundImage);});

    print('_backgroundColors = $_backgroundColors');
    print('_backgroundImages = $_backgroundImages');

//    _setSelection(0);
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
              backgroundColors: _backgroundColors,
              backgroundImages: _backgroundImages,
              selection: _selection,
            ),
          ),
          Positioned.fill(
            child: Container(
              child: SingleChildScrollView(
                key: _singleChildScrollViewKey,
                controller: _controller,
                // moduleContainer
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SJScrollingMoudle(
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
                    ),
                    SJScrollingMoudle(
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
                    ),

                    // 右 16， 上 24
                    SJScrollingMoudle(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          HeadlineHeader(
                            title: modules[0].header,
                            subtitle: modules[0].reason,
                          ),
                          GPMCardGrid(
                            crossAxisCount: 4,
                            children: modules[0]
                                .dataList
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
                    ),

                    // 右 16， 上 24
                    SJScrollingMoudle(
                      key: _key,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          HeadlineHeader(
                            title: modules[1].header,
                            subtitle: modules[1].reason,
                          ),
                          GPMCardGrid(
                            crossAxisCount: 5,
                            children: modules[1]
                                .dataList
                                .map((e) => RecordItem(
                                      url: getRecordImage(e),
                                      title: e.title,
                                      subtitle: getArtistsString(e.artists),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    ),

                    SJScrollingMoudle(
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
                            children: <Widget>[
                              SJCard4(),
                              SJCard4(),
                              SJCard4(),
                              SJCard4(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
