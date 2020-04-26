import 'package:flutter/material.dart';

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
  String type;

  String title;
  String subtitle;
  String backgroundImage;
  String backgroundColor;

  List<T> dataList;

  Module(
      {this.type,
      this.title,
      this.subtitle,
      this.backgroundImage,
      this.backgroundColor,
      this.dataList});
}

class ABC {
  final String header;
  final String reason;
  final String title;
  final String description;

  final String backgroundImage;
  final Color backgroundColor;

  ABC(
      {this.header,
      this.reason,
      this.title,
      this.description,
      this.backgroundImage,
      this.backgroundColor});
}

class _HomePageState extends State<HomePage> {
  var abcs = [
    ABC(
      header: 'Recommended new releases',
      reason: null,
      title: 'New Release Radio',
      description: null,
      backgroundImage:
          'https://lh3.googleusercontent.com/f-m-m5tQ9knrY3lPJQgFFhrdeoefL3FzY2SgEQjkxPP2HlcsI1FQd9A-Yxj8_HIOqjYPhrLf=w700-h560-n-e100-rwu-v1',
      backgroundColor: Color.fromARGB(1, 0, 0, 0),
    ),
    ABC(
      header: 'Top Albums',
      reason: 'Popular this week',
      title: 'BLAME IT ON BABY',
      description: 'Album by DaBaby • 13 songs',
      backgroundImage:
          'https://lh3.googleusercontent.com/2j1Cse4obFQSlJjVbNi9FOXNHVgE27NiVccPUCQCdgnThqihDHXboUWqYnpN3qpTFg4HBYN8HA=w700-h560-n-e100-rwu-v1',
      backgroundColor: Color.fromARGB(1, 22, 17, 16),
    ),
    ABC(
      header: 'Romantic moods',
      reason: null,
      title: 'Sweetheart Pop',
      description: null,
      backgroundImage:
          'https://lh3.googleusercontent.com/_8EG31lZMoy4IDmwvCvDvjuapJN77vw-NBDDob5tS0i5jI0RKV0sgi-SVqeu3UjA4-HdBi3DZ7M=w700-h560-n-e100-rwu-v1',
      backgroundColor: Color.fromARGB(1, 81, 34, 87),
    ),
    ABC(
      header: 'Feel-good favorites',
      reason: null,
      title: 'Cloud Nine R&B',
      description: null,
      backgroundImage:
          'https://lh3.googleusercontent.com/WwnaSyZar1s7gJWNsjWf-xmaLDDKpSs4i4bkbMtWGqFj24m-ucOwj3ltVjVy6NUsy5fTprCY=w700-h560-n-e100-rwu-v1',
      backgroundColor: Color.fromARGB(1, 93, 206, 214),
    ),
    ABC(
      header: 'All the feelings',
      reason: null,
      title: 'All-Night Goth Pop',
      description: null,
      backgroundImage:
          'https://lh3.googleusercontent.com/jSui6tIhAbLrf4Bl5BAUzjMpxAChWAGU5WeS_0LLOgevP8XJvH8vbqfuBaVlVyrp-AylAKtn=w700-h560-n-e100-rwu-v1',
      backgroundColor: Color.fromARGB(1, 57, 34, 145),
    ),
    ABC(
      header: 'Throwback jams',
      reason: null,
      title: '\'00s Biggest Hits',
      description: null,
      backgroundImage:
          'https://lh3.googleusercontent.com/3rSsn09XlksGOUhWrgB7vSJwPWzmlS0Zp7FZZ1o1cipRdFyJ_mQ0bbXg6KKeNaebF1OiXZKz=w700-h560-n-e100-rwu-v1',
      backgroundColor: Color.fromARGB(1, 198, 251, 229),
    ),
    ABC(
      header: 'Mellow moods',
      reason: null,
      title: 'Acoustic Campfire',
      description: null,
      backgroundImage:
          'https://lh3.googleusercontent.com/kkSI0jxnAYZ6_3jeLT7aZ9A9ITBaA5MQjGNS1jmhtdSCorKCgouBuUXg1Yvktfb_l6wflXDiFWI=w700-h560-n-e100-rwu-v1',
      backgroundColor: Color.fromARGB(1, 84, 33, 95),
    ),
    ABC(
      header: 'Today\'s biggest hits',
      reason: null,
      title: 'Teen Pop Today',
      description: null,
      backgroundImage:
          'https://lh3.googleusercontent.com/1aN6mX4KtTKKOBfGwSftr-hxuHhHIUyxPoN7R1fEZYwZ02GrVCONCTQxtbLWxF85rUs49HCMaQ=w700-h560-n-e100-rwu-v1',
      backgroundColor: Color.fromARGB(1, 83, 30, 101),
    ),
  ];

  List moduleList = [];

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
                // moduleContainer
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SJScrollingMoudle(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[],
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
                            children: abcs
                                .sublist(0, 4)
                                .map((ABC abc) => ColoredNowCard(
                                      header: abc.header,
                                      reason: abc.reason,
                                      title: abc.title,
                                      description: abc.description,
                                      backgroundImage: abc.backgroundImage,
                                      backgroundColor: abc.backgroundColor,
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
                            title: 'Top Albums',
                            subtitle:
                            'Popular this week Popular this week Popular this week Popular this week Popular this week Popular this week Popular this week Popular this week Popular this week Popular this week Popular this week Popular this week',
                          ),
                          GPMCardGrid(
                            crossAxisCount: 4,
                            children: <Widget>[
                              RecordItem(
                                url:
                                'https://p2.music.126.net/3VCqOJSYLEAiCtodKgxrXg==/2528876744253082.jpg?param=946y946',
                                title:
                                'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA',
                                subtitle:
                                'New Release Radio New Release Radio New Release Radio New Release Radio',
                              ),
                              RecordItem(
                                url:
                                'https://p2.music.126.net/3VCqOJSYLEAiCtodKgxrXg==/2528876744253082.jpg?param=946y946',
                                title:
                                'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA',
                                subtitle:
                                'New Release Radio New Release Radio New Release Radio New Release Radio',
                              ),
                              RecordItem(
                                url:
                                'https://p2.music.126.net/3VCqOJSYLEAiCtodKgxrXg==/2528876744253082.jpg?param=946y946',
                                title:
                                'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA',
                                subtitle:
                                'New Release Radio New Release Radio New Release Radio New Release Radio',
                              ),
                              RecordItem(
                                url:
                                'https://p2.music.126.net/3VCqOJSYLEAiCtodKgxrXg==/2528876744253082.jpg?param=946y946',
                                title:
                                'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA',
                                subtitle:
                                'New Release Radio New Release Radio New Release Radio New Release Radio',
                              ),
                              RecordItem(
                                url:
                                'https://p2.music.126.net/3VCqOJSYLEAiCtodKgxrXg==/2528876744253082.jpg?param=946y946',
                                title:
                                'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA',
                                subtitle:
                                'New Release Radio New Release Radio New Release Radio New Release Radio',
                              ),
                              RecordItem(
                                url:
                                'https://p2.music.126.net/3VCqOJSYLEAiCtodKgxrXg==/2528876744253082.jpg?param=946y946',
                                title:
                                'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA',
                                subtitle:
                                'New Release Radio New Release Radio New Release Radio New Release Radio',
                              ),
                            ],
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
                            title: 'Top Albums',
                            subtitle:
                                'Popular this week Popular this week Popular this week Popular this week Popular this week Popular this week Popular this week Popular this week Popular this week Popular this week Popular this week Popular this week',
                          ),
                          GPMCardGrid(
                            crossAxisCount: 5,
                            children: <Widget>[
                              RecordItem(
                                url:
                                    'https://p2.music.126.net/3VCqOJSYLEAiCtodKgxrXg==/2528876744253082.jpg?param=946y946',
                                title:
                                    'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA',
                                subtitle:
                                    'New Release Radio New Release Radio New Release Radio New Release Radio',
                              ),
                              RecordItem(
                                url:
                                    'https://p2.music.126.net/3VCqOJSYLEAiCtodKgxrXg==/2528876744253082.jpg?param=946y946',
                                title:
                                    'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA',
                                subtitle:
                                    'New Release Radio New Release Radio New Release Radio New Release Radio',
                              ),
                              RecordItem(
                                url:
                                    'https://p2.music.126.net/3VCqOJSYLEAiCtodKgxrXg==/2528876744253082.jpg?param=946y946',
                                title:
                                    'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA',
                                subtitle:
                                    'New Release Radio New Release Radio New Release Radio New Release Radio',
                              ),
                              RecordItem(
                                url:
                                    'https://p2.music.126.net/3VCqOJSYLEAiCtodKgxrXg==/2528876744253082.jpg?param=946y946',
                                title:
                                    'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA',
                                subtitle:
                                    'New Release Radio New Release Radio New Release Radio New Release Radio',
                              ),
                              RecordItem(
                                url:
                                    'https://p2.music.126.net/3VCqOJSYLEAiCtodKgxrXg==/2528876744253082.jpg?param=946y946',
                                title:
                                    'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA',
                                subtitle:
                                    'New Release Radio New Release Radio New Release Radio New Release Radio',
                              ),
                              RecordItem(
                                url:
                                    'https://p2.music.126.net/3VCqOJSYLEAiCtodKgxrXg==/2528876744253082.jpg?param=946y946',
                                title:
                                    'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA',
                                subtitle:
                                    'New Release Radio New Release Radio New Release Radio New Release Radio',
                              ),
                            ],
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
