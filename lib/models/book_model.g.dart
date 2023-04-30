// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BookModel _$$_BookModelFromJson(Map<String, dynamic> json) => _$_BookModel(
      id: json['id'] as String?,
      quote: json['quote'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      imgPath: json['imgPath'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_BookModelToJson(_$_BookModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quote': instance.quote,
      'title': instance.title,
      'author': instance.author,
      'imgPath': instance.imgPath,
      'createdAt': instance.createdAt.toIso8601String(),
    };
