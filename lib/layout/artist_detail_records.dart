import 'package:flutter/material.dart';
import '../home/sj_card_recommended.dart';
import './gpm-card-grid.dart';
import '../api_service.dart';
import '../forms.dart';
import '../layout/paginated_footer.dart';
import '../model/page_list.dart';
import '../model/record.dart';
import '../widget_util.dart';

class ArtistRecords extends StatefulWidget {
  final int artistId;

  ArtistRecords({this.artistId});

  @override
  State<StatefulWidget> createState() {
    return ArtistRecordsState();
  }
}

class ArtistRecordsState extends State<ArtistRecords> {
  PaginatedFormObject form = PaginatedFormObject();
  Future<PageList<Record>> future;

  @override
  void initState() {
    super.initState();

    _handleDataSourceChanged();
  }

  void _handleDataSourceChanged() {
    setState(() {
      future = ApiService.instance.getArtistRecords(
          artistId: widget.artistId, offset: form.offset, limit: form.limit);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
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
              return ArtistRecordsList(
                form: form,
                pageList: snapshot.data,
                onPageChanged: (int value) {
                  print('onPageChanged value: $value');
                  setState(() {
                    form.offset = value;
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
    );
  }
}

class ArtistRecordsList extends StatefulWidget {
  PaginatedFormObject form;
  PageList<Record> pageList;

  final ValueChanged<int> onPageChanged;

  ArtistRecordsList({this.form, this.pageList, this.onPageChanged});

  @override
  State<StatefulWidget> createState() {
    return ArtistRecordsListState();
  }
}

class ArtistRecordsListState extends State<ArtistRecordsList> {
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

    int _crossAxisCount() {
      Orientation orientation = MediaQuery.of(context).orientation;
      return orientation == Orientation.portrait ? 2 : 4;
    }

    Widget _itemBuilder(BuildContext context, int index) {
      Record record = records[index];
      return SJCardRecommended(
        brightness: Brightness.light,
        url: getRecordImage(record),
        title: record.title,
        subtitle: record.number,
        tag: record.getFormatText(),
        onTap: () {
          openRecord(context, record);
        },
      );
    }

    return records == null
        ? Center(
            child: Text('no records'),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
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
          );
  }
}
