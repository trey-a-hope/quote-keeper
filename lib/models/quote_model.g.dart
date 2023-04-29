// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_QuoteModel _$$_QuoteModelFromJson(Map<String, dynamic> json) =>
    _$_QuoteModel(
      id: json['id'] as String?,
      quote: json['quote'] as String,
      bookTitle: json['bookTitle'] as String,
      author: json['author'] as String,
      imgPath: json['imgPath'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_QuoteModelToJson(_$_QuoteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quote': instance.quote,
      'bookTitle': instance.bookTitle,
      'author': instance.author,
      'imgPath': instance.imgPath,
      'createdAt': instance.createdAt.toIso8601String(),
    };
