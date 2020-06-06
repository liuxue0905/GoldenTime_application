import 'package:flutter/material.dart';

import '../api_service.dart';
import '../layout_sw320dp/song_detail_header_sw320dp.dart';
import '../layout_sw600dp/song_detail_header_sw600dp.dart';
import '../layout_swNdp/song_detail_header_swndp.dart';
import '../model/song.dart';
import '../util.dart';
import '../widget_util.dart';

class SongDetailPage extends StatelessWidget {
  final Song song;

  SongDetailPage({this.song});

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Scaffold(
        appBar: AppBar(title: Text(song.title ?? '')),
        body: Container(
          child: FutureBuilder(
            future: ApiService.instance.fetchSong(song.id),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);

              return snapshot.hasData
                  ? SongDetail(song: snapshot.data)
                  : Center(child: CircularProgressIndicator());
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
//              Card(
//                child: Container(
//                  padding: EdgeInsets.all(16),
//                  child: Table(
//                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//                    columnWidths: <int, TableColumnWidth>{
//                      0: MaxColumnWidth(
//                          FractionColumnWidth(0.2), FixedColumnWidth(40)),
//                      1: FractionColumnWidth(0.8),
//                    },
//                    children: getSongFields(song)
//                        .map((e) => TableRow(
//                              children: <Widget>[
//                                TableCell(
//                                  child: Container(
//                                    color: Colors.transparent,
//                                    child: Container(
//                                      padding:
//                                          EdgeInsets.only(top: 4, bottom: 4),
//                                      child: Text(
//                                        e['name'] ?? '',
//                                        style: Theme.of(context)
//                                            .textTheme
//                                            .bodyText1,
//                                      ),
//                                    ),
//                                  ),
//                                ),
//                                TableCell(
//                                  child: Container(
//                                    color: Colors.transparent,
//                                    child: Text(
//                                      e['value'] ?? '',
//                                      style:
//                                          Theme.of(context).textTheme.bodyText2,
//                                    ),
//                                  ),
//                                ),
//                              ],
//                            ))
//                        .toList(),
//                  ),
//                ),
//              ),
            ],
          ),
        ),
      ),
    );
  }
}
