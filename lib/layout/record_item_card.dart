import 'package:flutter/material.dart';

import './overlay_text.dart';

class RecordItemCard extends StatelessWidget {
  RecordItemCard({
    Key key,
    this.url,
    this.title,
    this.subtitle,
  });

  final String url;
  final String title;
  final String subtitle;

  factory RecordItemCard.forDesignTime() {
    // TODO: add arguments
    return new RecordItemCard(
      url:
          'https://p2.music.126.net/3VCqOJSYLEAiCtodKgxrXg==/2528876744253082.jpg?param=946y946',
      title: 'title',
      subtitle: 'subtitle',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.0,
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
                    text: 'CD1',
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  title,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 18 / 15,
                  ),
                ),
                Container(
                  height: 16,
                  margin: EdgeInsets.only(top: 4),
                  child: Text(
                    subtitle,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      height: 16 / 13,
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
