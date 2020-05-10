import 'package:flutter/material.dart';
import 'package:flutter_app_golden_time/util.dart';

class ColoredNowCard extends StatelessWidget {
  final String header;
  final String reason;
  final String title;
  final String description;

  final String backgroundImage;
  final Color backgroundColor;
  final Color separatorColor;

  ColoredNowCard({
    this.header,
    this.reason,
    this.title,
    this.description,
    this.backgroundImage,
    this.backgroundColor,
    this.separatorColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    Brightness brightness = getBrightness(backgroundColor);

    bool light = brightness == Brightness.light;
    bool dark = brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(const Radius.circular(2)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.12),
            offset: Offset(0, 1),
          ),
        ],
      ),
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
              child: Image.network(backgroundImage ?? ''),
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
                          color: light
                              ? Color.fromRGBO(0, 0, 0, 1)
                              : Color.fromRGBO(255, 255, 255, 1),
                          fontSize: 24,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Visibility(
                    visible: reason?.isNotEmpty ?? false,
                    child: Text(
                      reason ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: light
                            ? Color.fromRGBO(0, 0, 0, 0.702)
                            : Color.fromRGBO(255, 255, 255, 0.702),
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16, bottom: 16),
                    width: 40,
                    height: 2,
                    color:
                        separatorColor ?? (light ? Colors.grey[900] : Colors.white),
                  ),
                  Visibility(
                    visible: title?.isNotEmpty ?? false,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 4),
                      padding: isLargeScreen(context) ? EdgeInsets.only(right: 64) : EdgeInsets_only(context, 950, right: 64),
                      child: Text(
                        title ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: light
                              ? Color.fromRGBO(0, 0, 0, 0.702)
                              : Color.fromRGBO(255, 255, 255, 0.702),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: description?.isNotEmpty ?? false,
                    child: Container(
                      padding: isLargeScreen(context) ? EdgeInsets.only(right: 64) : EdgeInsets_only(context, 950, right: 64),
                      child: Text(
                        description ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: light
                                ? Color.fromRGBO(0, 0, 0, 0.702)
                                : Color.fromRGBO(255, 255, 255, 0.702),
                            fontSize: 12),
                      ),
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
