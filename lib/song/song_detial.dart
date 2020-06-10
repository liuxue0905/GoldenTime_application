import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

import '../api_service.dart';
import '../layout_sw320dp/song_detail_header_sw320dp.dart';
import '../layout_sw600dp/song_detail_header_sw600dp.dart';
import '../layout_swNdp/song_detail_header_swndp.dart';
import '../model/song.dart';
import '../util.dart';
import '../widget_util.dart';

class SongDetailPage extends StatefulWidget {

  static const String baseRoute = '/song';
  static String Function(String slug) routeFromSlug =
      (String slug) => baseRoute + '/$slug';

  final Song song;

  SongDetailPage({this.song});

  @override
  State<StatefulWidget> createState() {
    return _SongDetailPageState();
  }
}

class _SongDetailPageState extends State<SongDetailPage> {

  Future<Song> future;

  @override
  void initState() {
    super.initState();

    _handleDataSourceChanged();
  }

  @override
  void didUpdateWidget(SongDetailPage oldWidget) {
    super.didUpdateWidget(oldWidget);
//    if (oldWidget != widget) {
//      _handleDataSourceChanged();
//    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleDataSourceChanged() {
    setState(() {
      this.future = ApiService.instance.fetchSong(widget.song?.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final SongDetailArguments args = ModalRoute.of(context).settings.arguments;

    return new Container(
      child: Scaffold(
        appBar: AppBar(title: Text(widget.song?.title ?? args?.song?.title ?? '')),
        body: Container(
          child: FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (kDebugMode) {
                print('snapshot.connectionState = ${snapshot.connectionState}');
                print('snapshot.hasData = ${snapshot.hasData.toString()}');
                print('snapshot.hasError = ${snapshot.hasError.toString()}');
                print('snapshot.error = ${snapshot.error.toString()}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return WaitingWidget();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return FutureErrorWidget(
                      onPressed: () {
                        _handleDataSourceChanged();
                      },
                      error: snapshot.error);
                }
                if (snapshot.hasData) {
                  return SongDetail(song: snapshot.data);
                }
              } else {
                return Center(child: Text(snapshot.connectionState.toString()));
              }

              return null;
            },
          ),
        ),
      ),
    );
  }
}

class SongDetail extends StatelessWidget {
  final Song song;

  SongDetail({this.song});

  @override
  Widget build(BuildContext context) {
    SongDetailHeader header;
    if (!isLargeScreen(context)) {
      header = SongDetailHeader_sw320dp(song: song);
    } else {
      header = SongDetailHeader_sw600dp(song: song);
    }

    return Container(
      child: SingleChildScrollView(
        child: Container(
          margin: getDetailContainerMargin(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              header,
              Card(
                clipBehavior: Clip.antiAlias,
                child: DataTable(
                  headingRowHeight: 0,
                  columns: <DataColumn>[
                    DataColumn(
                      label: SizedBox(
                        height: 0,
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        height: 0,
                      ),
                    ),
                  ],
                  rows: getSongFields(song)
                      .map((e) => DataRow(cells: <DataCell>[
                            DataCell(Text(
                              e['name'] ?? '',
                              style: Theme.of(context).textTheme.bodyText1,
                            )),
                            DataCell(SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text(
                                e['value'] ?? '',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            )),
                          ]))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SongDetailArguments {
  int id;
  Song song;

  SongDetailArguments({
    this.id,
    this.song,
  });
}
