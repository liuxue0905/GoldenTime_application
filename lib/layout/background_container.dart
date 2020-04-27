import 'package:flutter/material.dart';

class BackgroundContainer extends StatefulWidget {
  BackgroundContainer(
      {Key key,
      this.backgroundColors,
      this.backgroundImages,
      this.selection: 0});

  final List<Color> backgroundColors;
  final List<String> backgroundImages;
  final int selection;

  @override
  State<StatefulWidget> createState() {
    return _BackgroundContainerState();
  }
}

class _BackgroundContainerState extends State<BackgroundContainer> {
  var gradients = [];

  @override
  void initState() {
    super.initState();

    widget.backgroundColors.forEach((Color color) {
      var map = {
        'to top': <Color>[
          Color.fromRGBO(color.red, color.green, color.blue, 1),
          Color.fromRGBO(color.red, color.green, color.blue, 0)
        ],
        'to right': <Color>[
          Color.fromRGBO(color.red, color.green, color.blue, 1),
          Color.fromRGBO(color.red, color.green, color.blue, 0)
        ]
      };
      gradients.add(map);
    });

    print('gradients = ${gradients}');
  }

  @override
  Widget build(BuildContext context) {


    Widget gradient = Container(
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
                    gradients[widget.selection]['to top'][0],
                    gradients[widget.selection]['to top'][1]
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                // to top
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                    gradients[widget.selection]['to right'][0],
                    gradients[widget.selection]['to right'][1]
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

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
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: (MediaQuery.of(context).size.width / 100 * 60)
                    .roundToDouble(),
                height: (MediaQuery.of(context).size.width / 100 * 30)
                    .roundToDouble(),
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
                              widget.backgroundImages[widget.selection] ?? '',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned.fill(
                      child: gradient,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
