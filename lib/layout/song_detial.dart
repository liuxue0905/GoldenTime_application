import 'package:flutter/material.dart';

import '../api_service.dart';
import '../layout_sw320dp/song_detail_header_sw320dp.dart';
import '../layout_sw600dp/song_detail_header_sw600dp.dart';
import '../layout_swNdp/song_detail_header_swndp.dart';
import '../model/song.dart';
import '../util.dart';

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
    bool largeScreen = isLargeScreen(context);

    SongDetailHeader header;

    if (!largeScreen) {
      header = SongDetailHeader_sw320dp(song: song);
    } else {
      header = SongDetailHeader_sw600dp(song: song);
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[header, Text(song.title)],
      ),
    );
  }
}
