import 'package:flutter/material.dart';

class RecentItem extends StatelessWidget {
  final String url;

  RecentItem({this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
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
          Container(
            height: 34,
            margin: const EdgeInsets.only(top: 12),
            child: Text(
              'I Dare You (Multi-Language Duets) Radio',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
