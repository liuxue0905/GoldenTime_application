import 'package:flutter/material.dart';

import '../api_service.dart';
import '../forms.dart';
import '../layout/paginated_footer.dart';
import '../model/page_list.dart';
import '../model/song.dart';
import '../util.dart';
import '../widget_util.dart';

class SongsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SongsPageState();
  }
}

class SongsPageState extends State<SongsPage> {
  SongsFormObject form = SongsFormObject();
  Future<PageList<Song>> future;

  @override
  void initState() {
    super.initState();

    _handleDataSourceChanged();
  }

  @override
  void didUpdateWidget(SongsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget != widget) {
      _handleDataSourceChanged();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleDataSourceChanged() {
    setState(() {
      this.future = ApiService.instance
          .getSongs(title: form.title, offset: form.offset, limit: form.limit);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      child: FutureBuilder<PageList<Song>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return WaitingWidget();
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return FutureErrorWidget(
                  onPressed: () {
                    _handleDataSourceChanged();
                  },
                  error: snapshot.error);
            }
            if (snapshot.hasData) {
              return SongsList(
                  form: form,
                  pageList: snapshot.data,
                  onPageChanged: (int value) {
                    print('onPageChanged value: $value');
                    setState(() {
                      form.offset = value;
                    });
                    _handleDataSourceChanged();
                  },
                  onDataSourceChanged: (SongsFormObject form) {
                    setState(() {
                      this.form.title = form.title;

                      this.form.offset = 0;
                      this.form.limit = 20;
                    });
                    _handleDataSourceChanged();
                  }
              );
            }
          } else {
            return Center(child: Text(snapshot.connectionState.toString()));
          }

          return null;
        },
      ),
    );
  }
}

class SongsList extends StatefulWidget {

  final PaginatedFormObject form;
  final PageList<Song> pageList;

  final ValueChanged<int> onPageChanged;
  final ValueChanged<SongsFormObject> onDataSourceChanged;

  SongsList({this.form, this.pageList, this.onPageChanged, this.onDataSourceChanged});

  @override
  State<StatefulWidget> createState() {
    return SongsListState();
  }

}

class SongsListState extends State<SongsList> {

  PageListPaginatedFooterSource _source;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _source ??= PageListPaginatedFooterSource(pageList: widget.pageList);
  }

  @override
  Widget build(BuildContext context) {

    List<Song> songs = widget.pageList.results;

    return Container(
      color: Colors.grey[100],
      child: Container(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets_fromLTRB(context, 'xs', 72, 32, 16, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                PaginatedHeader(),
                Card(
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          showDialogSearch(context, widget.form, widget.onDataSourceChanged);
                        },
                      ),
                    ],
                  ),
                ),
                buildDataTable(context, songs),
                PaginatedFooter(
                  onPageChanged: (int value) {
                    print('onPageChanged value = $value');
                    print('onPageChanged widget.onPageChanged = ${widget.onPageChanged}');
                    if (widget.onPageChanged != null) {
                      widget.onPageChanged(value);
                    }
                  },
                  rowsPerPage: 20,
                  source: _source,
                  initialFirstRowIndex: widget.form.offset,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDataTable(BuildContext context, List<Song> songs) {
    double _columnSpacing = 56.0;

    String deviceType = getDeviceType(context);
    if (deviceType != 'xs') {
      _columnSpacing = 16;
    }

    Widget dataTable = DataTable(
      columnSpacing: _columnSpacing,
      columns: <DataColumn>[
        DataColumn(label: Text(""), numeric: false),
        DataColumn(label: Text("音乐标题")),
        DataColumn(label: Text("歌手")),
        DataColumn(label: Text("唱片")),
        DataColumn(
          label: Icon(Icons.more_horiz),
          numeric: false,
          tooltip: null,
        ),
      ],
      rows: songs.map((Song song) {
        return DataRow(
          cells: <DataCell>[
            DataCell(Text((songs.indexOf(song) + 1).toString())),
            DataCell(
              Text(song.title),
              onTap: () {
                openSong(context, song);
              },
            ),
            DataCell(getArtistsWidget(song.artists), onTap: () {
              onTapArtists(context, song.artists);
            }),
            DataCell(
              Text(song.record.title),
              onTap: () {
                openRecord(context, song.record);
              },
            ),
            DataCell(
              Icon(Icons.info),
              onTap: () {
                openSong(context, song);
              },
            ),
          ],
        );
      }).toList(),
    );

    Widget card = Card(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
//                      dragStartBehavior: widget.dragStartBehavior,
        child: dataTable,
      ),
    );

    if (deviceType != 'xs') {
      card = Card(
        child: dataTable,
      );
    }

    return card;
  }
}

class PaginatedHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var header = Text('TITLE');
//    var header = null;

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

enum DialogDemoAction {
  cancel,
  discard,
  disagree,
  agree,
}

void showDialogSearch(BuildContext context, SongsFormObject form, ValueChanged<SongsFormObject> onFormChanged) {
  SongsFormObject _form = SongsFormObject(
    title: form.title,
  );

  TextEditingController _titleTextEditingController = TextEditingController();
  _titleTextEditingController.text = _form.title;

  showDialog<DialogDemoAction>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: const Text('歌曲'),
            content: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    controller: _titleTextEditingController,
                    keyboardType: TextInputType.text,
                    decoration:
                        InputDecoration(filled: true, labelText: '歌曲标题'),
                    maxLines: 1,
                    // initialValue: _form.title,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: const Text('取消'),
                onPressed: () {
                  Navigator.pop(context, DialogDemoAction.disagree);
                },
              ),
              FlatButton(
                child: const Text('确定'),
                onPressed: () {
                  _form.title = _titleTextEditingController.text;
                  Navigator.pop(context, DialogDemoAction.agree);
                },
              ),
            ],
          );
        },
      );
    },
  ).then<void>((DialogDemoAction value) {
    // The value passed to Navigator.pop() or null.
    if (value != null) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('You selected: $value'),
      ));

      if (value == DialogDemoAction.agree) {
        if (onFormChanged != null) {
          onFormChanged(_form);
        }
      }
    }
  });
}
