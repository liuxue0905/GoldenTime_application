import 'package:flutter/material.dart';

class RecentItem extends StatelessWidget {
  final Brightness brightness;
  final String url;

  RecentItem({this.brightness, this.url});

  @override
  Widget build(BuildContext context) {
    bool light = brightness == Brightness.light;

    return Container(
      margin: EdgeInsets.only(right: 8),
      width: 90,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.0),
                ),
                child: Container(
                  child: FadeInImage(
                    image: NetworkImage(url ?? ''),
                    placeholder: AssetImage('images/default_album.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 34,
            margin: const EdgeInsets.only(top: 12),
            child: Text(
              'I Dare You (Multi-Language Duets) Radio',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: light ? Colors.black : Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
