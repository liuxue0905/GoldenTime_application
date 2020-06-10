import 'package:flutter/material.dart';

import '../api_service.dart';
import '../layout_sw320dp/song_detail_header_sw320dp.dart';
import '../layout_sw600dp/song_detail_header_sw600dp.dart';
import '../layout_swNdp/song_detail_header_swndp.dart';
import '../model/song.dart';
import '../util.dart';
import '../widget_util.dart';

class SongDetailPage extends StatelessWidget {
  static const String baseRoute = '/song';
  static String Function(String slug) routeFromSlug =
      (String slug) => baseRoute + '/$slug';

  final Song song;

  SongDetailPage({this.song});

  @override
  Widget build(BuildContext context) {
    final SongDetailArguments args = ModalRoute.of(context).settings.arguments;

    return new Container(
      child: Scaffold(
        appBar: AppBar(title: Text(song.title ?? args?.song?.title ?? '')),
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
