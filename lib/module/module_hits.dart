import 'package:flutter/material.dart';

import '../layout/gpm-card-grid.dart';
import '../layout/headline_header.dart';
import '../layout/sj_card.dart';
import '../layout/sj_scrolling_moudle.dart';
import '../model/module.dart';
import '../util.dart';

class ModuleHits extends StatelessWidget {
  final Brightness brightness;
  final Module module;

  ModuleHits({Key key, this.brightness = Brightness.light, this.module})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _crossAxisCount() {
      return querySize<int>(context, {950: 2, 1250: 3, 1850: 4});
    }

    return SJScrollingMoudle(
      moduleType: module.type,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          HeadlineHeader(
            brightness: brightness,
            title: module.header,
            subtitle: module.reason,
          ),
          GPMCardGrid(
            crossAxisCount: _crossAxisCount(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: module.dataList
                .map((e) => SJCard4(
                      image: e.image,
                      title: e.title,
                      description: e.description,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
