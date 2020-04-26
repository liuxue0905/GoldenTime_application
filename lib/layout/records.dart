import 'package:flutter/material.dart';

import './gpm-card-grid.dart';
import './record_item_tall.dart';
import '../api_service.dart';
import '../forms.dart';
import '../layout/paginated_footer.dart';
import '../model/page_list.dart';
import '../model/record.dart';
import '../util.dart';
import '../widget_util.dart';

class RecordsPage extends StatefulWidget {
  RecordsPage();

  factory RecordsPage.forDesignTime() {
    return new RecordsPage();
  }

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
    print('Device Type: ${getDeviceType(context)}');
    print('Is Large Screen: ${isLargeScreen(context)}');

    Orientation orientation = MediaQuery.of(context).orientation;
    String deviceType = getDeviceType(context);
    bool largeScreen = isLargeScreen(context);

    return Container(
      child: Container(
        color: Colors.grey[50],
        child: FutureBuilder<PageList<Record>>(
          future: future,
          builder: (context, snapshot) {
            print('snapshot.connectionState = ${snapshot.connectionState}');
            print('snapshot.hasData = ${snapshot.hasData.toString()}');
            print('snapshot.hasError = ${snapshot.hasError.toString()}');
            print('snapshot.error = ${snapshot.error.toString()}');

//            PaginatedDataTable();

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
                      this.form.limit = 20;
                    });
                    _handleDataSourceChanged();
                  },
                );
              }
            } else {
              return Center(child: Text(snapshot.connectionState.toString()));
            }

            return null;
          },
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

      return RecordItemTall(
        brightness: Brightness.light,
        url: getRecordImage(record),
        title: record.title,
        subtitle: getArtistsString(record.artists),
        description: record.year + ' • ' + record.songs.length.toString() + "首",
        tag: record.getFormatText(),
        onTap: () {
          openRecord(context, record);
        },
      );
    }

    int _crossAxisCount() {
      Orientation orientation = MediaQuery.of(context).orientation;
      return orientation == Orientation.portrait ? 2 : 4;
    }

//    PaginatedDataTable();

    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets_fromLTRB(context, 'xs', 72, 32, 16, 32),
          child: Column(
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
