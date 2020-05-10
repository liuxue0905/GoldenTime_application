import 'package:flutter/material.dart';

import '../layout_swNdp/song_detail_header_swndp.dart';
import '../model/song.dart';
import '../widget_util.dart';

class SongDetailHeader_sw600dp extends SongDetailHeader {
  SongDetailHeader_sw600dp({Song song}) : super(song: song);

  @override
  Widget build(BuildContext context) {
//    Theme.of(context).textTheme.title

    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  offset: Offset(0, 1),
                  spreadRadius: 1,
                ),
              ],
              color: Colors.grey[400],
            ),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: DefaultIconWidget(
                    icon: Icons.music_note,
                  ),
                ),
                Positioned.fill(
                  child: Image.network(
                    song?.record?.cover ?? '',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    song.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  GestureDetector(
                    child: Text(
                      '唱片：${song?.record?.title}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .apply(color: Colors.orange),
                    ),
                    onTap: () {
                      openRecord(context, song.record);
                    },
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  GestureDetector(
                    child: Text(
                      getArtistsString(song.artists),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .apply(color: Colors.orange),
                    ),
                    onTap: () {
                      onTapArtists(context, song.artists);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
