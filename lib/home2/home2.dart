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

class FutrueSubscriber<T> {
  final Future<T> future;
  final T initialData;

  final ValueChanged<AsyncSnapshot<T>> onChanged;

  FutrueSubscriber({
    this.future,
    this.initialData,
    @required this.onChanged,
  }) {
    c();
  }

  Object _activeCallbackIdentity;
  AsyncSnapshot<T> _snapshot;

  void c() {
    _snapshot = AsyncSnapshot<T>.withData(ConnectionState.none, initialData);
    _subscribe();
  }

  void efg() {
    if (_activeCallbackIdentity != null) {
      _unsubscribe();
      _snapshot = _snapshot.inState(ConnectionState.none);
    }
    _subscribe();
  }

  void _subscribe() {
    if (future != null) {
      final Object callbackIdentity = Object();
      _activeCallbackIdentity = callbackIdentity;
      future.then<void>((T data) {
        if (_activeCallbackIdentity == callbackIdentity) {
//          setState(() {
          _snapshot = AsyncSnapshot<T>.withData(ConnectionState.done, data);

          if (onChanged != null) {
            onChanged(_snapshot);
          }
//          });
        }
      }, onError: (Object error) {
        if (_activeCallbackIdentity == callbackIdentity) {
//          setState(() {
          _snapshot = AsyncSnapshot<T>.withError(ConnectionState.done, error);

          if (onChanged != null) {
            onChanged(_snapshot);
          }
//          });
        }
      });
      _snapshot = _snapshot.inState(ConnectionState.waiting);
    }
  }

  void _unsubscribe() {
    _activeCallbackIdentity = null;
  }
}

const int int32MaxValue = 2147483647;

class Home2PageState extends State<Home2Page> {
  List<Future<PageList<Artist>>> futures;

  Map<int, dynamic> snapshots = {};
  Map<int, PageList<Artist>> datas = {};

  @override
  void initState() {
    super.initState();

    futures = [
      ApiService.instance
          .getArtists(type: 1, recordIsNull: false, limit: int32MaxValue),
      ApiService.instance
          .getArtists(type: 0, recordIsNull: false, limit: int32MaxValue),
      ApiService.instance
          .getArtists(type: 2, recordIsNull: false, limit: int32MaxValue),
      ApiService.instance.getArtists(
          recordIsNull: false, typeIsNull: true, limit: int32MaxValue),
    ];

    futures.asMap().forEach((int index, Future<PageList<Artist>> future) {
      FutrueSubscriber(
        future: future,
        onChanged: (snapshot) {
          print('FutrueSubscriber ${index}: ${snapshot}');
//          print('FutrueSubscriber ${index}: ${snapshot} ${snapshot?.data}');
          setState(() {
            snapshots[index] = snapshot;
            datas[index] = snapshot.data;
          });
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    print('snapshot: ${snapshots}');
    print('datas: ${datas}');
    print('datas?.keys: ${datas?.keys}');

    String getTitle(int index) {
      List<String> titles = ['男歌手', '女歌手', '组合', '未知'];
      return titles[index];
    }

    int _itemCount() {
      int count = 0;

      for (int i = 0; i < futures.length; i++) {
        Future<PageList<Artist>> future = futures[i];
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

      for (int i = 0; i < futures.length; i++) {
        Future<PageList<Artist>> future = futures[i];
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
                      child: Image.network(artist?.cover ?? ''),
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

    int _crossAxisCount = querySize<int>(context, {600: 2, 950: 4, 1400: 5});

    StaggeredTile _staggeredTileBuilder(int index) {
      int start = 0;
      int end = 0;

      for (int i = 0; i < futures.length; i++) {
        Future<PageList<Artist>> future = futures[i];
        PageList<Artist> data = datas[i];

        start = end;
        end = start + 1 + data?.count ?? 0;

//        print(
//            '_staggeredTileBuilder ${i} ${getTitle(i)} ${data?.count} start: ${start} end: ${end} ${index}');

        if (index == start) {
          return StaggeredTile.fit(_crossAxisCount);
        }

        if (index > start && index < end) {
          return StaggeredTile.fit(1);
        }
      }

      print('_staggeredTileBuilder end');
    }

    return Container(
      child: Container(
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: StaggeredGridView.countBuilder(
                padding: getListContainerMargin(context),
                crossAxisCount: _crossAxisCount,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                itemCount: _itemCount(),
                itemBuilder: _itemBuilder,
                staggeredTileBuilder: _staggeredTileBuilder,
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
