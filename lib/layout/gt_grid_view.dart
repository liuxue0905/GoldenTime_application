import 'package:flutter/material.dart';

class GTGridView extends StatelessWidget {
  EdgeInsetsGeometry padding;

  int crossAxisCount;
  List<Widget> children;

  GTGridView({
    Key key,
    Axis direction = Axis.vertical,
    this.padding,
    @required int crossAxisCount,
    double mainAxisSpacing = 0.0,
    double crossAxisSpacing = 0.0,
    List<Widget> children = const <Widget>[],
  })  : crossAxisCount = crossAxisCount,
        children = children;

  GTGridView.count({
    Key key,
    Axis direction = Axis.vertical,
    EdgeInsetsGeometry padding,
    @required int crossAxisCount,
    double mainAxisSpacing = 0.0,
    double crossAxisSpacing = 0.0,
    List<Widget> children = const <Widget>[],
  });

  @override
  Widget build(BuildContext context) {
    GridView.count(crossAxisCount: 1);

    List<Widget> _mainAxisChildren = <Widget>[];

    int _mainAxisCount =
        (children.length + crossAxisCount - 1) ~/ crossAxisCount;

//    print('children.length=${children.length}');
//    print('_mainAxisCount=$_mainAxisCount');

    for (int i = 0; i < _mainAxisCount; i++) {
      List<Widget> _crossAxisChildren = <Widget>[];

      for (int j = 0; j < crossAxisCount; j++) {
//        print('main ${i} cross ${j}');
        Widget _crossAxisChild;

        if (i * crossAxisCount + j < children.length) {
          _crossAxisChild = children[i * crossAxisCount + j];
        } else {
          _crossAxisChild = Container();
        }

        _crossAxisChildren.add(
          Flexible(
            flex: 1,
            child: _crossAxisChild,
          ),
        );
      }

      _mainAxisChildren.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _crossAxisChildren,
        ),
      );
    }

    return Container(
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _mainAxisChildren,
      ),
    );
  }
}