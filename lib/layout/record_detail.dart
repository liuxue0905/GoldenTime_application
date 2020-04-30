import 'package:flutter/material.dart';

import '../api_service.dart';
import '../layout_sw320dp/record_detail_header_sw320dp.dart';
import '../layout_sw600dp/record_detail_header_sw600.dart';
import '../layout_swNdp/record_detail_header_swndp.dart';
import '../model/record.dart';
import '../model/song.dart';
import '../util.dart';
import '../widget_util.dart';

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
    bool largeScreen = isLargeScreen(context);
    String deviceType = getDeviceType(context);

//    /// xl
//    double imageWidth = 180;

    double scale = getScale(context, 'xl');

    print('scale: $scale');

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
    bool largeScreen = isLargeScreen(context);

    SwNdpRecordDetailHeaderContainer header;

    header = !largeScreen
        ? Sw320dpRecordDetailHeaderContainer(
            url: getRecordImage(record),
            title: record.title,
            subtitle: record.number,
            record: record,
          )
        : Sw600dpRecordDetailHeaderContainer(
            url: getRecordImage(record),
            title: record.title,
            subtitle: record.number,
            record: record,
          );

    var _margin = EdgeInsets.fromLTRB(96, 32, 96, 32);
    String deviceType = getDeviceType(context);
    if (deviceType == 'xs' || deviceType == 'sm' || deviceType == 'md') {
      _margin = EdgeInsets_fromLTRB(context, 'xl', 96, 32, 96, 32);
    }

    return Container(
      child: SingleChildScrollView(
        child: Container(
          margin: _margin,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              header,
              RecordSongs(
                songs: record.songs,
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
    var _card = Card(
      semanticContainer: false,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: _dataTable,
      ),
    );

    String deviceType = getDeviceType(context);

    if (deviceType != 'xs') {
      _card = Card(
        semanticContainer: false,
        child: _dataTable,
      );
    }

    return _card;
  }
}
