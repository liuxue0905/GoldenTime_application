// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Song _$SongFromJson(Map<String, dynamic> json) {
  return Song(
    id: json['id'] as int,
    track: json['track'] as String,
    title: json['title'] as String,
    lyricist: json['lyricist'] as String,
    composer: json['composer'] as String,
    arranger: json['arranger'] as String,
    vocalist: json['vocalist'] as String,
    producer: json['producer'] as String,
    bandsman: json['bandsman'] as String,
    description: json['description'] as String,
    record: json['record'] == null
        ? null
        : Record.fromJson(json['record'] as Map<String, dynamic>),
    artists: (json['artists'] as List)
        ?.map((e) =>
            e == null ? null : Artist.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SongToJson(Song instance) => <String, dynamic>{
      'id': instance.id,
      'track': instance.track,
      'title': instance.title,
      'lyricist': instance.lyricist,
      'composer': instance.composer,
      'arranger': instance.arranger,
      'vocalist': instance.vocalist,
      'producer': instance.producer,
      'bandsman': instance.bandsman,
      'description': instance.description,
      'record': instance.record,
      'artists': instance.artists,
    };
