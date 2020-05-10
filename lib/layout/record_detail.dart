import 'package:flutter/material.dart';

import '../api_service.dart';
import '../layout_sw320dp/record_detail_header_sw320dp.dart';
import '../layout_sw600dp/record_detail_header_sw600.dart';
import '../layout_swNdp/record_detail_header_swndp.dart';
import '../model/record.dart';
import '../model/song.dart';
import '../util.dart';
import '../widget_util.dart';
import 'image_gallery.dart';

class RecordDetailPage extends StatefulWidget {
  final Record record;

  RecordDetailPage({this.record});

  @override
  State<StatefulWidget> createState() {
    return _RecordDetailPageState();
  }
}

class _RecordDetailPageState extends State<RecordDetailPage> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.record.title),
      ),
      body: Container(
        child: FutureBuilder(
          future: ApiService.instance.fetchRecord(widget.record.id),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? RecordDetial(record: snapshot.data)
                : Center(child: CircularProgressIndicator());
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
            url: getRecordCover(record,
                size: 320 * MediaQuery.of(context).devicePixelRatio),
            title: record.title,
            subtitle: '编号：${record.number}',
            record: record,
          )
        : Sw600dpRecordDetailHeaderContainer(
            url: getRecordCover(record,
                size: 240 * MediaQuery.of(context).devicePixelRatio),
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

//              Container(
//                child: Card(
//                  child: Container(
//                    padding: EdgeInsets.all(16),
//                    child: Table(
//                      defaultVerticalAlignment:
//                          TableCellVerticalAlignment.middle,
//                      columnWidths: <int, TableColumnWidth>{
//                        0: MaxColumnWidth(
//                            FractionColumnWidth(0.2), FixedColumnWidth(80)),
//                        1: FractionColumnWidth(0.8),
//                      },
//                      children: getRecordFields(record)
//                          .map((e) => TableRow(
//                                children: <Widget>[
//                                  TableCell(
//                                    child: Container(
//                                      color: Colors.transparent,
//                                      child: Container(
//                                        padding:
//                                            EdgeInsets.only(top: 4, bottom: 4),
//                                        child: Text(
//                                          e['name'] ?? '',
//                                          style: Theme.of(context)
//                                              .textTheme
//                                              .bodyText1,
//                                        ),
//                                      ),
//                                    ),
//                                  ),
//                                  TableCell(
//                                    child: Container(
//                                      color: Colors.transparent,
//                                      child: Text(
//                                        e['value'] ?? '',
//                                        style: Theme.of(context)
//                                            .textTheme
//                                            .bodyText2,
//                                      ),
//                                    ),
//                                  ),
//                                ],
//                              ))
//                          .toList(),
//                    ),
//                  ),
//                ),
//              ),

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
        DataColumn(label: Text(""), numeric: true),
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
