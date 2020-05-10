import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import './layout/artist_detail.dart';
import './layout/paginated_footer.dart';
import './layout/record_detail.dart';
import './layout/song_detial.dart';
import './model/artist.dart';
import './model/page_list.dart';
import './model/record.dart';
import './model/song.dart';

void openRecord(BuildContext context, Record record) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => RecordDetailPage(
                record: record,
              )));
}

void openArtist(BuildContext context, Artist artist) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ArtistDetailPage(
                artist: artist,
              )));
}

void openSong(BuildContext context, Song song) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SongDetailPage(
                song: song,
              )));
}

Widget getArtistsWidget(List<Artist> artists) {
  return Text(getArtistsString(artists));
}

String getArtistsString(List<Artist> artists) {
//  print("artists=$artists");
  String text = "";
  if (artists != null && artists.length != 0) {
    artists.forEach((Artist artist) {
      text += artist.name;
      text += '/';
    });
    text = text.substring(0, text.length - 1);
  }
  return text;
}

onTapArtists(BuildContext context, List<Artist> artists) {
  if (artists == null || artists.length == 0) {
    return;
  }
  if (artists.length == 1) {
    Artist artist = artists[0];
    openArtist(context, artist);
    return;
  }
  showDialogArtists(context, artists);
}

void showDemoDialog<T>({BuildContext context, Widget child}) {
  showDialog<T>(
    context: context,
    builder: (BuildContext context) => child,
  ).then<void>((T value) {
    // The value passed to Navigator.pop() or null.
    if (value != null) {
//      Scaffold.of(context).showSnackBar(SnackBar(
//        content: Text('You selected: $value'),
//      ));
      openArtist(context, value as Artist);
    }
  });
}

void showDialogArtists(BuildContext context, List<Artist> artists) {
  final ThemeData theme = Theme.of(context);

  showDemoDialog<Artist>(
    context: context,
    child: SimpleDialog(
      title: const Text('歌手'),
      children: artists.map((Artist artist) {
        return ListTile(
          isThreeLine: false,
          title: Text(artist.name),

//          leading: Container(
//            width: 40,
//            height: 40,
//            decoration: BoxDecoration(
//              color: Colors.white,
//              shape: BoxShape.circle,
//              image: DecorationImage(
//                  image: AssetImage('images/illo_default_artistradio_smallcard.png')),
//            ),
//            child: CircleAvatar(
//              backgroundColor: Colors.transparent,
//              backgroundImage: NetworkImage(
//                getArtistImage(artist),
//              ),
//            ),
//          ),

          leading: Stack(
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  shape: BoxShape.circle,
                ),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Icon(
                      Icons.account_circle,
                      color: Colors.grey,
                      size: constraints.biggest.width,
                    );
                  },
                ),
              ),
              CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(
                  getArtistCover(artist,
                      size: 40 * MediaQuery.of(context).devicePixelRatio),
                ),
              ),
            ],
          ),

          onTap: () {
            Navigator.pop(context, artist);
          },
        );
      }).toList(),
    ),
  );
}

class PageListPaginatedFooterSource<T> extends PaginatedFooterSource {
  final PageList<T> pageList;

  PageListPaginatedFooterSource({this.pageList});

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => pageList.count;
}

class WaitingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}

class FutureErrorWidget extends StatelessWidget {
  final Object error;

  /// The callback that is called when the button is tapped or otherwise activated.
  ///
  /// If this callback and [onLongPress] are null, then the button will be disabled.
  ///
  /// See also:
  ///
  ///  * [enabled], which is true if the button is enabled.
  final VoidCallback onPressed;

  FutureErrorWidget({Key key, @required VoidCallback onPressed, this.error})
      : onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    String text = '未知错误';

    if (error is SocketException) {
      SocketException e = error;
      OSError osError = e.osError;

      print('osError = ${osError}');

      text = '网络异常';
    } else if (error is IOException) {
      IOException e = error;

      text = e.toString();
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(text),
          RaisedButton(
            onPressed: onPressed,
            child: Text('重试'),
          ),
        ],
      ),
    );
  }
}

String getArtistCover(Artist artist, {double size, String def = ''}) {
  return getImageUrl(artist.cover, resize: 'fill', size: size?.toInt()) ?? def;
}

String getRecordCover(Record record, {double size, String def = ''}) {
  return getImageUrl(record.cover, resize: 'fill', size: size?.toInt()) ?? def;
}

String getImageUrl(String url, {int size, String resize}) {
//  print('_getImageUrl() url=${url}');
  try {
    Uri uri = Uri.parse(url);
//    print('_getImageUrl() uri=${uri}');

    Map<String, String> queryParameters = Map.from(uri.queryParameters);
//    print('_getImageUrl() queryParameters=${queryParameters}');
    if (size != null) {
      queryParameters['size'] = size.toString();
    }
    if (resize != null) {
      queryParameters['resize'] = resize;
    }

    uri = uri.replace(queryParameters: queryParameters);
//    print('_getImageUrl() uri1=${uri}');
    return uri.toString();
  } catch (e) {
//    print(e);
  }
  return null;
}

List<Map<String, dynamic>> getRecordFields(Record record) {
  List<Map<String, dynamic>> fields = [];

  fields.add({
    'key': 'releaseDetail',
    'value': record.releaseDetail,
    'name': '发布时间',
  });

  fields.add({
    'key': 'producer',
    'value': record.producer,
    'name': '监制',
  });

  fields.add({
    'key': 'recorder',
    'value': record.recorder,
    'name': '录音',
  });

  fields.add({
    'key': 'mixer',
    'value': record.mixer,
    'name': '混音',
  });

  fields.add({
    'key': 'bandsman',
    'value': record.bandsman,
    'name': '乐手',
  });

  fields.add({
    'key': 'description',
    'value': record.description,
    'name': '说明',
  });

  return fields;
}

List<Map<String, dynamic>> getSongFields(Song song) {
  List<Map<String, dynamic>> fields = [];

//  song.lyricist = 'AB作DsdfABDsd';
//  song.composer = 'ABDsdfs';
//  song.arranger = 'EG作SGSDGDS';

  fields.add({
    'key': 'lyricist',
    'value': song.lyricist,
    'name': '作词',
  });

  fields.add({
    'key': 'composer',
    'value': song.composer,
    'name': '作曲',
  });

  fields.add({
    'key': 'arranger',
    'value': song.arranger,
    'name': '编曲',
  });

  fields.add({
    'key': 'vocalist',
    'value': song.vocalist,
    'name': '和音',
  });

  fields.add({
    'key': 'producer',
    'value': song.producer,
    'name': '监制',
  });

  fields.add({
    'key': 'bandsman',
    'value': song.bandsman,
    'name': '乐手',
  });

  fields.add({
    'key': 'description',
    'value': song.description,
    'name': '说明',
  });

  return fields;
}

class DefaultIconWidget extends StatelessWidget {
  final IconData icon;

  DefaultIconWidget({this.icon = Icons.account_circle});

  @override
  Widget build(BuildContext context) {
    return Container(
//      color: Colors.grey[400],
      child: FractionallySizedBox(
        widthFactor: 0.8,
        heightFactor: 0.8,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Icon(
              icon,
              color: Colors.grey,
              size: constraints.biggest.width,
            );
          },
        ),
      ),
    );
  }
}
