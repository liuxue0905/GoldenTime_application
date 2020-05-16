import 'package:flutter/material.dart';

import './api_service.dart';
import './layout/artists.dart';
import './layout/songs.dart';
import './models.dart';
import 'home/home.dart';
import 'home2/home2.dart';
import 'layout/records.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
  int _selection = 0;

  List<GPMQuickNavItem> items = [

    GPMQuickNavItem(icon: Icons.home, text: '首页', key: 'home2'),
    GPMQuickNavItem(icon: Icons.album, text: '唱片', key: 'records'),
    GPMQuickNavItem(icon: Icons.account_box, text: '歌手', key: 'artists'),
    GPMQuickNavItem(icon: Icons.library_music, text: '歌曲', key: 'songs'),

    GPMQuickNavItem(icon: Icons.home, text: '首页', key: 'home'),
  ];

//  final GlobalKey<ScaffoldState> _key4Scaffold = GlobalKey<ScaffoldState>();

  void setSelection(int selection) {
    setState(() {
      _selection = selection;
    });
  }

  Widget _buildChild(BuildContext context) {
    Widget child;

    GPMQuickNavItem item = items[_selection];

    if (item.key == 'home') {
      child = HomePage(
        gpmQuickNavItems: items,
        onBrightnessChanged: (Brightness brightness) {
          // setBrightness(brightness);
        },
        onSelectionChanged: (int selection) {
          setSelection(selection);
        },
      );
    } else if (item.key == 'home2') {
      child = Home2Page(
        gpmQuickNavItems: items,
        onSelectionChanged: (int selection) {
          setSelection(selection);
        },
      );
    } else if (item.key == 'records') {
      child = RecordsPage(
        gpmQuickNavItems: items,
        onSelectionChanged: (int selection) {
          setSelection(selection);
        },
      );
    } else if (item.key == 'artists') {
      child = ArtistsPage(
        gpmQuickNavItems: items,
        onSelectionChanged: (int selection) {
          setSelection(selection);
        },
      );
    } else if (item.key == 'songs') {
      child = SongsPage(
        gpmQuickNavItems: items,
        onSelectionChanged: (int selection) {
          setSelection(selection);
        },
      );
    }

    return child;
  }

  @override
  void initState() {
    super.initState();

    // "http://liujin.jios.org:8888/api/"

//    ApiService service = ApiService(host: 'liujin.jios.org', port: 8888);
    ApiService service = ApiService(host: '127.0.0.1', port: 8888);
//    ApiService service = ApiService(host: '192.168.50.248', port: 8888);
    ApiService.instance = service;
  }

  @override
  Widget build(BuildContext context) {
    print('MediaQuery.of(context).size=${MediaQuery.of(context).size}');
    print(
        'MediaQuery.of(context).devicePixelRatio=${MediaQuery.of(context).devicePixelRatio}');

    List<Widget> buildListTiles(List<GPMQuickNavItem> items) {
      List<Widget> children = items.map<Widget>((GPMQuickNavItem item) {
        int index = items.indexOf(item);
        return MergeSemantics(
          child: ListTile(
            dense: false,
            leading: Icon(item.icon),
            title: Text(item.text),
            selected: _selection == index,
            onTap: () {
              Navigator.pop(context); // Dismiss the drawer.

              setSelection(index);
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
        leading: Icon(Icons.help),
        title: Text('帮助 & 反馈'),
        onTap: () {
          Navigator.pop(context); // Dismiss the drawer.
        },
      ));

      children.add(Container(
        margin: EdgeInsets.fromLTRB(0, 12, 0, 12),
      ));

      return children;
    }

    List<Widget> buildActions(List<GPMQuickNavItem> items) {
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
                  selected: _selection == index,
                ),
              );
            }).toList();
          },
          onSelected: (GPMQuickNavItem item) {
            int index = items.indexOf(item);
            setSelection(index);
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
            textColor: _selection == index ? Colors.white : Colors.black,
            onPressed: () {
              int index = items.indexOf(item);
              setSelection(index);
            },
          );
        }).toList());
      }

      return _actions;
    }

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
//      key: _key4Scaffold,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
//        actions: buildActions(items),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              title: Text(widget.title),
            ),
            MediaQuery.removePadding(
                context: context,
                child: Expanded(
                  child: ListView(
                    children: buildListTiles(items),
                  ),
                ))
          ],
        ),
      ),
      body: Container(
        color: Colors.grey[900],
        child: Container(
          color: Colors.grey[50],
          child: Container(
            child: _buildChild(context),
          ),
        ),
      ),
    );
  }
}
