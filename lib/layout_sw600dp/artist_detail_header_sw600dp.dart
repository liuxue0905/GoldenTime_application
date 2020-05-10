import 'package:flutter/material.dart';

import '../layout_swNdp/artist_detail_header_swndp.dart';
import '../model/artist.dart';
import '../widget_util.dart';

class ArtistDetailHeader_sw600dp extends ArtistDetailHeader_swndp {
  ArtistDetailHeader_sw600dp({String url, Artist artist})
      : super(url: url, artist: artist) {}

  @override
  Widget build(BuildContext context) {
    Widget image = Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: Container(
          color: Colors.grey[400],
          child: Container(
            width: 180,
            height: 180,
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
      ),
    );

    return Container(
//      margin: EdgeInsets.only(top: 64, bottom: 40),
      margin: EdgeInsets.only(top: 0, bottom: 40),
      padding: EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          image,
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    artist.name,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    artist.getTypeText() ?? '-',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    '唱片：${artist?.recordsCount ?? '-'}张',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "歌曲：${artist?.songsCount ?? '-'}首",
                    style: Theme.of(context).textTheme.bodyText2,
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
