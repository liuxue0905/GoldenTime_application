import 'package:flutter/material.dart';

class OverlayText extends StatelessWidget {
  final String text;

  OverlayText({Key key, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      constraints: BoxConstraints(
        minWidth: 32.0,
        minHeight: 32.0,
      ),
      child: Container(
        padding: EdgeInsets.only(left: 8.0, right: 8.0),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
            softWrap: false,
          ),
        ),
      ),
    );
  }
}
