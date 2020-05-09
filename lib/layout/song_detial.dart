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
        appBar: AppBar(title: Text(song.title)),
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

    TextStyle style1 = Theme.of(context).textTheme.bodyText1;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          header,
          Card(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: <int, TableColumnWidth>{
                  0: FixedColumnWidth(40),
                  1: IntrinsicColumnWidth(flex: 1.0),
                },
                children: getSongFields(song)
                    .map((e) => TableRow(
                  children: <Widget>[
                    TableCell(
                      child: Container(
                        color: Colors.transparent,
                        child: Container(
                          padding: EdgeInsets.only(top: 4, bottom: 4),
                          child: Text(
                            e['name'] ?? '',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        color: Colors.transparent,
                        child: Text(
                          e['value'] ?? '',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ),
                  ],
                ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
