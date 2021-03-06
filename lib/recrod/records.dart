import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

import '../api_service.dart';
import '../constants.dart';
import '../forms.dart';
import '../home/quick_nav_container.dart';
import '../home/sj_card_recommended_tall.dart';
import '../layout/headers.dart';
import '../model/page_list.dart';
import '../model/record.dart';
import '../models.dart';
import '../util.dart';
import '../widget_util.dart';
import '../layout/gpm-card-grid.dart';
import '../layout/paginated_footer.dart';

class RecordsPage extends StatefulWidget {
  static const String route = '/record';
  static const String routeName = 'record-list';

  final List<GPMQuickNavItem> gpmQuickNavItems;
  final ValueChanged<String> onRouteNameChanged;

  const RecordsPage({
    Key key,
    this.gpmQuickNavItems = kGPMQuickNavItems,
    this.onRouteNameChanged,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RecordsPageState();
  }
}

class _RecordsPageState extends State<RecordsPage> {
  RecordsFormObject form = RecordsFormObject();

  Future<PageList<Record>> future;

  @override
  void initState() {
    super.initState();

    _handleDataSourceChanged();
  }

  @override
  void didUpdateWidget(RecordsPage oldWidget) {
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
      this.future = ApiService.instance.getRecords(
          title: form.title,
          format: form.format,
          year: form.year,
          companyId: form.companyId,
          offset: form.offset,
          limit: form.limit);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        color: Colors.grey[50],
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: FutureBuilder<PageList<Record>>(
                future: future,
                builder: (context, snapshot) {
                  if (kDebugMode) {
                    print(
                        'snapshot.connectionState = ${snapshot.connectionState}');
                    print('snapshot.hasData = ${snapshot.hasData.toString()}');
                    print(
                        'snapshot.hasError = ${snapshot.hasError.toString()}');
                    print('snapshot.error = ${snapshot.error.toString()}');
                  }

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
                      return RecordsList(
                        form: form,
                        pageList: snapshot.data,
                        onPageChanged: (int value) {
                          print('onPageChanged value: $value');
                          setState(() {
                            form.offset = value;
                          });
                          _handleDataSourceChanged();
                        },
                        onDataSourceChanged: (RecordsFormObject form) {
                          setState(() {
                            this.form.title = form.title;
                            this.form.format = form.format;

                            this.form.offset = 0;
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
              child: Visibility(
                visible: isLargeScreen(context),
                child: QuickNavContainer(
                  brightness: Brightness.light,
                  items: widget.gpmQuickNavItems,
                  selection: 1,
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
      ),
    );
  }
}

class RecordsList extends StatefulWidget {
  final RecordsFormObject form;
  final PageList<Record> pageList;

  final ValueChanged<int> onPageChanged;
  final ValueChanged<RecordsFormObject> onDataSourceChanged;

  RecordsList(
      {this.form, this.pageList, this.onPageChanged, this.onDataSourceChanged});

  @override
  State<StatefulWidget> createState() {
    return _RecordsListState();
  }
}

//class RecordSearchAlertDialog extends StatefulWidget {
//
//
//  @override
//  State<StatefulWidget> createState() {
//    return _RecordSearchAlertDialogState();
//  }
//}
//
//class _RecordSearchAlertDialogState extends State<RecordSearchAlertDialog> {
//  @override
//  Widget build(BuildContext context) {
//    return ;
//  }
//}

class _RecordsListState extends State<RecordsList> {
  PageListPaginatedFooterSource _source;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _source ??= PageListPaginatedFooterSource(pageList: widget.pageList);
  }

  @override
  Widget build(BuildContext context) {
    List<Record> records = widget.pageList.results;

    Widget _itemBuilder(BuildContext context, int index) {
      Record record = records[index];

      // subtitle
      // 'New Release Radio New Release Radio New Release Radio New Release Radio'
      // description
      // 'A personalized mix of newly released songs. Updated daily. A personalized mix of newly released songs. Updated daily.'

      return SJCardRecommendedTall(
        brightness: Brightness.light,
        url: getRecordCover(record,
            size: 160 * MediaQuery.of(context).devicePixelRatio),
        title: record.title,
        subtitle: getArtistsString(record.artists),
        description: record.year + ' • ' + record.songs.length.toString() + "首",
        tag: record.getFormatText() ?? '-',
        onTap: () {
          openRecord(context, record);
        },
      );
    }

    int _crossAxisCount() {
      int crossAxisCount = querySize<int>(context,
          {1071: 4, 1072: 5, 1303: 5, 1304: 6, 1535: 6, 1536: 7, 1768: 8});
      if (!isLargeScreen(context)) {
        crossAxisCount = 2;
      }
      return crossAxisCount;
    }

    String _getSubtitle() {
      String text = '搜索条件    ';

      if (widget.form.title?.isEmpty ?? true) {
        text += '标题：全部';
      } else {
        text += '标题：${widget.form.title}';
      }

      text += '，';

      text += '介质：${Record.getFormatTextStatic(widget.form.format) ?? '全部'}';

      return text;
    }

    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Container(
            margin: getListContainerMargin(context),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                PlayHeader(
                  title: '唱片',
                  subtitle: _getSubtitle(),
                  buttonText: '搜索',
                  onPressed: () {
                    showDialogSearch(
                        context, widget.form, widget.onDataSourceChanged);
                  },
                ),
                GPMCardGrid(
                  crossAxisCount: _crossAxisCount(),
                  mainAxisSpacing: isLargeScreen(context) ? 24 : 12,
                  crossAxisSpacing: isLargeScreen(context) ? 16 : 8,
                  children: records
                      .map((record) =>
                          _itemBuilder(context, records.indexOf(record)))
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
                  rowsPerPage: widget.form.limit,
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
}

enum DialogDemoAction {
  cancel,
  discard,
  disagree,
  agree,
}

void showDialogSearch(BuildContext context, RecordsFormObject form,
    ValueChanged<RecordsFormObject> onFormChanged) {
  List<MapEntry<int, String>> formats = <MapEntry<int, String>>[
    MapEntry(null, '全部'),
    MapEntry(1, Record.getFormatTextStatic(1)),
    MapEntry(2, Record.getFormatTextStatic(2)),
    MapEntry(3, Record.getFormatTextStatic(3)),
    MapEntry(4, Record.getFormatTextStatic(4)),
  ];

  RecordsFormObject _form = RecordsFormObject(
    title: form.title,
    format: form.format,
    year: form.year,
    companyId: form.companyId,
  );

  TextEditingController _titleTextEditingController = TextEditingController();
  _titleTextEditingController.text = _form.title;

  showDialog<DialogDemoAction>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: const Text('唱片'),
            content: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    controller: _titleTextEditingController,
                    keyboardType: TextInputType.text,
                    decoration:
                        InputDecoration(filled: true, labelText: '唱片标题'),
                    maxLines: 1,
                    // initialValue: _form.title,
                  ),
                  InputDecorator(
                    decoration: const InputDecoration(
                      labelText: '唱片介质',
                      hintText: '选择唱片介质',
                      contentPadding: EdgeInsets.zero,
                    ),
                    child: DropdownButton<int>(
                      underline: Container(),
                      value: _form.format,
                      onChanged: (int value) {
                        print('onChanged value = $value');

                        setState(() {
                          _form.format = value;
                        });
                      },
                      items: formats.map((MapEntry<int, String> e) {
                        return DropdownMenuItem(
                          value: e.key,
                          child: Text(e.value),
                        );
                      }).toList(),
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
