import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red.withOpacity(0.3),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 256,
              height: 256,
              color: Colors.blue,
//              child: SvgPicture.asset(
//                'images/svg/splash_screen.svg',
//              ),
            ),
            // width: 512px; margin-top: 112px; height: 4px; border-radius: 2px; background: #f5f5f5;
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                color: Colors.blueGrey
              ),
              width: 512,
              height: 4,
              margin: EdgeInsets.only(top: 112),
//              color: Colors.grey[100],
            ),
            Container(
              margin: EdgeInsets.only(top: 56),
              color: Colors.lightBlueAccent,
              child: Text(
                'Loading Music Library…',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
