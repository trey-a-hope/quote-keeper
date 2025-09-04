// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookModelImpl _$$BookModelImplFromJson(Map<String, dynamic> json) =>
    _$BookModelImpl(
      id: json['id'] as String?,
      quote: json['quote'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      imgPath: json['imgPath'] as String?,
      hidden: json['hidden'] as bool,
      created:
          const TimestampConverter().fromJson(json['created'] as Timestamp),
      modified:
          const TimestampConverter().fromJson(json['modified'] as Timestamp),
      uid: json['uid'] as String,
      complete: json['complete'] as bool,
    );

Map<String, dynamic> _$$BookModelImplToJson(_$BookModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quote': instance.quote,
      'title': instance.title,
      'author': instance.author,
      'imgPath': instance.imgPath,
      'hidden': instance.hidden,
      'created': const TimestampConverter().toJson(instance.created),
      'modified': const TimestampConverter().toJson(instance.modified),
      'uid': instance.uid,
      'complete': instance.complete,
    };
