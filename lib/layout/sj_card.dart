import 'package:flutter/material.dart';

class SJCard4 extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  bool debug = true;

  SJCard4({this.image, this.title, this.description});

  @override
  Widget build(BuildContext context) {
    Widget _buildDefault(BuildContext context) {
      return Row(
        children: Iterable<int>.generate(5)
            .map((e) => Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset(
                      'images/default_album.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ))
            .toList(),
      );
    }

    Widget _buildDebug(BuildContext context) {
      List<Color> colors = [
        Colors.red,
        Colors.orange,
        Colors.yellow,
        Colors.green,
        Colors.blue
      ];

      return Row(
        children: colors
            .map((e) => Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      color: !debug ? Colors.transparent : e.withOpacity(0.5),
                    ),
                  ),
                ))
            .toList(),
      );
    }

    return new Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(const Radius.circular(2)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(const Radius.circular(2)),
        //clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // imageWrapper
            Container(
              child: AspectRatio(
                aspectRatio: 100 / 20,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: _buildDefault(context),
                    ),
                    Positioned.fill(
                      child: _buildDebug(context),
                    ),
                    Positioned.fill(
                      child: Image.network(image),
                    ),
                  ],
                ),
              ),
            ),
            // details
            Container(
              height: 124,
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(maxHeight: 36),
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Color.fromRGBO(33, 33, 33, 1),
                        fontSize: 16,
                        height: 1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    constraints: BoxConstraints(maxHeight: 48),
                    child: Text(
                      description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Color.fromRGBO(117, 117, 117, 1),
                        fontSize: 12,
                        height: 1,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
