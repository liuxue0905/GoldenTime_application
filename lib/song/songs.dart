import 'package:flutter/material.dart';

import '../api_service.dart';
import '../constants.dart';
import '../forms.dart';
import '../home/quick_nav_container.dart';
import '../layout/headers.dart';
import '../layout/paginated_footer.dart';
import '../model/page_list.dart';
import '../model/song.dart';
import '../models.dart';
import '../util.dart';
import '../widget_util.dart';

class SongsPage extends StatefulWidget {
  static const String route = '/song';
  static const String routeName = 'song-list';

  final List<GPMQuickNavItem> gpmQuickNavItems;
  final ValueChanged<String> onRouteNameChanged;

  const SongsPage({
    Key key,
    this.gpmQuickNavItems = kGPMQuickNavItems,
    this.onRouteNameChanged,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SongsPageState();
  }
}

class SongsPageState extends State<SongsPage> {
  SongsFormObject form = SongsFormObject();
  // SongsFormObject form = SongsFormObject(limit: 50);
  Future<PageList<Song>> future;

  @override
  void initState() {
    super.initState();

    _handleDataSourceChanged();
  }

  @override
  void didUpdateWidget(SongsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
//    if (oldWidget != widget) {
//      _handleDataSourceChanged();
//    }
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
      child: Stack(
        children: <Widget>[
          Positioned.fill(
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
                          });
                          _handleDataSourceChanged();
                        });
                  }
                } else {
                  return Center(
                      child: Text(snapshot.connectionState.toString()));
                }

                return null;
              },
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            child: Visibility(
              visible: isLargeScreen(context),
              child: QuickNavContainer(
                brightness: Brightness.light,
                items: widget.gpmQuickNavItems,
                selection: 3,
                onSelectionChanged: (int position) {
                  if (widget.onRouteNameChanged != null) {
                    widget.onRouteNameChanged(
                        widget.gpmQuickNavItems[position].routeName);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SongsList extends StatefulWidget {
  final SongsFormObject form;
  final PageList<Song> pageList;

  final ValueChanged<int> onPageChanged;
  final ValueChanged<SongsFormObject> onDataSourceChanged;

  SongsList(
      {this.form, this.pageList, this.onPageChanged, this.onDataSourceChanged});

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

    String _getSubtitle() {
      String text = '搜索条件    ';

      if (widget.form.title?.isEmpty ?? true) {
        text += '标题：全部';
      } else {
        text += '标题：${widget.form.title}';
      }

      return text;
    }

    return Container(
      child: SingleChildScrollView(
        child: Container(
          margin: getListContainerMargin(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              PlayHeader(
                title: '歌曲',
                subtitle: _getSubtitle(),
                buttonText: '搜索',
                onPressed: () {
                  showDialogSearch(
                      context, widget.form, widget.onDataSourceChanged);
                },
              ),
              buildDataTable(context, songs),
              PaginatedFooter(
                onPageChanged: (int value) {
                  print('onPageChanged value = $value');
                  if (widget.onPageChanged != null) {
                    widget.onPageChanged(value);
                  }
                },
                rowsPerPage: widget.form.limit,
                source: _source,
                initialFirstRowIndex: widget.form.offset,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDataTable(BuildContext context, List<Song> songs) {
    // Widget dataTable = Table(
    //   border: TableBorder.all(color: Colors.transparent),
    //   columnWidths: {
    //     0: FixedColumnWidth(36.0),
    //     1: FlexColumnWidth(3),
    //     2: FlexColumnWidth(1),
    //     3: FlexColumnWidth(1),
    //     4: FixedColumnWidth(36.0),
    //   },
    //   // defaultColumnWidth: IntrinsicColumnWidth(),
    //   children: songs.map((Song song) {
    //     return TableRow(children: <TableCell>[
    //       TableCell(
    //         child: InkWell(
    //           child: Text((songs.indexOf(song) + 1).toString()),
    //           onTap: () {},
    //         ),
    //       ),
    //       TableCell(
    //         child: InkWell(
    //           child: Text(song.title),
    //           onTap: () {
    //             openSong(context, song);
    //           },
    //         ),
    //       ),
    //       TableCell(child: getArtistsWidget(song.artists)),
    //       TableCell(
    //         child: Text(song.record.title),
    //       ),
    //       TableCell(
    //         child: Center(
    //           child: Icon(Icons.info),
    //         ),
    //       ),
    //     ]);
    //   }).toList(),
    // );

    Widget dataTable = DataTable(
      columnSpacing: isLargeScreen(context) ? 16 : 56,
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
            DataCell(
              SizedBox(
                child: Text((songs.indexOf(song) + 1).toString()),
                width: 36.0,
              ),
            ),
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

    if (isLargeScreen(context)) {
      card = Card(
        child: dataTable,
      );
    }

    return card;
  }
}

enum DialogDemoAction {
  cancel,
  discard,
  disagree,
  agree,
}

void showDialogSearch(BuildContext context, SongsFormObject form,
    ValueChanged<SongsFormObject> onFormChanged) {
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
//      Scaffold.of(context).showSnackBar(SnackBar(
//        content: Text('You selected: $value'),
//      ));

      if (value == DialogDemoAction.agree) {
        if (onFormChanged != null) {
          onFormChanged(_form);
        }
      }
    }
  });
}
