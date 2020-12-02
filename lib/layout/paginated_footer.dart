import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PaginatedFooter extends StatefulWidget {

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

  PaginatedFooter({
    this.initialFirstRowIndex = 0,
    this.onPageChanged,
    this.rowsPerPage = defaultRowsPerPage,
    this.dragStartBehavior = DragStartBehavior.start,
    @required this.source,
  });

  final PaginatedFooterSource source;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  @override
  State<StatefulWidget> createState() => PaginatedFooterState();
}

class PaginatedFooterState extends State<PaginatedFooter> {

  int _firstRowIndex;
  int _rowCount;
  bool _rowCountApproximate;

  @override
  void initState() {
    super.initState();
    _firstRowIndex = PageStorage.of(context)?.readState(context) as int ?? widget.initialFirstRowIndex ?? 0;
    //
    _handleDataSourceChanged();
  }

  @override
  void didUpdateWidget(PaginatedFooter oldWidget) {
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
    if ((widget.onPageChanged != null) &&
        (oldFirstRowIndex != _firstRowIndex))
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
    final ThemeData themeData = Theme.of(context);
    final TextStyle footerTextStyle = themeData.textTheme.caption;

    final List<Widget> footerWidgets = <Widget>[];

    footerWidgets.addAll(<Widget>[
      Container(width: 32.0),
      Text(
//        localizations.pageRowsInfoTitle(
//          _firstRowIndex + 1,
//          _firstRowIndex + widget.rowsPerPage,
//          _rowCount,
//          _rowCountApproximate,
//        ),
//      'firstRow:${_firstRowIndex + 1}, lastRow:${_firstRowIndex + widget.rowsPerPage}, rowCount:${_rowCount}, rowCountIsApproximate:${_rowCountApproximate}'
      '${_firstRowIndex + 1} - ${math.min(_firstRowIndex + widget.rowsPerPage, _rowCount)} / ${_rowCount}'
      ),
      Container(width: 32.0),
      IconButton(
        icon: const Icon(Icons.chevron_left),
        padding: EdgeInsets.zero,
//        tooltip: localizations.previousPageTooltip,
        onPressed: _firstRowIndex <= 0 ? null : _handlePrevious,
      ),
      Container(width: 24.0),
      IconButton(
        icon: const Icon(Icons.chevron_right),
        padding: EdgeInsets.zero,
//        tooltip: localizations.nextPageTooltip,
        onPressed: (!_rowCountApproximate && (_firstRowIndex + widget.rowsPerPage >= _rowCount)) ? null : _handleNext,
      ),
      Container(width: 14.0),
    ]);

    return Card(
      semanticContainer: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DefaultTextStyle(
            style: footerTextStyle,
            child: IconTheme.merge(
              data: const IconThemeData(opacity: 0.54),
              child: Container(
                height: 56.0,
                child: SingleChildScrollView(
                  dragStartBehavior: widget.dragStartBehavior,
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  child: Row(
                    children: footerWidgets,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

abstract class PaginatedFooterSource extends ChangeNotifier {
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