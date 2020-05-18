import 'package:flutter/material.dart';

class BackgroundContainer extends StatefulWidget {
  final List<Color> backgroundColors;
  final List<String> backgroundImages;
  final int selection;

  BackgroundContainer(
      {Key key,
      this.backgroundColors,
      this.backgroundImages,
      this.selection = 0});

  @override
  State<StatefulWidget> createState() {
    return _BackgroundContainerState();
  }
}

class _BackgroundContainerState extends State<BackgroundContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            // backgroundColor
            Positioned.fill(
              child: Container(
                color: widget.backgroundColors[widget.selection],
              ),
            ),
            // backgroundImageContainer
            Positioned.fill(
              child: BackgroundImageContainer(
                backgroundImages: widget.backgroundImages,
                backgroundImage:
                    widget.backgroundImages[widget.selection] ?? '',
                backgroundColor: widget.backgroundColors[widget.selection],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BackgroundImageContainer extends StatelessWidget {
  final List<String> backgroundImages;
  final String backgroundImage;
  final Color backgroundColor;

  BackgroundImageContainer(
      {this.backgroundImages, this.backgroundImage, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          width: (60 * MediaQuery.of(context).size.width / 100).roundToDouble(),
          height:
              (30 * MediaQuery.of(context).size.width / 100).roundToDouble(),
          child: Stack(
            children: <Widget>[
              // backgroundImages
              Positioned.fill(
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
//                          child: Image.asset(
//                            widget.backgroundImages[widget.selection] ?? '',
//                            fit: BoxFit.fill,
//                          ),
                      child: Image.network(
                        backgroundImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                child: Gradient(
                  backgroundColor: backgroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Gradient extends StatelessWidget {
  final Color backgroundColor;

  Gradient({this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                // to top
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: <Color>[
                    Color.fromRGBO(backgroundColor.red, backgroundColor.green,
                        backgroundColor.blue, 1),
                    Color.fromRGBO(backgroundColor.red, backgroundColor.green,
                        backgroundColor.blue, 0),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                // to right
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                    Color.fromRGBO(backgroundColor.red, backgroundColor.green,
                        backgroundColor.blue, 1),
                    Color.fromRGBO(backgroundColor.red, backgroundColor.green,
                        backgroundColor.blue, 0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
