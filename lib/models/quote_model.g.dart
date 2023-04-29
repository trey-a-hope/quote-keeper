// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_QuoteModel _$$_QuoteModelFromJson(Map<String, dynamic> json) =>
    _$_QuoteModel(
      id: json['id'] as String?,
      quote: json['quote'] as String,
      bookTile: json['bookTile'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_QuoteModelToJson(_$_QuoteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quote': instance.quote,
      'bookTile': instance.bookTile,
      'createdAt': instance.createdAt.toIso8601String(),
    };
