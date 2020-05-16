import 'package:flutter/material.dart';

class ArtistTypeHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  ArtistTypeHeader({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w400,
                      height: 39.0 / 28.0,
                    ),
                  ),
                  Visibility(
                    visible: subtitle?.isNotEmpty ?? false,
                    child: Text(
                      subtitle ?? '',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300,
                        height: 22.0 / 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 32),
//            child: Container(
//              child: RaisedButton(
//                color: Colors.deepOrange,
//                textColor: Colors.white,
//                child: Text(buttonText ?? '查看更多'),
//                onPressed: () {
//                  onPressed.call();
//                },
//              ),
//            ),
          ),
        ],
      ),
    );
  }
}