// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Artist _$ArtistFromJson(Map<String, dynamic> json) {
  return Artist(
    id: json['id'] as int,
    name: json['name'] as String,
    type: json['type'] as int,
  )
    ..recordsCount = json['records_count'] as int
    ..songsCount = json['songs_count'] as int;
}

Map<String, dynamic> _$ArtistToJson(Artist instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'records_count': instance.recordsCount,
      'songs_count': instance.songsCount,
    };
