import 'package:flutter/material.dart';

import '../layout/paginated_footer.dart';
import '../api_service.dart';
import '../forms.dart';
import '../model/page_list.dart';
import '../model/song.dart';
import '../util.dart';
import '../widget_util.dart';
import '../layout/empty.dart';

class ArtistSongs extends StatefulWidget {
  final int artistId;

  ArtistSongs({this.artistId});

  @override
  State<StatefulWidget> createState() {
    return ArtistSongsState();
  }
}

class ArtistSongsState extends State<ArtistSongs> {
  PaginatedFormObject form = PaginatedFormObject();
  Future<PageList<Song>> future;

  @override
  void initState() {
    super.initState();

    _handleDataSourceChanged();
  }

  void _handleDataSourceChanged() {
    setState(() {
      print('futere: $future');
      future = ApiService.instance.getArtistSongs(
          artistId: widget.artistId, offset: form.offset, limit: form.limit);
      print('futere: $future');
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
                error: snapshot.error,
              );
            }
            if (snapshot.hasData) {
              return ArtistSongsList(
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

class ArtistSongsList extends StatefulWidget {
  PaginatedFormObject form;
  PageList<Song> pageList;
  final ValueChanged<int> onPageChanged;

  ArtistSongsList({this.form, this.pageList, this.onPageChanged});

  @override
  State<StatefulWidget> createState() {
    return ArtistSongsListState();
  }
}

class ArtistSongsListState extends State<ArtistSongsList> {
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
    List<Song> songs = widget.pageList.results;

    Widget _buildList(BuildContext context) {
      Widget _dataTable = DataTable(
        columns: <DataColumn>[
          DataColumn(label: Text(""), numeric: false),
          DataColumn(label: Text("音乐标题")),
          DataColumn(label: Text("歌手")),
          DataColumn(label: Text("唱片")),
          DataColumn(label: Icon(Icons.more_horiz)),
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
              DataCell(
                getArtistsWidget(song.artists),
                onTap: () {
                  onTapArtists(context, song.artists);
                },
              ),
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

      if (isLargeScreen(context)) {
        return Card(
          semanticContainer: false,
          child: _dataTable,
        );
      } else {
        return Card(
          semanticContainer: false,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: _dataTable,
          ),
        );
      }
    }

    return (songs?.length ?? 0) == 0
        ? EmptyWidget()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildList(context),
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


