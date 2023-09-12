// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_books_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SearchBooksResultModel _$$_SearchBooksResultModelFromJson(
        Map<String, dynamic> json) =>
    _$_SearchBooksResultModel(
      id: json['id'] as String,
      title: json['title'] as String,
      author: json['author'] as String?,
      description: json['description'] as String?,
      imgUrl: json['imgUrl'] as String?,
    );

Map<String, dynamic> _$$_SearchBooksResultModelToJson(
        _$_SearchBooksResultModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'description': instance.description,
      'imgUrl': instance.imgUrl,
    };
