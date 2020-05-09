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
          FadeInImage(
            width: 160,
            height: 160,
            image:  NetworkImage(song?.record?.cover ?? ''),
            placeholder: AssetImage('images/default_album.jpg'),
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
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
                      song.record.title,
                      style: TextStyle(fontSize: 12, color: Colors.lightBlue),
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
                      style: TextStyle(fontSize: 12, color: Colors.lightBlue),
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
