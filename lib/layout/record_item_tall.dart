import 'package:flutter/material.dart';

import './overlay_text.dart';

class RecordItemTall extends StatelessWidget {

  Brightness brightness;

  final String url;
  final String title;
  final String subtitle;
  final String description;
  final String tag;
  final GestureTapCallback onTap;

//  RecordItemTall(Record record) {
//
//  }

  RecordItemTall({
    Key key,
    this.brightness: Brightness.dark,
    this.url,
    this.title,
    this.subtitle,
    this.description,
    this.tag,
    this.onTap
  });

//  factory RecordItemTall.forDesignTime() {
//    return new RecordItemTall(
//      url:
//          'https://p2.music.126.net/3VCqOJSYLEAiCtodKgxrXg==/2528876744253082.jpg?param=946y946',
//      title: 'AAA',
//      subtitle: 'BBB',
//      description:
//          'A personalized mix of newly released songs. Updated daily. A personalized mix of newly released songs. Updated daily.',
//    );
//  }

  @override
  Widget build(BuildContext context) {
//    final ThemeData theme = Theme.of(context);
//    final TextStyle titleStyle =
//        theme.textTheme.headline.copyWith(color: Colors.white);
//    final TextStyle descriptionStyle = theme.textTheme.subhead;

//    https://play-music.gstatic.com/fe/b24e511cc6d0cd0ed004b7d9bdfcfb0d/illo_default_artistradio_smallcard.png
//    https://play-music.gstatic.com/fe/b24e511cc6d0cd0ed004b7d9bdfcfb0d/illo_default_artistradio_smallcard_2x.png

    final bool isDark = brightness == Brightness.dark;

    return GestureDetector(
      onTap: this.onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.0,
            child: ClipRRect(
              borderRadius: new BorderRadius.circular(2.0),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(color: Colors.black),
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
                    child: OverlayText(
                      text: tag != null ? tag : '-',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 80.0,
            constraints: BoxConstraints(minHeight: 80),
            margin: EdgeInsets.only(top: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  maxLines: 2,
                  style: TextStyle(
                    color: isDark
                        ? Color.fromRGBO(255, 255, 255, 1.0)
                        : Color.fromRGBO(0, 0, 0, 1.0),
                    fontSize: 14,
                    height: 18 / 14,
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
                      color: isDark
                          ? Color.fromRGBO(255, 255, 255, 0.7)
                          : Color.fromRGBO(0, 0, 0, 0.7),
                      fontSize: 12,
                      height: 1.0,
                    ),
                  ),
                ),
                Container(
                  height: 28,
                  margin: EdgeInsets.only(top: 2.0),
                  child: Text(
                    description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      color: isDark
                          ? Color.fromRGBO(255, 255, 255, 0.7)
                          : Color.fromRGBO(0, 0, 0, 0.7),
                      fontSize: (12 - 2.0),
                      height: 1.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
