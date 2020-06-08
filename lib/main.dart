import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import './routes.dart';
import './constants.dart';

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
        Navigator.of(context).pushNamed(routeName);
      }

      List<Path> paths = [
        Path(
          r'^' + Home2Page.route,
          (context, match) => ScaffoldWrapper(
            title: '流金岁月',
            body: Home2Page(
              onRouteNameChanged: (String routeName) {
                _onRouteNameChanged(context, routeName);
              },
            ),
            routeName: Home2Page.route,
            onRouteNameValueChanged: (String routeName) {
              _onRouteNameChanged(context, routeName);
            },
          ),
        ),
        Path(
          r'^' + HomePage.route,
          (context, match) => ScaffoldWrapper(
            title: '流金岁月',
            body: HomePage(
              gpmQuickNavItems: kGPMQuickNavItems,
              onRouteNameChanged: (String routeName) {
                _onRouteNameChanged(context, routeName);
              },
            ),
            routeName: HomePage.route,
            onRouteNameValueChanged: (String value) {
              _onRouteNameChanged(context, value);
            },
          ),
        ),
        Path(
          r'^' + RecordsPage.route,
          (context, match) => ScaffoldWrapper(
            title: '流金岁月 - 唱片',
            body: RecordsPage(
              gpmQuickNavItems: kGPMQuickNavItems,
              onRouteNameChanged: (String routeName) {
                _onRouteNameChanged(context, routeName);
              },
            ),
            routeName: RecordsPage.route,
            onRouteNameValueChanged: (String value) {
              _onRouteNameChanged(context, value);
            },
          ),
        ),
        Path(
          r'^' + ArtistsPage.route,
          (context, match) => ScaffoldWrapper(
            title: '流金岁月 - 歌手',
            body: ArtistsPage(
              onRouteNameChanged: (String routeName) {
                _onRouteNameChanged(context, routeName);
              },
            ),
            routeName: ArtistsPage.routeName,
            onRouteNameValueChanged: (String routeName) {
              _onRouteNameChanged(context, routeName);
            },
          ),
        ),
        Path(
          r'^' + SongsPage.route,
          (context, match) => ScaffoldWrapper(
            title: '流金岁月 - 歌曲',
            body: SongsPage(
              gpmQuickNavItems: kGPMQuickNavItems,
              onRouteNameChanged: (String routeName) {
                _onRouteNameChanged(context, routeName);
              },
            ),
            routeName: SongsPage.route,
            onRouteNameValueChanged: (String value) {
              _onRouteNameChanged(context, value);
            },
          ),
        ),
      ];

      return MaterialApp(
        title: '流金岁月',
        initialRoute: '/home',
        onGenerateRoute: (RouteSettings settings) {

          var paths2 = [];
          paths2.addAll(RouteConfiguration.paths);
          paths2.addAll(paths);

          print('paths2=${paths2}');

          for (final path in paths2) {
            final regExpPattern = RegExp(path.pattern);
            print('path.pattern=${path.pattern}');
            print('settings.name=${settings.name}');
            print('regExpPattern.hasMatch(settings.name)=${regExpPattern.hasMatch(settings.name)}');
            if (regExpPattern.hasMatch(settings.name)) {
              final firstMatch = regExpPattern.firstMatch(settings.name);
              final match =
                  (firstMatch.groupCount == 1) ? firstMatch.group(1) : null;
              if (kIsWeb) {
                return NoAnimationMaterialPageRoute<void>(
                  builder: (context) => path.builder(context, match),
                  settings: settings,
                );
              }
              return MaterialPageRoute<void>(
                builder: (context) => path.builder(context, match),
                settings: settings,
              );
            }
          }

          return null;
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
  String _routeName = Home2Page.routeName;

  void setRouteName(String routeName) {
    setState(() {
      _routeName = routeName;
    });
  }

  Widget _buildChild(BuildContext context) {
    List<Path> paths = [
      Path(
        r'^' + Home2Page.route,
        (context, match) => Home2Page(
          onRouteNameChanged: (String routeName) {
            setRouteName(routeName);
          },
        ),
      ),
      Path(
        r'^' + HomePage.route,
        (context, match) => HomePage(
          gpmQuickNavItems: kGPMQuickNavItems,
          onRouteNameChanged: (String routeName) {
            setRouteName(routeName);
          },
        ),
      ),
      Path(
        r'^' + RecordsPage.route,
        (context, match) => RecordsPage(
          gpmQuickNavItems: kGPMQuickNavItems,
          onRouteNameChanged: (String routeName) {
            setRouteName(routeName);
          },
        ),
      ),
      Path(
        r'^' + ArtistsPage.route,
        (context, match) => ArtistsPage(
          onRouteNameChanged: (String routeName) {
            setRouteName(routeName);
          },
        ),
      ),
      Path(
        r'^' + SongsPage.route,
        (context, match) => SongsPage(
          gpmQuickNavItems: kGPMQuickNavItems,
          onRouteNameChanged: (String routeName) {
            setRouteName(routeName);
          },
        ),
      ),
    ];

    var routeName2Route = {
      Home2Page.routeName: Home2Page.route,
      HomePage.routeName: HomePage.route,
      RecordsPage.routeName: RecordsPage.route,
      ArtistsPage.routeName: ArtistsPage.route,
      SongsPage.routeName: SongsPage.route,
    };

    var paths2 = [];
    paths2.addAll(paths);
    paths2.addAll(RouteConfiguration.paths);

    var name = routeName2Route[_routeName];

    for (final path in paths2) {
      final regExpPattern = RegExp(path.pattern);
      print('path.pattern=${path.pattern}');
      print('name=${name}');
      print('regExpPattern.hasMatch(name)=${regExpPattern.hasMatch(name)}');
      if (regExpPattern.hasMatch(name)) {
        final firstMatch = regExpPattern.firstMatch(name);
        final match = (firstMatch.groupCount == 1) ? firstMatch.group(1) : null;
        return path.builder(context, match);
      }
    }
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
      routeName: _routeName,
      onRouteNameValueChanged: (String value) {
        print('value: ${value}');

        if (RouteConfiguration.routeNameHelp == value) {
          return;
        } else if (RouteConfiguration.routeNameAndroid == value) {
//          String url = 'http://liujin.jios.org:8000/web/android/app-arm64-v8a-release.apk';
          String url = 'http://liujin.jios.org:8000/web/android/index.html';
          if (kIsWeb) {}
          return;
        }

        setRouteName(value);
      },
    );
  }
}

class ScaffoldWrapper extends StatelessWidget {
  final String title;
  final Widget body;
  final String routeName;
  final ValueChanged<String> onRouteNameValueChanged;

  const ScaffoldWrapper({
    Key key,
    this.title,
    this.body,
    this.routeName,
    this.onRouteNameValueChanged,
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
          selected: routeName == item.routeName,
          onTap: () {
            Navigator.pop(context); // Dismiss the drawer.

//            setSelection(index);
            if (onRouteNameValueChanged != null) {
              onRouteNameValueChanged(item.routeName);
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

    if (kIsWeb) {
      children.add(ListTile(
        dense: false,
        leading: Icon(Icons.android),
        title: Text('安卓客户端'),
        onTap: () {
          Navigator.pop(context); // Dismiss the drawer.

          if (onRouteNameValueChanged != null) {
            onRouteNameValueChanged('');
          }
        },
      ));
    }

    children.add(ListTile(
      dense: false,
      leading: Icon(Icons.help),
      title: Text('帮助 & 反馈'),
      onTap: () {
        Navigator.pop(context); // Dismiss the drawer.

        if (onRouteNameValueChanged != null) {
          onRouteNameValueChanged('');
        }
      },
    ));

    children.add(Container(
      margin: EdgeInsets.fromLTRB(0, 12, 0, 12),
    ));

    return children;
  }

  List<Widget> buildActions(BuildContext context) {
    var items = kGPMQuickNavItems;

    List<Widget> _actions = <Widget>[];
//    final Orientation orientation = MediaQuery.of(context).orientation;
//    if (orientation == Orientation.portrait) {
//      _actions.add(PopupMenuButton<GPMQuickNavItem>(
//        itemBuilder: (BuildContext context) {
//          return items.map((GPMQuickNavItem item) {
//            int index = items.indexOf(item);
//            return PopupMenuItem<GPMQuickNavItem>(
//              value: item,
//              child: ListTile(
//                leading: Icon(item.icon),
//                title: Text(item.text),
//                selected: selection == item.routeName,
//              ),
//            );
//          }).toList();
//        },
//        onSelected: (GPMQuickNavItem item) {
//          int index = items.indexOf(item);
////          setSelection(index);
//          if (onValueChanged != null) {
//            onValueChanged(item.routeName);
//          }
//        },
//      ));
//    } else {
//      _actions.addAll(items.map((GPMQuickNavItem item) {
//        int index = items.indexOf(item);
//        return FlatButton.icon(
//          icon: Icon(item.icon, size: 18.0),
//          label: Text(
//            item.text,
//            semanticsLabel: item.text,
//          ),
//          textColor: selection == item.routeName ? Colors.white : Colors.black,
//          onPressed: () {
//            int index = items.indexOf(item);
////            setSelection(index);
//            if (onValueChanged != null) {
//              onValueChanged(item.routeName);
//            }
//          },
//        );
//      }).toList());
//    }

    _actions.add(IconButton(
      icon: const Icon(Icons.android),
//      tooltip: GalleryLocalizations.of(context).starterAppTooltipShare,
      tooltip: '安卓客户端',
      onPressed: () {},
    ));

    return _actions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title ?? ''),
        actions: buildActions(context),
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
                    children: buildListTiles(context, kGPMQuickNavItems),
                  ),
                ))
          ],
        ),
      ),
      body: body,
    );
  }
}
