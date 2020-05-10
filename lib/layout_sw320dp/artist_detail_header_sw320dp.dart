import 'package:flutter/material.dart';

import '../layout_swNdp/artist_detail_header_swndp.dart';
import '../model/artist.dart';
import '../widget_util.dart';

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
          Container(
            color: Colors.grey[400],
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: DefaultIconWidget(
                      icon: Icons.account_circle,
                    ),
                  ),
                  Positioned.fill(
                    child: Image.network(
                      url ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(artist.name, style: Theme.of(context).textTheme.headline4,),
                Text(artist.getTypeText() ?? '-'),
                Text(artist.recordsCount.toString() + "张唱片"),
                Text(artist.songsCount.toString() + "首歌曲"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
