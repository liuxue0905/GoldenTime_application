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
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            shape: BoxShape.circle,
                          ),
                          child: LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              return Icon(
                                Icons.account_circle,
                                color: Colors.grey,
                                size: constraints.biggest.width,
                              );
                            },
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(getArtistCover(artist, size: 40 * MediaQuery.of(context).devicePixelRatio)),
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
