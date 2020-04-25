import 'package:flutter/material.dart';

import './gt_grid_view.dart';
import './paginated_footer.dart';
import './record_item.dart';
import '../api_service.dart';
import '../forms.dart';
import '../model/page_list.dart';
import '../model/record.dart';
import '../widget_util.dart';

class ArtistComps extends StatefulWidget {
  final int artistId;

  ArtistComps({this.artistId});

  @override
  State<StatefulWidget> createState() {
    return ArtistCompsState();
  }
}

class ArtistCompsState extends State<ArtistComps> {
  PaginatedFormObject form = PaginatedFormObject();
  Future<PageList<Record>> future;

  @override
  void initState() {
    super.initState();

    _handleDataSourceChanged();
  }

  void _handleDataSourceChanged() {
    setState(() {
      future = ApiService.instance.getArtistComps(
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
              return ArtistCompsList(
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

class ArtistCompsList extends StatefulWidget {
  PaginatedFormObject form;
  PageList<Record> pageList;

  final ValueChanged<int> onPageChanged;

  ArtistCompsList({this.form, this.pageList, this.onPageChanged});

  @override
  State<StatefulWidget> createState() {
    return ArtistCompsListState();
  }
}

class ArtistCompsListState extends State<ArtistCompsList> {
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
      return RecordItem(
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
              GTGridView(
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
          );
  }
}
