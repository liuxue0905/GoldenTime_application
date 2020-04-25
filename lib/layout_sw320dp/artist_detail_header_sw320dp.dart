import 'package:flutter/material.dart';

import '../layout_swNdp/artist_detail_header_swndp.dart';
import '../model/artist.dart';

class ArtistDetailHeader_sw320dp extends ArtistDetailHeader_swndp {
  ArtistDetailHeader_sw320dp({String url, Artist artist})
      : super(url: url, artist: artist) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.0,
            child: FadeInImage(
              image: url != null ? NetworkImage(url) : NetworkImage(""),
              placeholder: AssetImage('images/default_album.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          Text(artist.name),
          Text(artist.recordsCount.toString() + "张唱片"),
          Text(artist.songsCount.toString() + "首歌曲"),
        ],
      ),
    );
  }
}
