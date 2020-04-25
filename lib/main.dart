import 'package:flutter/material.dart';
import 'package:flutter_app_golden_time/api_service.dart';

import './layout/artists.dart';
import './layout/home.dart';
import './layout/quick_nav_container.dart';
import './layout/records.dart';
import './layout/songs.dart';
import './models.dart';

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
  Widget _moduleContainer;

  Brightness _brightness = Brightness.light;
  int _selection = 0;

  @override
  Widget build(BuildContext context) {
    ApiService service = ApiService("http://liujin.jios.org:8888/api/");
    ApiService.instance = service;

    List<Item> items = [
      Item(icon: Icons.home, text: '首页'),
      Item(icon: Icons.album, text: '唱片'),
      Item(icon: Icons.account_box, text: '歌手'),
      Item(icon: Icons.library_music, text: '歌曲'),
    ];

    void setContent(int selection) {
      Widget child;

      if (selection == 0) {
        child = HomePage(onBackgroundChanged: (Brightness brightness) {
          setState(() {
            _brightness = brightness;
          });
        });
      } else if (selection == 1) {
        child = RecordsPage();
      } else if (selection == 2) {
        child = ArtistsPage();
      } else if (selection == 3) {
        child = SongsPage();
      }

      setState(() {
        _selection = selection;
        _moduleContainer = Container(
          child: child,
        );
      });
    }

    List<Widget> buildListTiles(List<Item> items) {
      List<Widget> children = items.map<Widget>((Item item) {
        int index = items.indexOf(item);
        return MergeSemantics(
          child: ListTile(
            dense: false,
            leading: Icon(item.icon),
            title: Text(item.text),
            selected: _selection == index,
            onTap: () {
              Navigator.pop(context); // Dismiss the drawer.

              setContent(index);
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

      return children;
    }

    List<Widget> buildActions(List<Item> items) {
      List<Widget> _actions = <Widget>[];
      final Orientation orientation = MediaQuery.of(context).orientation;
      if (orientation == Orientation.portrait) {
        _actions.add(PopupMenuButton<Item>(
          itemBuilder: (BuildContext context) {
            return items.map((Item item) {
              int index = items.indexOf(item);
              return PopupMenuItem<Item>(
                value: item,
                child: ListTile(
                  leading: Icon(item.icon),
                  title: Text(item.text),
                  selected: _selection == index,
                ),
              );
            }).toList();
          },
          onSelected: (Item item) {
            int index = items.indexOf(item);
            setContent(index);
          },
        ));
      } else {
        _actions.addAll(items.map((Item item) {
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
              setContent(index);
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
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: buildActions(items),
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
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                color: Colors.grey[50],
                child: _moduleContainer,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: QuickNavContainer(
                  brightness: _brightness,
                  selection: _selection,
                  onItemClick: (int position) {
                    setContent(position);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
