import 'package:flutter/material.dart';

import './overlay_text.dart';

class ArtistItem extends StatelessWidget {
  final String url;
  final String title;
  final String tag;
  final GestureTapCallback onTap;

  ArtistItem({Key key, this.url, this.title, this.tag, this.onTap});

  @override
  Widget build(BuildContext context) {
//    final ThemeData theme = Theme.of(context);
//    final TextStyle titleStyle =
//        theme.textTheme.headline.copyWith(color: Colors.white);
//    final TextStyle descriptionStyle = theme.textTheme.subhead;

//    https://play-music.gstatic.com/fe/b24e511cc6d0cd0ed004b7d9bdfcfb0d/illo_default_artistradio_smallcard.png
//    https://play-music.gstatic.com/fe/b24e511cc6d0cd0ed004b7d9bdfcfb0d/illo_default_artistradio_smallcard_2x.png

    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.0,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Image.asset(
                        'images/illo_default_artistradio_smallcard.png'),
                  ),
                  Positioned.fill(
                    child: Container(
                      margin: EdgeInsets.all(16.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(url),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8.0,
                    child: OverlayText(
                      text: tag != null ? tag : '-',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 37,
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 15,
                    height: 18.0 / (37.0 / 2.0),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
