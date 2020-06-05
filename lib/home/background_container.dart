import 'package:flutter/material.dart';

class BackgroundContainer extends StatefulWidget {
  final List<Color> backgroundColors;
  final List<String> backgroundImages;
  final int selection;

  BackgroundContainer({
    Key key,
    this.backgroundColors,
    this.backgroundImages,
    this.selection = 0,
  });

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
                backgroundColors: widget.backgroundColors,
                selection: widget.selection,
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
  final List<Color> backgroundColors;

  final int selection;

  BackgroundImageContainer({
    this.backgroundImages,
    this.backgroundColors,
    this.selection,
  });

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
//              Positioned.fill(
//                child: Stack(
//                  children: <Widget>[
//                    Positioned.fill(
//                      child: Image.network(
//                        backgroundImage,
//                        fit: BoxFit.cover,
//                      ),
//                    ),
//                  ],
//                ),
//              ),
              Positioned.fill(
                child: Stack(
                  children: backgroundImages.map((String url) {
                    int index = backgroundImages.indexOf(url);
                    return Positioned.fill(
                      child: Opacity(
                        opacity: index == selection ? 1.0 : 0.0,
                        child: Image.network(
                          url ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              Positioned.fill(
                child: BackgroundImageContainerGradient(
                  backgroundColor: backgroundColors[selection],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BackgroundImageContainerGradient extends StatelessWidget {
  final Color backgroundColor;

  BackgroundImageContainerGradient({this.backgroundColor});

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
                    backgroundColor.withOpacity(1.0),
                    backgroundColor.withOpacity(0.0),
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
                    backgroundColor.withOpacity(1.0),
                    backgroundColor.withOpacity(0.0),
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
