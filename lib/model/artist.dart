import 'package:json_annotation/json_annotation.dart';

part 'artist.g.dart';

@JsonSerializable()
class Artist {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'records_count')
  // records_count
  int recordsCount;

  @JsonKey(name: 'songs_count')
  // songs_count
  int songsCount;

  @JsonKey(name: 'cover')
  String cover;

  @JsonKey(name: 'image_list')
  List<String> imageList;

  Artist({
    this.id,
    this.name,
    this.type,
    this.recordsCount,
    this.songsCount,
    this.cover,
    this.imageList,
  });

  String getTypeText() {
    switch (this.type) {
      case 1:
        return "男歌手";
      case 0:
        return "女歌手";
      case 2:
        return "组合";
      default:
        break;
    }
    return null;
  }

  static String getTypeTextStatic(int type) {
    switch (type) {
      case 1:
        return "男歌手";
      case 0:
        return "女歌手";
      case 2:
        return "组合";
      default:
        break;
    }
    return null;
  }

  @override
  String toString() {
    return 'Artist{id: $id, name: $name, type: $type, recordsCount: $recordsCount, songsCount: $songsCount, cover: $cover, imageList: $imageList}';
  }

  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistToJson(this);
}
