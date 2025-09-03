// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_books_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SearchBooksResultModelImpl _$$SearchBooksResultModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SearchBooksResultModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      author: json['author'] as String?,
      description: json['description'] as String?,
      imgUrl: json['imgUrl'] as String?,
    );

Map<String, dynamic> _$$SearchBooksResultModelImplToJson(
        _$SearchBooksResultModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'description': instance.description,
      'imgUrl': instance.imgUrl,
    };
