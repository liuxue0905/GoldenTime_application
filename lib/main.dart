import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_app_golden_time/routes.dart';

import './api_service.dart';
import 'artist/artists.dart';
import 'song/songs.dart';
import './models.dart';
import 'home/home.dart';
import 'home2/home2.dart';
import 'recrod/records.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ApiService service = ApiService(host: 'liujin.jios.org', port: 8888);
    ApiService.instance = service;

    if (kIsWeb) {
      _onRouteNameChanged(BuildContext context, String routeName) {
        print('routeName: ${routeName}');

        var routeNameToPattern = {
          RouteConfiguration.routeNameHome: '/',
          RouteConfiguration.routeNameRecordList: '/record',
          RouteConfiguration.routeNameArtistList: '/artist',
          RouteConfiguration.routeNameSongList: '/song',
          RouteConfiguration.routeNameTest: '/test',
        };

        Navigator.of(context).pushNamed(routeNameToPattern[routeName]);
      }

      Map<String, WidgetBuilder> routes = {
        '/': (context) => ScaffoldWrapper(
              title: '流金岁月',
              body: Home2Page(
                gpmQuickNavItems: ScaffoldWrapper.gpmQuickNavItems,
                onRouteNameChanged: (String routeName) {
                  _onRouteNameChanged(context, routeName);
                },
              ),
              selection: RouteConfiguration.routeNameHome,
              onValueChanged: (String value) {
                _onRouteNameChanged(context, value);
              },
            ),
        '/home': (context) => ScaffoldWrapper(
              title: '流金岁月',
              body: Home2Page(
                gpmQuickNavItems: ScaffoldWrapper.gpmQuickNavItems,
                onRouteNameChanged: (String routeName) {
                  _onRouteNameChanged(context, routeName);
                },
              ),
              selection: RouteConfiguration.routeNameHome,
              onValueChanged: (String value) {
                _onRouteNameChanged(context, value);
              },
            ),
        '/artist': (context) => ScaffoldWrapper(
              title: '流金岁月 - 歌手',
              body: ArtistsPage(
                gpmQuickNavItems: ScaffoldWrapper.gpmQuickNavItems,
                onRouteNameChanged: (String routeName) {
                  _onRouteNameChanged(context, routeName);
                },
              ),
              selection: RouteConfiguration.routeNameArtistList,
              onValueChanged: (String value) {
                _onRouteNameChanged(context, value);
              },
            ),
        '/record': (context) => ScaffoldWrapper(
              title: '流金岁月 - 唱片',
              body: RecordsPage(
                gpmQuickNavItems: ScaffoldWrapper.gpmQuickNavItems,
                onRouteNameChanged: (String routeName) {
                  _onRouteNameChanged(context, routeName);
                },
              ),
              selection: RouteConfiguration.routeNameRecordList,
              onValueChanged: (String value) {
                _onRouteNameChanged(context, value);
              },
            ),
        '/song': (context) => ScaffoldWrapper(
              title: '流金岁月 - 歌曲',
              body: SongsPage(
                gpmQuickNavItems: ScaffoldWrapper.gpmQuickNavItems,
                onRouteNameChanged: (String routeName) {
                  _onRouteNameChanged(context, routeName);
                },
              ),
              selection: RouteConfiguration.routeNameSongList,
              onValueChanged: (String value) {
                _onRouteNameChanged(context, value);
              },
            ),
        '/test': (context) => ScaffoldWrapper(
              title: '流金岁月',
              body: HomePage(
                gpmQuickNavItems: ScaffoldWrapper.gpmQuickNavItems,
                onRouteNameChanged: (String routeName) {
                  _onRouteNameChanged(context, routeName);
                },
              ),
              selection: RouteConfiguration.routeNameTest,
              onValueChanged: (String value) {
                _onRouteNameChanged(context, value);
              },
            ),
      };

      return MaterialApp(
        title: '流金岁月',
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          String pattern = settings.name;

          return NoAnimationMaterialPageRoute(
            builder: routes[pattern],
            settings: settings,
          );
        },
//        onGenerateRoute: RouteConfiguration.onGenerateRoute,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.deepOrange,

          primaryColorBrightness: Brightness.light,

          appBarTheme: AppBarTheme(color: Colors.white),
        ),
      );
    } else {
      return MaterialApp(
        title: '流金岁月',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.deepOrange,

          primaryColorBrightness: Brightness.light,

          appBarTheme: AppBarTheme(color: Colors.white),
        ),
        home: MyHomePage(title: '流金岁月'),
      );
    }
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _routeName = RouteConfiguration.routeNameHome;

  void setRouteName(String routeName) {
    setState(() {
      _routeName = routeName;
    });
  }

  Widget _buildChild(BuildContext context) {
    Widget child;

    if (_routeName == RouteConfiguration.routeNameTest) {
      child = HomePage(
        gpmQuickNavItems: ScaffoldWrapper.gpmQuickNavItems,
        onBrightnessChanged: (Brightness brightness) {
          // setBrightness(brightness);
        },
        onRouteNameChanged: (String routeName) {
          setRouteName(routeName);
        },
      );
    } else if (_routeName == RouteConfiguration.routeNameHome) {
      child = Home2Page(
        gpmQuickNavItems: ScaffoldWrapper.gpmQuickNavItems,
        onRouteNameChanged: (String routeName) {
          setRouteName(routeName);
        },
      );
    } else if (_routeName == RouteConfiguration.routeNameRecordList) {
      child = RecordsPage(
        gpmQuickNavItems: ScaffoldWrapper.gpmQuickNavItems,
        onRouteNameChanged: (String routeName) {
          setRouteName(routeName);
        },
      );
    } else if (_routeName == RouteConfiguration.routeNameArtistList) {
      child = ArtistsPage(
        gpmQuickNavItems: ScaffoldWrapper.gpmQuickNavItems,
        onRouteNameChanged: (String routeName) {
          setRouteName(routeName);
        },
      );
    } else if (_routeName == RouteConfiguration.routeNameSongList) {
      child = SongsPage(
        gpmQuickNavItems: ScaffoldWrapper.gpmQuickNavItems,
        onRouteNameChanged: (String routeName) {
          setRouteName(routeName);
        },
      );
    }

    return child;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('MediaQuery.of(context).size=${MediaQuery.of(context).size}');
    print(
        'MediaQuery.of(context).devicePixelRatio=${MediaQuery.of(context).devicePixelRatio}');

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return ScaffoldWrapper(
      title: widget.title,
      body: _buildChild(context),
      selection: _routeName,
      onValueChanged: (String value) {
        print('value: ${value}');

        if (RouteConfiguration.routeNameHelp == value) {
          return;
        } else if (RouteConfiguration.routeNameAndroid == value) {
          return;
        }

        setRouteName(value);
      },
    );
  }
}

class ScaffoldWrapper extends StatelessWidget {
  static const List<GPMQuickNavItem> gpmQuickNavItems = [
    GPMQuickNavItem(
        icon: Icons.home,
        text: '首页',
        routeName: RouteConfiguration.routeNameHome),
    GPMQuickNavItem(
        icon: Icons.album,
        text: '唱片',
        routeName: RouteConfiguration.routeNameRecordList),
    GPMQuickNavItem(
        icon: Icons.account_box,
        text: '歌手',
        routeName: RouteConfiguration.routeNameArtistList),
    GPMQuickNavItem(
        icon: Icons.library_music,
        text: '歌曲',
        routeName: RouteConfiguration.routeNameSongList),
    GPMQuickNavItem(
        icon: Icons.home,
        text: '测试',
        routeName: RouteConfiguration.routeNameTest),
  ];

  final String title;
  final Widget body;
  final String selection;
  final ValueChanged<String> onValueChanged;

  const ScaffoldWrapper({
    Key key,
    this.title,
    this.body,
    this.selection,
    this.onValueChanged,
  }) : super(key: key);

  List<Widget> buildListTiles(
      BuildContext context, List<GPMQuickNavItem> items) {
    List<Widget> children = items.map<Widget>((GPMQuickNavItem item) {
      int index = items.indexOf(item);
      return MergeSemantics(
        child: ListTile(
          dense: false,
          leading: Icon(item.icon),
          title: Text(item.text),
          selected: selection == item.routeName,
          onTap: () {
            Navigator.pop(context); // Dismiss the drawer.

//            setSelection(index);
            if (onValueChanged != null) {
              onValueChanged(item.routeName);
            }
          },
          subtitle: null,
          trailing: null,
        ),
      );
    }).toList();

    children.add(Container(
      margin: EdgeInsets.fromLTRB(0, 12, 0, 12),
      child: Divider(
        thickness: 1,
        color: Color(0xffdedede),
      ),
    ));

    children.add(ListTile(
      dense: false,
      leading: Icon(Icons.android),
      title: Text('安卓客户端'),
      onTap: () {
        Navigator.pop(context); // Dismiss the drawer.

        if (onValueChanged != null) {
          onValueChanged(RouteConfiguration.routeNameAndroid);
        }
      },
    ));

    children.add(ListTile(
      dense: false,
      leading: Icon(Icons.help),
      title: Text('帮助 & 反馈'),
      onTap: () {
        Navigator.pop(context); // Dismiss the drawer.

        if (onValueChanged != null) {
          onValueChanged(RouteConfiguration.routeNameHelp);
        }
      },
    ));

    children.add(Container(
      margin: EdgeInsets.fromLTRB(0, 12, 0, 12),
    ));

    return children;
  }

  List<Widget> buildActions(BuildContext context, List<GPMQuickNavItem> items) {
    List<Widget> _actions = <Widget>[];
    final Orientation orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.portrait) {
      _actions.add(PopupMenuButton<GPMQuickNavItem>(
        itemBuilder: (BuildContext context) {
          return items.map((GPMQuickNavItem item) {
            int index = items.indexOf(item);
            return PopupMenuItem<GPMQuickNavItem>(
              value: item,
              child: ListTile(
                leading: Icon(item.icon),
                title: Text(item.text),
                selected: selection == item.routeName,
              ),
            );
          }).toList();
        },
        onSelected: (GPMQuickNavItem item) {
          int index = items.indexOf(item);
//          setSelection(index);
          if (onValueChanged != null) {
            onValueChanged(item.routeName);
          }
        },
      ));
    } else {
      _actions.addAll(items.map((GPMQuickNavItem item) {
        int index = items.indexOf(item);
        return FlatButton.icon(
          icon: Icon(item.icon, size: 18.0),
          label: Text(
            item.text,
            semanticsLabel: item.text,
          ),
          textColor: selection == item.routeName ? Colors.white : Colors.black,
          onPressed: () {
            int index = items.indexOf(item);
//            setSelection(index);
            if (onValueChanged != null) {
              onValueChanged(item.routeName);
            }
          },
        );
      }).toList());
    }

    return _actions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title ?? ''),
//        actions: buildActions(items),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              title: Text('流金岁月'),
            ),
            MediaQuery.removePadding(
                context: context,
                child: Expanded(
                  child: ListView(
                    children: buildListTiles(context, gpmQuickNavItems),
                  ),
                ))
          ],
        ),
      ),
      body: body,
    );
  }
}

//class QuickNavContainerWrapper extends StatelessWidget {
//  final Brightness brightness;
//  final Widget child;
//  final int selection;
//  final ValueChanged<int> onValueChanged;
//
//  const QuickNavContainerWrapper({
//    this.brightness,
//    this.child,
//    this.selection,
//    this.onValueChanged,
//  }) : super();
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: Stack(
//        children: [
//          Positioned.fill(child: child),
//          Positioned(
//            top: 0,
//            left: 0,
//            bottom: 0,
//            child: Visibility(
//              visible: isLargeScreen(context),
//              child: QuickNavContainer(
//                brightness: brightness,
//                items: ScaffoldWrapper.gpmQuickNavItems,
//                selection: selection,
//                onSelectionChanged: (int position) {
//                  if (onValueChanged != null) {
//                    onValueChanged(position);
//                  }
//                },
//              ),
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}
