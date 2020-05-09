import 'package:flutter/material.dart';

import '../layout_swNdp/song_detail_header_swndp.dart';
import '../model/song.dart';
import '../widget_util.dart';

class SongDetailHeader_sw320dp extends SongDetailHeader {
  SongDetailHeader_sw320dp({Song song}) : super(song: song);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          FadeInImage(
            width: 72,
            height: 72,
            image: NetworkImage(song?.record?.cover ?? ''),
            placeholder: AssetImage('images/default_album.jpg'),
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    song.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
//            Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
