import 'package:flutter/material.dart';

class PaginatedHeader extends StatelessWidget {
  final Widget header;

  PaginatedHeader({this.header});

  @override
  Widget build(BuildContext context) {
    int _selectedRowCount = 0;

    double startPadding = 24.0;

    // HEADER
    final List<Widget> headerWidgets = <Widget>[];
    if (_selectedRowCount == 0) {
//      headerWidgets.add(Expanded(child: widget.header));
      headerWidgets.add(Expanded(child: header));
//      if (widget.header is ButtonBar) {
      if (header is ButtonBar) {
        // We adjust the padding when a button bar is present, because the
        // ButtonBar introduces 2 pixels of outside padding, plus 2 pixels
        // around each button on each side, and the button itself will have 8
        // pixels internally on each side, yet we want the left edge of the
        // inside of the button to line up with the 24.0 left inset.
        // TODO(ianh): Better magic. See https://github.com/flutter/flutter/issues/4460
        startPadding = 12.0;
      }
    }

    final ThemeData themeData = Theme.of(context);

    return Card(
      child: Semantics(
        container: true,
        child: DefaultTextStyle(
          // These typographic styles aren't quite the regular ones. We pick the closest ones from the regular
          // list and then tweak them appropriately.
          // See https://material.io/design/components/data-tables.html#tables-within-cards
          style: _selectedRowCount > 0
              ? themeData.textTheme.subhead
                  .copyWith(color: themeData.accentColor)
              : themeData.textTheme.title.copyWith(fontWeight: FontWeight.w400),
          child: IconTheme.merge(
            data: const IconThemeData(opacity: 0.54),
            child: Ink(
              height: 64.0,
              color:
                  _selectedRowCount > 0 ? themeData.secondaryHeaderColor : null,
              child: Padding(
                padding:
                    EdgeInsetsDirectional.only(start: startPadding, end: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: headerWidgets,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
