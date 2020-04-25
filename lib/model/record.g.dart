// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Record _$RecordFromJson(Map<String, dynamic> json) {
  return Record(
    id: json['id'] as int,
    title: json['title'] as String,
    number: json['number'] as String,
    format: json['format'] as int,
    releaseDetail: json['release_detail'] as String,
    releaseOrder: json['release_order'] as String,
    producer: json['producer'] as String,
    recorder: json['recorder'] as String,
    mixer: json['mixer'] as String,
    bandsman: json['bandsman'] as String,
    description: json['description'] as String,
    artists: (json['artists'] as List)
        ?.map((e) =>
            e == null ? null : Artist.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    company: json['company'] == null
        ? null
        : Company.fromJson(json['company'] as Map<String, dynamic>),
    songs: (json['songs'] as List)
        ?.map(
            (e) => e == null ? null : Song.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..year = json['year'] as String;
}

Map<String, dynamic> _$RecordToJson(Record instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'number': instance.number,
      'format': instance.format,
      'year': instance.year,
      'release_detail': instance.releaseDetail,
      'release_order': instance.releaseOrder,
      'producer': instance.producer,
      'recorder': instance.recorder,
      'mixer': instance.mixer,
      'bandsman': instance.bandsman,
      'description': instance.description,
      'artists': instance.artists,
      'company': instance.company,
      'songs': instance.songs,
    };
