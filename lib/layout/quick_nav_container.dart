import 'package:flutter/material.dart';

import '../models.dart';

typedef OnItemClick = void Function(int position);

class QuickNavContainer extends StatefulWidget {
  Brightness brightness = Brightness.light;
  int selection = 0;

  QuickNavContainer(
      {Key key, this.brightness, this.selection, this.onItemClick});

  final OnItemClick onItemClick;

//  final ValueChanged<int> onChanged;

  @override
  State<StatefulWidget> createState() {
    return _QuickNavContainer();
  }
}

class _QuickNavContainer extends State<QuickNavContainer> {
  List<Item> items = [
    Item(icon: Icons.home, text: '首页'),
    Item(icon: Icons.album, text: '唱片'),
    Item(icon: Icons.account_box, text: '歌手'),
    Item(icon: Icons.library_music, text: '歌曲'),
  ];

  int _selection = 0;

  @override
  void didUpdateWidget(QuickNavContainer oldWidget) {
    // TODO: implement didUpdateWidget

    print('_QuickNavContainer didUpdateWidget()');

    if (oldWidget.selection != widget.selection) {
      setState(() {
        _selection = widget.selection;
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        constraints: BoxConstraints(
          minHeight: 336,
        ),
        width: 72,
        padding: EdgeInsets.only(top: 16),
        child: Column(
          children: items.map<Widget>((Item item) {
            int index = items.indexOf(item);

            return QuickNavItem(
              brightness: widget.brightness,
              iconData: item.icon,
              text: item.text,
              selected: index == _selection,
              onItemTap: () {
                widget.onItemClick(index);

                setState(() {
                  _selection = index;
                });
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

typedef ItemTapCallback = void Function();

class QuickNavItem extends StatelessWidget {
  QuickNavItem(
      {Key key,
      this.brightness : Brightness.light,
      this.iconData,
      this.text,
      this.onItemTap,
      this.selected: false});

  final Brightness brightness;
  final IconData iconData;
  final String text;

  final ItemTapCallback onItemTap;

  final bool selected;

  factory QuickNavItem.forDesignTime() {
    // TODO: add arguments
    return new QuickNavItem(
      iconData: Icons.branding_watermark,
      text: 'Title',
      selected: true,
      onItemTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = brightness == Brightness.dark;

//    var color_selected = Color.fromRGBO(255, 61, 2, 0.7);
//    var color_normal_light = Color.fromRGBO(0, 0, 0, 0.7);
//    var color_normal_dark = Color.fromRGBO(255, 255, 255, 0.7);

    var color_selected = Colors.deepOrange[400];
    var color_normal_light = Colors.black.withOpacity(0.7);
    var color_normal_dark = Colors.white.withOpacity(0.7);

    var color = selected
        ? color_selected
        : (isDark ? color_normal_dark : color_normal_light);

    return GestureDetector(
      onTap: onItemTap,
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
                style:
                    TextStyle(color: color, fontSize: 10.0, height: 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
