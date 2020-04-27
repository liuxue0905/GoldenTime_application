import 'package:flutter/material.dart';

import '../util.dart';

class PageIndicatorContainer extends StatefulWidget {
  final int selection;
  final bool history;

  final Brightness brightness;
  final Color backgroundColor;

  final int count;

  PageIndicatorContainer(
      {Key key,
      this.count,
      this.selection: 0,
      this.brightness: Brightness.light,
      this.backgroundColor: Colors.white,
      this.history: false});

  factory PageIndicatorContainer.forDesignTime() {
    return new PageIndicatorContainer(selection: 0);
  }

  @override
  State<StatefulWidget> createState() {
    return _PageIndicatorContainerState();
  }
}

class _PageIndicatorContainerState extends State<PageIndicatorContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: 56,
            height: 56,
            margin: EdgeInsets.only(top: 36, bottom: 16),
            child: FloatingActionButton(
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
              onPressed: () {},
              tooltip: 'I\'m Feeling Lucky',
              child: Image.asset(
                'images/ifl.png',
                width: 24,
                height: 24,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: Iterable<int>.generate(
                      1 + widget.count + (widget.history ? 1 : 0))
                  .map((e) => PageTab(
                        selected: e == widget.selection,
                        history: e == 0 && widget.history,
                        brightness: widget.brightness,
                        backgroundColor: widget.backgroundColor,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class PageTab extends StatelessWidget {
  final bool selected;
  final bool history;
  final Brightness brightness;
  final Color backgroundColor;

  PageTab({
    Key key,
    this.selected: false,
    this.history: false,
    this.brightness: Brightness.light,
    this.backgroundColor: Colors.white,
  });

  var color_selected = Color(0xFFFF3D02);

  var color_normal_light_history_and_first = Color.fromRGBO(200, 200, 200, 0.5);
  var color_normal_light = Color.fromRGBO(0, 0, 0, 0.3);
  var color_normal_dark = Color.fromRGBO(255, 255, 255, 0.3);

  @override
  Widget build(BuildContext context) {
    final bool isDark = brightness == Brightness.dark;

//    print('isDark: $isDark');
//    print('backgroundColor: $backgroundColor');
//    print('backgroundColor == Colors.white: ${backgroundColor == Colors.white}');

    Widget _icon;

    Color _color = selected
        ? color_selected
        : (isDark
            ? color_normal_dark
            : (backgroundColor == Color.fromRGBO(250, 250, 250, 1.0)
                ? color_normal_light_history_and_first
                : color_normal_light));

    if (history) {
      _icon = Icon(
        Icons.history,
        color: _color,
        size: 12,
      );
    } else {
      _icon = Image.asset(
        'images/sj_dot.png',
        color: _color,
      );
    }

    return Container(
      height: 16,
      padding: EdgeInsets.only(top: 2, bottom: 2),
      child: Container(
        child: Container(
          width: 12,
          height: 12,
          child: _icon,
        ),
      ),
    );
  }
}
