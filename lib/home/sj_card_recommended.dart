import 'package:flutter/material.dart';

import '../layout/overlay_text.dart';

class SJCardRecommended extends StatelessWidget {
  SJCardRecommended({
    Key key,
    this.brightness = Brightness.light,
    this.url,
    this.title,
    this.subtitle,
    this.tag,
    this.onTap,
  });

  final Brightness brightness;
  final String url;
  final String title;
  final String subtitle;
  final String tag;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
//    final ThemeData theme = Theme.of(context);
//    final TextStyle titleStyle =
//        theme.textTheme.headline.copyWith(color: Colors.white);
//    final TextStyle descriptionStyle = theme.textTheme.subhead;

//    https://play-music.gstatic.com/fe/b24e511cc6d0cd0ed004b7d9bdfcfb0d/illo_default_artistradio_smallcard.png
//    https://play-music.gstatic.com/fe/b24e511cc6d0cd0ed004b7d9bdfcfb0d/illo_default_artistradio_smallcard_2x.png

    final bool light = brightness == Brightness.light;
    final bool dark = brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2.0),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      color: Colors.black,
                    ),
                  ),
                  Positioned.fill(
                    child: FadeInImage(
                      image: NetworkImage(url),
                      placeholder: AssetImage('images/default_album.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 8.0,
                    child: Visibility(
                      visible: tag?.isNotEmpty ?? false,
                      child: OverlayText(
                        text: tag ?? '',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 52.0,
            constraints: BoxConstraints(minHeight: 52),
            margin: EdgeInsets.only(top: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  maxLines: 2,
                  style: TextStyle(
                    color: dark
                        ? Color.fromRGBO(255, 255, 255, 1.0)
                        : Color.fromRGBO(0, 0, 0, 1.0),
                    fontSize: 14,
                    height: 1.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Container(
                  margin: EdgeInsets.only(top: 2.0),
                  child: Text(
                    subtitle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyle(
                      color: dark
                          ? Color.fromRGBO(255, 255, 255, 0.7)
                          : Color.fromRGBO(0, 0, 0, 0.7),
                      fontSize: 12,
                      height: 1.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
