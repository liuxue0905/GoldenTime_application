import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'colored_now_card.dart';
import '../layout/gpm-card-grid.dart';
import 'gpm-headline-header.dart';
import '../model/module.dart';
import '../util.dart';
import 'sj_scrolling_moudle.dart';

class ModuleNow extends StatefulWidget {
  final Brightness brightness;
  final List<Module> modules;

  ModuleNow({Key key, this.brightness = Brightness.light, this.modules})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ModuleNowState();
  }
}

class ModuleNowState extends State<ModuleNow> {
  int _offset = 0;
  PaginatedButtonsSource _source;

  void onPageChanged(int value) {
    setState(() {
      _offset = value;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _source ??= MyPaginatedButtonsSource(count: widget.modules.length);
  }

  @override
  Widget build(BuildContext context) {
    int _crossAxisCount() {
      int crossAxisCount = querySize<int>(context, {1250: 2, 1400: 3, 1850: 4});
      if (MediaQuery.of(context).size.width < 450) {
        crossAxisCount = 1;
      }
      return crossAxisCount;
    }

    int _rowsPerPage() {
      if (_crossAxisCount() == 1) {
        return 1;
      } else {
        return _crossAxisCount() * 2;
      }
    }

    List<Module> _modules = modules.sublist(
        _offset, math.min(_offset + _rowsPerPage(), modules.length));

    return SJScrollingMoudle(
      moduleType: Module.MODULE_TOKEN_NOW,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Stack(
            children: <Widget>[
              HeadlineHeader(
                brightness: widget.brightness,
                title: '今日推荐',
                subtitle: null,
              ),
              Positioned(
                bottom: 72.0 - 48.0,
                right: 0,
                child: Container(
                  alignment: AlignmentDirectional.centerEnd,
                  child: PaginatedButtons(
                    onPageChanged: (int value) {
                      print('onPageChanged value = $value');
                      onPageChanged(value);
                    },
                    rowsPerPage: _rowsPerPage(),
                    source: _source,
                    initialFirstRowIndex: _offset,
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

class PaginatedButtons extends StatefulWidget {
  /// The index of the first row to display when the widget is first created.
  final int initialFirstRowIndex;

  final ValueChanged<int> onPageChanged;

  /// The number of rows to show on each page.
  ///
  /// See also:
  ///
  ///  * [onRowsPerPageChanged]
  ///  * [defaultRowsPerPage]
  final int rowsPerPage;

  /// The default value for [rowsPerPage].
  ///
  /// Useful when initializing the field that will hold the current
  /// [rowsPerPage], when implemented [onRowsPerPageChanged].
  static const int defaultRowsPerPage = 20;

  PaginatedButtons({
    Key key,
    this.initialFirstRowIndex = 0,
    this.onPageChanged,
    this.rowsPerPage = defaultRowsPerPage,
    this.dragStartBehavior = DragStartBehavior.start,
    @required this.source,
  });

  final PaginatedButtonsSource source;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  @override
  State<StatefulWidget> createState() => PaginatedButtonsState();
}

class PaginatedButtonsState extends State<PaginatedButtons> {
  int _firstRowIndex;
  int _rowCount;
  bool _rowCountApproximate;

  @override
  void initState() {
    super.initState();
    _firstRowIndex = PageStorage.of(context)?.readState(context) as int ??
        widget.initialFirstRowIndex ??
        0;
    //
    _handleDataSourceChanged();
  }

  @override
  void didUpdateWidget(PaginatedButtons oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleDataSourceChanged() {
    setState(() {
      _rowCount = widget.source.rowCount;
      _rowCountApproximate = widget.source.isRowCountApproximate;
//      _selectedRowCount = widget.source.selectedRowCount;
//      _rows.clear();
    });
  }

  /// Ensures that the given row is visible.
  void pageTo(int rowIndex) {
    final int oldFirstRowIndex = _firstRowIndex;
    setState(() {
      final int rowsPerPage = widget.rowsPerPage;
      _firstRowIndex = (rowIndex ~/ rowsPerPage) * rowsPerPage;
    });
    if ((widget.onPageChanged != null) && (oldFirstRowIndex != _firstRowIndex))
      widget.onPageChanged(_firstRowIndex);
  }

  void _handlePrevious() {
    pageTo(math.max(_firstRowIndex - widget.rowsPerPage, 0));
  }

  void _handleNext() {
    pageTo(_firstRowIndex + widget.rowsPerPage);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> footerWidgets = <Widget>[];

    footerWidgets.addAll(<Widget>[
      Opacity(
        opacity: _firstRowIndex <= 0 ? 0.3 : 1.0,
        child: RawMaterialButton(
          constraints: BoxConstraints.tightFor(
            width: 48.0,
            height: 48.0,
          ),
          onPressed: _firstRowIndex <= 0 ? null : _handlePrevious,
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
        opacity: (!_rowCountApproximate &&
                (_firstRowIndex + widget.rowsPerPage >= _rowCount))
            ? 0.3
            : 1.0,
        child: RawMaterialButton(
          constraints: BoxConstraints.tightFor(
            width: 48.0,
            height: 48.0,
          ),
          onPressed: (!_rowCountApproximate &&
                  (_firstRowIndex + widget.rowsPerPage >= _rowCount))
              ? null
              : _handleNext,
          fillColor: Color.fromRGBO(0, 0, 0, 0.1),
          elevation: 0,
          shape: CircleBorder(),
          child: Icon(
            Icons.chevron_right,
            color: Color.fromRGBO(0, 0, 0, 0.54),
          ),
        ),
      ),
    ]);

    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: footerWidgets,
      ),
    );
  }
}

abstract class PaginatedButtonsSource extends ChangeNotifier {
  /// Called to obtain the number of rows to tell the user are available.
  ///
  /// If [isRowCountApproximate] is false, then this must be an accurate number,
  /// and [getRow] must return a non-null value for all indices in the range 0
  /// to one less than the row count.
  ///
  /// If [isRowCountApproximate] is true, then the user will be allowed to
  /// attempt to display rows up to this [rowCount], and the display will
  /// indicate that the count is approximate. The row count should therefore be
  /// greater than the actual number of rows if at all possible.
  ///
  /// If the row count changes, call [notifyListeners].
  int get rowCount;

  /// Called to establish if [rowCount] is a precise number or might be an
  /// over-estimate. If this returns true (i.e. the count is approximate), and
  /// then later the exact number becomes available, then call
  /// [notifyListeners].
  bool get isRowCountApproximate;
}

class MyPaginatedButtonsSource extends PaginatedButtonsSource {
  final int count;

  MyPaginatedButtonsSource({this.count});

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;
}
