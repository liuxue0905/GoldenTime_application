import 'package:flutter/material.dart';

import '../layout_swNdp/song_detail_header_swndp.dart';
import '../model/song.dart';
import '../widget_util.dart';

class SongDetailHeader_sw320dp extends SongDetailHeader {
  SongDetailHeader_sw320dp({Song song}) : super(song: song);

  @override
  Widget build(BuildContext context) {
    String url =
        "https://p1.music.126.net/_aDUl2D0Z8YACL2fLZOvXg==/569547023195052.jpg?param=177y177";

    return Card(
      semanticContainer: false,
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            FadeInImage(
              width: 72,
              height: 72,
              image: url != null ? NetworkImage(url) : NetworkImage(""),
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
      ),
    );
  }
}
