import 'package:flutter/material.dart';
import '../layout/colored_now_card.dart';
import '../layout/gpm-card-grid.dart';
import '../layout/gpm-headline-header.dart';
import 'sj_scrolling_moudle.dart';
import '../model/module.dart';

import '../util.dart';

class ModuleNow extends StatelessWidget {
  final Brightness brightness;
  final List<Module> modules;

  ModuleNow({Key key, this.brightness = Brightness.light, this.modules})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _crossAxisCount() {
      int crossAxisCount = querySize<int>(context, {1250: 2, 1400: 3});
      ;
      if (MediaQuery.of(context).size.width < 450) {
        crossAxisCount = 1;
      }
      return crossAxisCount;
    }

    List<Module> _modules = modules;

    if (_crossAxisCount() == 1) {
      _modules = modules.sublist(0, 1);
    } else if (_crossAxisCount() == 2) {
      _modules = modules.sublist(0, 4);
    } else if (_crossAxisCount() == 3) {
      _modules = modules.sublist(0, 6);
    }

    return SJScrollingMoudle(
      moduleType: Module.MODULE_TOKEN_NOW,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          HeadlineHeader(
            brightness: brightness,
            title: '今日推荐',
            subtitle: null,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Opacity(
                opacity: 0.3,
                child: RawMaterialButton(
                  constraints: BoxConstraints.tightFor(
                    width: 48.0,
                    height: 48.0,
                  ),
                  onPressed: null,
                  fillColor: Color.fromRGBO(0, 0, 0, 0.1),
                  elevation: 0,
                  shape: CircleBorder(),
                  child: Icon(
                    Icons.chevron_left,
                    color: Color.fromRGBO(0, 0, 0, 0.54),
                  ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Opacity(
                opacity: 1.0,
                child: RawMaterialButton(
                  constraints: BoxConstraints.tightFor(
                    width: 48.0,
                    height: 48.0,
                  ),
                  onPressed: null,
                  fillColor: Color.fromRGBO(0, 0, 0, 0.1),
                  elevation: 0,
                  shape: CircleBorder(),
                  child: Icon(
                    Icons.chevron_right,
                    color: Color.fromRGBO(0, 0, 0, 0.54),
                  ),
                ),
              ),
            ],
          ),
          GPMCardGrid(
            // 右 0， 上 0
            crossAxisCount: _crossAxisCount(),
            mainAxisSpacing: isLargeScreen(context) ? 16 : 8,
            crossAxisSpacing: isLargeScreen(context) ? 16 : 8,
            children: _modules
                .map((Module module) => ColoredNowCard(
                      header: module.header,
                      reason: module.reason,
                      title: module.title,
                      description: module.description,
                      backgroundImage: module.backgroundImage,
                      backgroundColor: module.backgroundColor,
                      separatorColor: module.separatorColor ??
                          (getBrightness(module.backgroundColor) ==
                                  Brightness.light
                              ? Colors.grey[900]
                              : Colors.white),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
