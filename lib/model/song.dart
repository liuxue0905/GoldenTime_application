import 'package:json_annotation/json_annotation.dart';

import 'artist.dart';
import 'record.dart';

part 'song.g.dart';

@JsonSerializable()
class Song {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'track')
  String track;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'lyricist')
  String lyricist;

  @JsonKey(name: 'composer')
  String composer;

  @JsonKey(name: 'arranger')
  String arranger;

  @JsonKey(name: 'vocalist')
  String vocalist;

  @JsonKey(name: 'producer')
  String producer;

  @JsonKey(name: 'bandsman')
  String bandsman;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'record')
  Record record;

  @JsonKey(name: 'artists')
  List<Artist> artists;

  Song({this.id, this.track, this.title, this.lyricist, this.composer, this.arranger, this.vocalist, this.producer, this.bandsman, this.description, this.record, this.artists});

  @override
  String toString() {
    return 'Song{id: $id, track: $track, title: $title, lyricist: $lyricist, composer: $composer, arranger: $arranger, vocalist: $vocalist, producer: $producer, bandsman: $bandsman, description: $description, record: $record, artists: $artists}';
  }

  factory Song.fromJson(Map<String, dynamic> json) => _$SongFromJson(json);

  Map<String, dynamic> toJson() => _$SongToJson(this);
}
