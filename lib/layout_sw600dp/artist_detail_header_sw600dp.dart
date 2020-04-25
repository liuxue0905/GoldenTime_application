import 'package:flutter/material.dart';

import '../layout_swNdp/artist_detail_header_swndp.dart';
import '../model/artist.dart';
import '../util.dart';

class ArtistDetailHeader_sw600dp extends ArtistDetailHeader_swndp {
  ArtistDetailHeader_sw600dp({String url, Artist artist}) : super(url: url, artist: artist) {}

  @override
  Widget build(BuildContext context) {
    double scale = getScale(context, 'xl');

    Widget image = Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: Container(
          color: Colors.black,
          child: FadeInImage(
            width: 180,
            height: 180,
            image: NetworkImage(url),
            placeholder: AssetImage('images/default_album.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );

    return Container(
      margin: EdgeInsets.only(top: 64 * scale, bottom: 44 * scale),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            child: image,
          ),
          Column(
            children: <Widget>[
              Text(artist.name),
              Text(artist.recordsCount.toString() + "张唱片"),
              Text(artist.songsCount.toString() + "首歌曲"),
            ],
          ),
        ],
      ),
    );
  }
}
