import 'package:flutter/material.dart';

import './artist_detail.dart';
import './artist_item.dart';
import './gpm-card-grid.dart';
import './paginated_footer.dart';
import '../api_service.dart';
import '../forms.dart';
import '../model/artist.dart';
import '../model/page_list.dart';
import '../util.dart';
import '../widget_util.dart';
import '../home/quick_nav_container.dart';

class ArtistsPage extends StatefulWidget {
  final ValueChanged<int> onSelectionChanged;

  ArtistsPage({this.onSelectionChanged});

  @override
  State<StatefulWidget> createState() {
    return _ArtistsPageState();
  }
}

class _ArtistsPageState extends State<ArtistsPage> {
  ArtistsFormObject form = ArtistsFormObject(recordIsNull: false);
  Future<PageList<Artist>> future;

  @override
  void initState() {
    super.initState();

    _handleDataSourceChanged();
  }

  @override
  void didUpdateWidget(ArtistsPage oldWidget) {
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
      this.future = ApiService.instance.getArtists(
          name: form.name,
          type: form.type,
          recordIsNull: form.recordIsNull,
          offset: form.offset,
          limit: form.limit);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;

    return Container(
      color: Colors.grey[50],
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: FutureBuilder<PageList<Artist>>(
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
                    return ArtistsList(
                      form: form,
                      pageList: snapshot.data,
                      onPageChanged: (int value) {
                        print('onPageChanged value:$value 1');
                        setState(() {
                          form.offset = value;
                        });
                        _handleDataSourceChanged();
                      },
                      onDataSourceChanged: (ArtistsFormObject form) {
                        print('onDataSourceChanged form:$form 1');
                        setState(() {
                          this.form.name = form.name;
                          this.form.type = form.type;
                          this.form.recordIsNull = form.recordIsNull;

                          this.form.offset = 0;
                          this.form.limit = 20;
                        });
                        _handleDataSourceChanged();
                      },
                    );
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
            child: QuickNavContainer(
              brightness: Brightness.light,
              selection: 2,
              onSelectionChanged: (int position) {
                if (widget.onSelectionChanged != null) {
                  widget.onSelectionChanged(position);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ArtistsList extends StatefulWidget {
  final ArtistsFormObject form;
  final PageList<Artist> pageList;

  final ValueChanged<int> onPageChanged;
  final ValueChanged<ArtistsFormObject> onDataSourceChanged;

  ArtistsList(
      {Key key,
      this.form,
      this.pageList,
      this.onPageChanged,
      this.onDataSourceChanged})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ArtistsListState();
  }
}

class ArtistsListState extends State<ArtistsList> {
  PageListPaginatedFooterSource _source;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _source ??= PageListPaginatedFooterSource(pageList: widget.pageList);
  }

  Widget _build(BuildContext context, List<Artist> artists) {
    int _crossAxisCount() {
      Orientation orientation = MediaQuery.of(context).orientation;
      return orientation == Orientation.portrait ? 2 : 4;
    }

    Widget _itemBuilder(BuildContext context, int index) {
      Artist artist = artists[index];
      return ArtistItem(
        url: getArtistImage(artist),
        title: artist.name,
        tag: artist.getTypeText() ?? '-',
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArtistDetailPage(
                  artist: artist,
                ),
              ));
        },
      );
    }

    var _margin = EdgeInsets.fromLTRB(96, 32, 96, 32);
    if (MediaQuery.of(context).size.width < 950) {
      _margin = EdgeInsets_fromLTRB(context, 950, 96, 32, 96, 32);
    }
    if (MediaQuery.of(context).size.width < 450) {
      _margin = EdgeInsets.fromLTRB(16, 16, 16, 16);
    }

    return Container(
      child: SingleChildScrollView(
        child: Container(
          margin: _margin,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Card(
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        showDialogSearch(
                            context, widget.form, widget.onDataSourceChanged);
                      },
                    ),
                  ],
                ),
              ),
              GPMCardGrid(
                crossAxisCount: _crossAxisCount(),
                children: artists
                    .map((artist) =>
                        _itemBuilder(context, artists.indexOf(artist)))
                    .toList(),
              ),
              PaginatedFooter(
                onPageChanged: (int value) {
                  print('onPageChanged value = $value');
                  print(
                      'onPageChanged widget.onPageChanged = ${widget.onPageChanged}');
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
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Artist> artists = widget.pageList.results;

    return Container(
      child: _build(context, artists),
    );
  }
}

enum DialogDemoAction {
  cancel,
  discard,
  disagree,
  agree,
}

void showDialogSearch(BuildContext context, ArtistsFormObject form,
    ValueChanged<ArtistsFormObject> onFormChanged) {
  List<MapEntry<int, String>> types = <MapEntry<int, String>>[
    MapEntry(null, '全部'),
    MapEntry(1, Artist.getTypeTextStatic(1)),
    MapEntry(0, Artist.getTypeTextStatic(0)),
    MapEntry(2, Artist.getTypeTextStatic(2)),
  ];

  ArtistsFormObject _form = ArtistsFormObject(
    name: form.name,
    type: form.type,
    recordIsNull: form.recordIsNull,
  );

  TextEditingController _nameTextEditingController = TextEditingController();
  _nameTextEditingController.text = _form.name;

  showDialog<DialogDemoAction>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: const Text('歌手'),
            content: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    controller: _nameTextEditingController,
                    keyboardType: TextInputType.text,
                    decoration:
                        InputDecoration(filled: true, labelText: '歌手名称'),
                    maxLines: 1,
                    //initialValue: _form.name,
                  ),
                  InputDecorator(
                    decoration: const InputDecoration(
                      labelText: '歌手类型',
                      hintText: '选择歌手类型',
                      contentPadding: EdgeInsets.zero,
                    ),
                    child: DropdownButton<int>(
                      underline: Container(),
                      value: _form.type,
                      onChanged: (int value) {
                        print('onChanged value = $value');

                        setState(() {
                          _form.type = value;
                        });
                      },
                      items: types.map((MapEntry<int, String> e) {
                        return DropdownMenuItem(
                          value: e.key,
                          child: Text(e.value),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    child: CheckboxListTile(
                      title: Text('有唱片'),
                      value: _form.recordIsNull == false,
                      onChanged: (value) {
                        setState(() {
                          _form.recordIsNull = !value;
                        });
                      },
                    ),
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
                  print(
                      "_nameTextEditingController.text = ${_nameTextEditingController.text}");
                  _form.name = _nameTextEditingController.text;
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
