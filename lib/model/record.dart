import 'package:json_annotation/json_annotation.dart';

import 'artist.dart';
import 'company.dart';
import 'song.dart';

part 'record.g.dart';

@JsonSerializable()
class Record {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'number')
  String number;

  @JsonKey(name: 'format')
  int format;

  /// 4 | A four-digit year
  @JsonKey(name: 'year')
  String year;

  // release_detail
  @JsonKey(name: 'release_detail')
  String releaseDetail;

  // release_order
  @JsonKey(name: 'release_order')
  String releaseOrder;

  @JsonKey(name: 'producer')
  String producer;

  @JsonKey(name: 'recorder')
  String recorder;

  @JsonKey(name: 'mixer')
  String mixer;

  @JsonKey(name: 'bandsman')
  String bandsman;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'artists')
  List<Artist> artists;

  @JsonKey(name: 'company')
  Company company;

  @JsonKey(name: 'songs')
  List<Song> songs;

  @JsonKey(name: 'songs_count')
  int songsCount;

  @JsonKey(name: 'cover')
  String cover;

  @JsonKey(name: 'image_list')
  List<String> imageList;

  Record({
    this.id,
    this.title,
    this.number,
    this.format,
    this.releaseDetail,
    this.releaseOrder,
    this.producer,
    this.recorder,
    this.mixer,
    this.bandsman,
    this.description,
    this.artists,
    this.company,
    this.songs,
    this.songsCount,
  });

  String getFormatText() {
    switch (this.format) {
      case 1:
        return "CD";
      case 2:
        return "LP";
      case 3:
        return "MC";
      case 4:
        return "DATA";
      default:
        break;
    }
    return null;
  }

  static String getFormatTextStatic(int format) {
    switch (format) {
      case 1:
        return "CD";
      case 2:
        return "LP";
      case 3:
        return "MC";
      case 4:
        return "DATA";
      default:
        break;
    }
    return null;
  }

  @override
  String toString() {
    return 'Record{id: $id, title: $title, number: $number, format: $format, year: $year, releaseDetail: $releaseDetail, releaseOrder: $releaseOrder, producer: $producer, recorder: $recorder, mixer: $mixer, bandsman: $bandsman, description: $description, artists: $artists, company: $company, songs: $songs, cover: $cover, imageList: $imageList}';
  }

  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);

  Map<String, dynamic> toJson() => _$RecordToJson(this);
}
