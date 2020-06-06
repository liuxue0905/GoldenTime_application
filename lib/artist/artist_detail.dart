import 'package:flutter/material.dart';
import 'package:flutter_app_golden_time/api_service.dart';
import 'package:flutter_app_golden_time/widget_util.dart';

import '../layout_sw320dp/artist_detail_header_sw320dp.dart';
import '../layout_sw600dp/artist_detail_header_sw600dp.dart';
import '../layout_swNdp/artist_detail_header_swndp.dart';
import '../model/artist.dart';
import '../util.dart';
import 'artist_detail_comps.dart';
import 'artist_detail_records.dart';
import 'artist_detail_songs.dart';
import '../layout/image_gallery.dart';

class ArtistDetailPage extends StatefulWidget {
  final Artist artist;

  ArtistDetailPage({this.artist});

  @override
  State<StatefulWidget> createState() {
    return _ArtistDetailPageState();
  }
}

class _ArtistDetailPageState extends State<ArtistDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.artist?.name ?? '')),
      body: Container(
        child: FutureBuilder(
          future: ApiService.instance.fetchArtist(widget.artist.id),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? ArtistDetial(artist: snapshot.data)
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class ArtistDetial extends StatefulWidget {
  final Artist artist;

  ArtistDetial({this.artist});

  @override
  State<StatefulWidget> createState() {
    return _ArtistDetialState();
  }
}

class _ArtistDetialState extends State<ArtistDetial> {
  int _selection;
  Widget _widget;

  _ArtistDetialState();

  @override
  void initState() {
    super.initState();

    _selection = 0;
    _widget = _getTabView();
  }

  void setSelection(int selection) {
    setState(() {
      _selection = selection;
      _widget = _getTabView();
    });
  }

  Widget _getTabView() {
    Artist artist = widget.artist;

    switch (_selection) {
      case 0:
        return ArtistRecords(
          artistId: artist.id,
        );
      case 1:
        return ArtistSongs(
          artistId: artist.id,
        );
      case 2:
        return ArtistComps(
          artistId: artist.id,
        );
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Artist artist = widget.artist;

    Brightness brightness = Brightness.dark;

    Color _textColor =
        brightness == Brightness.light ? Colors.white : Colors.black;
    Color _textColorUnselected = Colors.grey;

    ArtistDetailHeader_swndp _header;

    if (!isLargeScreen(context)) {
      _header = ArtistDetailHeader_sw320dp(
        url: getArtistCover(artist,
            size: 320 * MediaQuery.of(context).devicePixelRatio),
        artist: artist,
      );
    } else {
      _header = ArtistDetailHeader_sw600dp(
        url: getArtistCover(artist,
            size: 240 * MediaQuery.of(context).devicePixelRatio),
        artist: artist,
      );
    }

    return Container(
      child: SingleChildScrollView(
        child: Container(
          margin: getDetailContainerMargin(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _header,
              ButtonBar(
                mainAxisSize: MainAxisSize.max,
                alignment: MainAxisAlignment.start,
                children: <Widget>[
                  FlatButton.icon(
                    icon: const Icon(Icons.album, size: 18.0),
                    label: const Text('唱片', semanticsLabel: '唱片'),
                    textColor:
                        _selection == 0 ? _textColor : _textColorUnselected,
                    onPressed: () {
                      setSelection(0);
                    },
                  ),
                  FlatButton.icon(
                    icon: const Icon(Icons.library_music, size: 18.0),
                    label: const Text('歌曲', semanticsLabel: '歌曲'),
                    textColor:
                        _selection == 1 ? _textColor : _textColorUnselected,
                    onPressed: () {
                      setSelection(1);
                    },
                  ),
                  FlatButton.icon(
                    icon: const Icon(Icons.people, size: 18.0),
                    label: const Text('参与', semanticsLabel: '参与'),
                    textColor:
                        _selection == 2 ? _textColor : _textColorUnselected,
                    onPressed: () {
                      setSelection(2);
                    },
                  ),
                ],
              ),
              Container(
                child: _widget,
              ),
              Visibility(
                visible: (artist?.imageList?.length ?? 0) > 0,
                child: ImageGallery(imageList: artist.imageList),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
