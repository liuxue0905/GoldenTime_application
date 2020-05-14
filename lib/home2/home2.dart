import 'package:flutter/material.dart';
import 'package:flutter_app_golden_time/home/quick_nav_container.dart';
import 'package:flutter_app_golden_time/util.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_app_golden_time/layout/gpm-headline-header.dart';
import 'package:flutter_app_golden_time/model/artist.dart';
import 'package:flutter_app_golden_time/model/page_list.dart';

import '../api_service.dart';
import '../models.dart';
import '../widget_util.dart';

class Home2Page extends StatefulWidget {
  final List<GPMQuickNavItem> gpmQuickNavItems;
  final ValueChanged<int> onSelectionChanged;

  Home2Page({this.gpmQuickNavItems, this.onSelectionChanged});

  @override
  State<StatefulWidget> createState() {
    return Home2PageState();
  }
}

const int int32MaxValue = 2147483647;

class Home2PageState extends State<Home2Page> {
  Future<List<PageList<Artist>>> future;

  Future<List<PageList<Artist>>> waitFutures() async {
    List<Future<PageList<Artist>>> futures = <Future<PageList<Artist>>>[
      ApiService.instance
          .getArtists(type: 1, recordIsNull: false, limit: int32MaxValue),
      ApiService.instance
          .getArtists(type: 0, recordIsNull: false, limit: int32MaxValue),
      ApiService.instance
          .getArtists(type: 2, recordIsNull: false, limit: int32MaxValue),
      ApiService.instance.getArtists(
          recordIsNull: false, typeIsNull: true, limit: int32MaxValue),
    ];
    return await Future.wait(futures);
  }

  @override
  void initState() {
    super.initState();

    _handleDataSourceChanged();
  }

  void _handleDataSourceChanged() {
    setState(() {
      future = waitFutures();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Stack(
          children: <Widget>[
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
                        return aaaaaaa();
                      }
                    } else {
                      return Center(
                          child: Text(snapshot.connectionState.toString()));
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
              child: QuickNavContainer(
                brightness: Brightness.light,
                items: widget.gpmQuickNavItems,
                selection: 0,
                onSelectionChanged: (int position) {
                  if (widget.onSelectionChanged != null) {
                    widget.onSelectionChanged(position);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class aaaaaaa extends StatelessWidget {
  List<dynamic> datas = [];

  @override
  Widget build(BuildContext context) {
    String getTitle(int index) {
      List<String> titles = ['男歌手', '女歌手', '组合', '未知'];
      return titles[index];
    }

    int _itemCount() {
      int count = 0;

      for (int i = 0; i < datas?.length ?? 0; i++) {
        PageList<Artist> data = datas[i];

        count += 1;
        count += data?.count ?? 0;

//        print('_itemCount ${i} ${getTitle(i)} ${data?.count}');
      }

//      print('_itemCount count: ${count}');

      return count;
    }

    Widget _itemBuilder(BuildContext context, int index) {
      int start = 0;
      int end = 0;

      for (int i = 0; i < datas?.length ?? 0; i++) {
        PageList<Artist> data = datas[i];

        start = end;
        end = start + 1 + data?.count ?? 0;

//        print(
//            '_itemBuilder ${i} ${getTitle(i)} ${data?.count} start: ${start} end: ${end} ${index}');

        if (index == start) {
          return Container(
            margin: EdgeInsets.only(top: 24),
            child: HeadlineHeader(
              title: getTitle(i),
              subtitle: '共${data?.count ?? '-'}',
            ),
          );
        }

        if (index > start && index < end) {
          int realIndex = index - 1 - start;
          Artist artist = data?.results[realIndex];
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
            title: Text(artist?.name),
            subtitle: Text('${artist?.recordsCount}张唱片'),
            onTap: () {
              openArtist(context, artist);
            },
          );
        }
      }

      print('_itemBuilder end');
    }

    int _crossAxisCount() {
      if (!isLargeScreen(context)) {
        return 2;
      }
      return querySize<int>(context, {950: 4, 1400: 5});
    }

    StaggeredTile _staggeredTileBuilder(int index) {
      int start = 0;
      int end = 0;

      for (int i = 0; i < datas?.length ?? 0; i++) {
        PageList<Artist> data = datas[i];

        start = end;
        end = start + 1 + data?.count ?? 0;

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
