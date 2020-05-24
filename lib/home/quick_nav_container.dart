import 'package:flutter/material.dart';

import '../models.dart';

typedef OnItemClick = void Function(int position);

class QuickNavContainer extends StatefulWidget {
  final Brightness brightness;
  final List<GPMQuickNavItem> items;
  final int selection;
  final ValueChanged<int> onSelectionChanged;

  QuickNavContainer({
    Key key,
    this.brightness = Brightness.light,
    this.items,
    this.selection = 0,
    this.onSelectionChanged,
  });

  @override
  State<StatefulWidget> createState() {
    return _QuickNavContainer();
  }
}

class _QuickNavContainer extends State<QuickNavContainer> {
  int _selection;

  @override
  void initState() {
    super.initState();
    _handleDataSourceChanged();
  }

  @override
  void didUpdateWidget(QuickNavContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
//    if (oldWidget != widget) {
//      _handleDataSourceChanged();
//    }
  }

  void _handleDataSourceChanged() {
    setState(() {
      _selection = widget.selection;
//    print('widget.selection = ${widget.selection}');
//    print('_selection = ${_selection}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        child: Container(
          constraints: BoxConstraints(
            minHeight: 336,
          ),
          width: 72,
          padding: EdgeInsets.only(top: 16),
          child: Column(
            children: widget.items?.map<Widget>((GPMQuickNavItem item) {
              int index = widget.items.indexOf(item);

              return QuickNavItem(
                brightness: widget.brightness,
                iconData: item.icon,
                text: item.text,
                selected: index == _selection,
                onPress: () {
                  setState(() {
                    _selection = index;
                  });

                  if (widget.onSelectionChanged != null) {
                    widget.onSelectionChanged(index);
                  }
                },
              );
            })?.toList(),
          ),
        ),
      ),
    );
  }
}

class QuickNavItem extends StatelessWidget {
  QuickNavItem(
      {Key key,
      this.brightness: Brightness.light,
      this.iconData,
      this.text,
      this.onPress,
      this.selected: false});

  final Brightness brightness;
  final IconData iconData;
  final String text;

  final VoidCallback onPress;

  final bool selected;

  @override
  Widget build(BuildContext context) {
    final bool isDark = brightness == Brightness.dark;

    var color_selected = Colors.deepOrange[400];
    var color_normal_light = Colors.black.withOpacity(0.7);
    var color_normal_dark = Colors.white.withOpacity(0.7);

    var color = selected
        ? color_selected
        : (isDark ? color_normal_dark : color_normal_light);

    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(),
        width: 72,
        height: 72,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 24,
              height: 24,
              child: Icon(
                iconData,
                color: color,
              ),
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: 60,
              ),
              margin: EdgeInsets.only(top: 4),
              child: Text(
                text,
                maxLines: 2,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.center,
                style: TextStyle(color: color, fontSize: 10.0, height: 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
