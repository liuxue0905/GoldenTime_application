import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

import '../api_service.dart';
import '../layout_sw320dp/record_detail_header_sw320dp.dart';
import '../layout_sw600dp/record_detail_header_sw600.dart';
import '../layout_swNdp/record_detail_header_swndp.dart';
import '../model/record.dart';
import '../model/song.dart';
import '../util.dart';
import '../widget_util.dart';
import '../layout/image_gallery.dart';

class RecordDetailPage extends StatefulWidget {
  static const String baseRoute = '/record';
  static String Function(String slug) routeFromSlug =
      (String slug) => baseRoute + '/$slug';

  final Record record;

  RecordDetailPage({Key key, this.record}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RecordDetailPageState();
  }
}

class _RecordDetailPageState extends State<RecordDetailPage> {
  Future<Record> future;

  @override
  void initState() {
    super.initState();

    _handleDataSourceChanged();
  }

  @override
  void didUpdateWidget(RecordDetailPage oldWidget) {
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
      this.future = ApiService.instance.fetchRecord(widget.record.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final RecordDetailArguments args =
        ModalRoute.of(context).settings.arguments;

    if (kDebugMode) {
      print('widget.record?.title = ${widget.record?.title}');
      print('args.record?.title = ${args.record?.title}');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.record?.title ?? args.record?.title ?? ''),
      ),
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
                return RecordDetial(record: snapshot.data);
              }
            } else {
              return Center(child: Text(snapshot.connectionState.toString()));
            }

            return null;
          },
        ),
      ),
    );
  }
}

class RecordDetial extends StatelessWidget {
  final Record record;

  RecordDetial({this.record});

  @override
  Widget build(BuildContext context) {
    SwNdpRecordDetailHeaderContainer header;

    header = !isLargeScreen(context)
        ? Sw320dpRecordDetailHeaderContainer(
            url: record.cover,
            title: record.title,
            subtitle: '编号：${record.number}',
            record: record,
          )
        : Sw600dpRecordDetailHeaderContainer(
            url: record.cover,
            title: record.title,
            subtitle: '编号：${record.number}',
            record: record,
          );

    return Container(
      child: SingleChildScrollView(
        child: Container(
          margin: getDetailContainerMargin(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                  rows: getRecordFields(record)
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
              RecordSongs(
                songs: record.songs,
              ),
              Visibility(
                visible: (record?.imageList?.length ?? 0) > 0,
                child: Container(
                  margin: EdgeInsets.only(top: 16),
                  child: ImageGallery(imageList: record.imageList),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecordSongs extends StatefulWidget {
  final List<Song> songs;

  RecordSongs({this.songs});

  @override
  State<StatefulWidget> createState() {
    return _RecordSongsState();
  }
}

class _RecordSongsState extends State<RecordSongs> {
  @override
  Widget build(BuildContext context) {
    var _dataTable = DataTable(
      columnSpacing: isLargeScreen(context) ? 16 : 56,
      columns: <DataColumn>[
        DataColumn(label: Text(""), numeric: false),
        DataColumn(label: Text("音乐标题")),
        DataColumn(label: Text("歌手")),
        DataColumn(label: Icon(Icons.more_horiz)),
      ],
      rows: widget.songs.map((Song song) {
        return DataRow(
          cells: <DataCell>[
            DataCell(Text(song.track)),
            DataCell(
              Text(song.title),
              onTap: () {
                openSong(context, song);
              },
            ),
            DataCell(
              getArtistsWidget(song.artists),
              onTap: () {
                onTapArtists(context, song.artists);
              },
            ),
            DataCell(
              Icon(Icons.info),
              onTap: () {
                openSong(context, song);
              },
            ),
          ],
        );
      }).toList(),
    );

    Widget _card;

    if (isLargeScreen(context)) {
      _card = Card(
        semanticContainer: false,
        child: _dataTable,
      );
    } else {
      _card = Card(
        semanticContainer: false,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: _dataTable,
        ),
      );
    }

    return _card;
  }
}

class RecordDetailArguments {
  int id;
  Record record;

  RecordDetailArguments({
    this.id,
    this.record,
  });
}