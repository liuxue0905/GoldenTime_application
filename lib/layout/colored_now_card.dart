import 'package:flutter/material.dart';

class ColoredNowCard extends StatelessWidget {
  String header =
      'Recommended new releases Recommended new releases Recommended new releases';
  String reason = 'Popular this week';
  String title = 'Victory Lap Victory Lap Victory Lap Victory Lap';
  String description =
      'Album by Nipsey Hussle • 16 songs Album by Nipsey Hussle • 16 songs Album by Nipsey Hussle • 16 songs Album by Nipsey Hussle • 16 songs';

  String backgroundImage;
  Color backgroundColor;

  ColoredNowCard(
      {this.header,
      this.reason,
      this.title,
      this.description,
      this.backgroundImage,
      this.backgroundColor});

  Color textSeparatorColor = Color.fromARGB(255, 255, 255, 1);

  double scale = 0.6;

  factory ColoredNowCard.forDesignTime() {
    return new ColoredNowCard();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AspectRatio(
        aspectRatio: 100 / 80,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
//              child: Image.asset(
//                'images/colored_now_card.jpg',
//                fit: BoxFit.cover,
//              ),
              child: Image.network(backgroundImage),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
//                      Color.fromRGBO(0, 0, 0, 1.0),
//                      Color.fromRGBO(0, 0, 0, 0.5)
                    backgroundColor.withOpacity(1.0),
                    backgroundColor.withOpacity(0.5),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 4),
                    child: Text(
                      header ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontSize: 24,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    reason ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.702),
                        fontSize: 14,
                        fontStyle: FontStyle.italic),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16, bottom: 16),
                    width: 40,
                    height: 2,
                    color: textSeparatorColor,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 4),
                    padding: EdgeInsets.only(right: 64 * scale),
                    child: Text(
                      title ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 0.702),
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 64 * scale),
                    child: Text(
                      description ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 0.702),
                          fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
