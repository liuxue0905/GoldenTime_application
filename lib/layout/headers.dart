import 'package:flutter/material.dart';

class ClusterHeader extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  ClusterHeader({this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8, right: 8),
      child: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 16),
                child: Text(
                  title ?? 'Top albums',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[900],
                      height: 24.0 / 18.0),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: RaisedButton(
                color: Colors.deepOrange,
                textColor: Colors.white,
                child: Text('SEE ALL'),
                onPressed: () {
                  if (onPressed != null) {
                    onPressed.call();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlayHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onPressed;

  PlayHeader({this.title, this.subtitle, this.buttonText, this.onPressed});

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
            child: Container(
              child: RaisedButton(
                color: Colors.deepOrange,
                textColor: Colors.white,
                child: Text(buttonText ?? '查看更多'),
                onPressed: () {
                  onPressed.call();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
