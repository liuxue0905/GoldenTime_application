import 'package:flutter/material.dart';
import 'package:flutter_app_golden_time/home/background_container.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../api_service.dart';
import '../constants.dart';
import '../home/quick_nav_container.dart';
import '../home2/artist_type_header.dart';
import '../model/artist.dart';
import '../model/page_list.dart';
import '../models.dart';
import '../util.dart';
import '../widget_util.dart';

class Home2Page extends StatefulWidget {
  static const String route = '/home';
  static const String routeName = 'home';

  final List<GPMQuickNavItem> gpmQuickNavItems;
  final ValueChanged<String> onRouteNameChanged;

  const Home2Page({
    Key key,
    this.gpmQuickNavItems = kGPMQuickNavItems,
    this.onRouteNameChanged,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return Home2PageState();
  }
}

const int int32MaxValue = 2147483647;

class Home2PageState extends State<Home2Page> {
  Future<Map<int, List<Artist>>> future;

  Future<Map<int, List<Artist>>> getArtistMap() async {
    PageList<Artist> pageList = await ApiService.instance
        .getArtists(recordIsNull: false, limit: int32MaxValue);

    Map<int, List<Artist>> artistMap = {
      1: <Artist>[],
      0: <Artist>[],
      2: <Artist>[],
      null: <Artist>[],
    };

    pageList?.results?.forEach((Artist artist) {
      artistMap[artist.type].add(artist);
    });

    return artistMap;
  }

  @override
  void initState() {
    super.initState();

    _handleDataSourceChanged();
  }

  void _handleDataSourceChanged() {
    setState(() {
      future = getArtistMap();
    });
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.black;
//    Color backgroundColor = Colors.green;
    Brightness brightness = getBrightness(backgroundColor);

    return Container(
      child: Container(
        child: Stack(
          fit: StackFit.loose,
          children: <Widget>[
            Positioned.fill(
              child: Container(
                color: backgroundColor,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Container(
                color: Colors.transparent,
                child: Stack(
                  alignment: Alignment.topCenter,
                  fit: StackFit.loose,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: Image.asset(
                        'images/home.jpg',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Positioned.fill(
                      child: BackgroundImageContainerGradient(
                        backgroundColor: backgroundColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                child: FutureBuilder(
                  future: future,
                  builder: (context, snapshot) {
                    print('snapshot = ${snapshot}');
                    print(
                        'snapshot.connectionState = ${snapshot.connectionState}');
                    print('snapshot.hasData = ${snapshot.hasData.toString()}');
                    print(
                        'snapshot.hasError = ${snapshot.hasError.toString()}');
                    print('snapshot.error = ${snapshot.error.toString()}');
                    print('snapshot.data = ${snapshot.data}');

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return WaitingWidget();
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.hasError) {
                        return FutureErrorWidget(
                          onPressed: () {
                            _handleDataSourceChanged();
                          },
                          error: snapshot.error,
                        );
                      }
                      if (snapshot.hasData) {
                        return ArtistsWidget(
                          brightness: brightness,
                          datas: snapshot.data,
                        );
                      }
                    } else {
                      return Center(
                        child: Text(snapshot.connectionState.toString()),
                      );
                    }

                    return null;
                  },
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              child: Visibility(
                visible: isLargeScreen(context),
                child: QuickNavContainer(
                  brightness: brightness,
                  items: widget.gpmQuickNavItems,
                  selection: 0,
                  onSelectionChanged: (int position) {
                    if (widget.onRouteNameChanged != null) {
                      widget.onRouteNameChanged(
                          widget.gpmQuickNavItems[position].routeName);
                    }
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

class ArtistsWidget extends StatelessWidget {
  final Brightness brightness;

//  final List<PageList<Artist>> datas;
  final Map<int, List<Artist>> datas;

  ArtistsWidget({
    this.brightness = Brightness.light,
    this.datas,
  });

  @override
  Widget build(BuildContext context) {
    bool light = brightness == Brightness.light;

    String getTitle(int index) {
      List<String> titles = ['男歌手', '女歌手', '组合', '未知'];
      return titles[index];
    }

    int getGroupCount() {
      return datas?.keys?.length ?? 0;
    }

    List<Artist> getGroup(int group) {
      return datas[datas?.keys?.toList()[group]];
    }

    int _itemCount() {
      int count = 0;

      for (int i = 0; i < getGroupCount(); i++) {
        List<Artist> data = getGroup(i);

        count += 1;
        count += data?.length ?? 0;

//        print('_itemCount ${i} ${getTitle(i)} ${data?.count}');
      }

//      print('_itemCount count: ${count}');

      return count;
    }

    Widget _itemBuilder(BuildContext context, int index) {
      int start = 0;
      int end = 0;

      for (int i = 0; i < getGroupCount(); i++) {
        List<Artist> data = getGroup(i);

        start = end;
        end = start + 1 + data?.length ?? 0;

//        print(
//            '_itemBuilder ${i} ${getTitle(i)} ${data?.count} start: ${start} end: ${end} ${index}');

        if (index == start) {
          return Container(
            margin: EdgeInsets.only(top: 24.0),
            child: ArtistTypeHeader(
              brightness: brightness,
              title: getTitle(i),
              subtitle: '共${data?.length ?? '-'}',
            ),
          );
        }

        if (index > start && index < end) {
          int realIndex = index - 1 - start;
          Artist artist = data[realIndex];
          return ListTile(
            leading: ExcludeSemantics(
              child: CircleAvatar(
                backgroundColor: Colors.grey[350],
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Center(
                        child: Text(artist?.name?.substring(0, 1) ?? ''),
                      ),
                    ),
                    Positioned.fill(
                      child: ClipOval(
                        child: Image.network(
                          getArtistCover(artist,
                              size:
                                  40 * MediaQuery.of(context).devicePixelRatio),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            title: Text(
              artist?.name,
              style: TextStyle(
                color: light ? Colors.black : Colors.white,
              ),
            ),
            subtitle: Text(
              '${artist?.recordsCount}张唱片',
              style: TextStyle(
                color: light ? Colors.black : Colors.white,
              ),
            ),
            onTap: () {
              openArtist(context, artist);
            },
          );
        }
      }

      print('_itemBuilder end');
      return null;
    }

    int _crossAxisCount() {
      if (MediaQuery.of(context).size.width <= 360) {
        return 1;
      }
      if (!isLargeScreen(context)) {
        return 2;
      }
      return querySize<int>(context, {950: 3, 1250: 4, 1400: 5});
    }

    StaggeredTile _staggeredTileBuilder(int index) {
      int start = 0;
      int end = 0;

      for (int i = 0; i < getGroupCount(); i++) {
        List<Artist> data = getGroup(i);

        start = end;
        end = start + 1 + data?.length ?? 0;

//        print(
//            '_staggeredTileBuilder ${i} ${getTitle(i)} ${data?.count} start: ${start} end: ${end} ${index}');

        if (index == start) {
          return StaggeredTile.fit(_crossAxisCount());
        }

        if (index > start && index < end) {
          return StaggeredTile.fit(1);
        }
      }

      print('_staggeredTileBuilder end');
      return null;
    }

    return Container(
      child: StaggeredGridView.countBuilder(
        padding: getListContainerMargin(context),
        crossAxisCount: _crossAxisCount(),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        itemCount: _itemCount(),
        itemBuilder: _itemBuilder,
        staggeredTileBuilder: _staggeredTileBuilder,
      ),
    );
  }
}
