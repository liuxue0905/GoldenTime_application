import 'package:flutter/material.dart';

import '../model/artist.dart';
import '../widget_util.dart';

class ArtistBar extends StatelessWidget {
  final List<Artist> artists;

  ArtistBar({this.artists});

  @override
  Widget build(BuildContext context) {

    print('ArtistBar build');
    print('ArtistBar build artists=$artists');

    return Container(
      padding: EdgeInsets.all(0.0),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        alignment: WrapAlignment.start,
        children: artists == null
            ? null
            : artists.map((Artist artist) {
                return GestureDetector(
                  onTap: () {
                    openArtist(context, artist);
                  },
                  child: Chip(
                    key: ValueKey<String>(artist.name),
                    avatar: Stack(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: AssetImage('images/default_album.jpg'),
                        ),
                        CircleAvatar(
                          backgroundImage: NetworkImage(getArtistCover(artist, size: 40)),
                        ),
                      ],
                    ),
//              backgroundColor: Colors.grey,
                    label: Text(artist.name),
                  ),
                );
              }).toList(),
      ),
    );
  }
}
