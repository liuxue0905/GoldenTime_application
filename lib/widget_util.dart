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
              CircleAvatar(
                backgroundImage:
                    AssetImage('images/illo_default_artistradio_smallcard.png'),
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(
                  getArtistImage(artist),
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

String getRecordImage(Record record) {
  List<String> urls = [
    "http://p1.music.126.net/x1ftKvF4KL_Jfn-Ti7f9eA==/18351948579947747.jpg?param=120y120",
    "https://p1.music.126.net/_aDUl2D0Z8YACL2fLZOvXg==/569547023195052.jpg?param=177y177",
    "https://www.baidu.com/img/bd_logo1.png?where=super",
    "https://p2.music.126.net/3VCqOJSYLEAiCtodKgxrXg==/2528876744253082.jpg?param=946y946",
  ];

  var random = new Random();

  return urls[random.nextInt(urls.length)];
}

String getArtistImage(Artist artist) {
  List<String> urls = [
    "http://p1.music.126.net/x1ftKvF4KL_Jfn-Ti7f9eA==/18351948579947747.jpg?param=120y120",
    "https://p1.music.126.net/_aDUl2D0Z8YACL2fLZOvXg==/569547023195052.jpg?param=177y177",
    "https://www.baidu.com/img/bd_logo1.png?where=super",
    "https://p2.music.126.net/3VCqOJSYLEAiCtodKgxrXg==/2528876744253082.jpg?param=946y946",
  ];

  var random = new Random();

  return urls[random.nextInt(urls.length)];
}
