import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'quote_model.freezed.dart';
part 'quote_model.g.dart';

@freezed
class QuoteModel with _$QuoteModel {
  factory QuoteModel({
    String? id,
    required String quote,
    required String bookTitle,
    required String author,
    required String imgPath,
    required DateTime createdAt,
  }) = _QuoteModel;

  factory QuoteModel.fromJson(Map<String, dynamic> json) =>
      _$QuoteModelFromJson(json);
}

//flutter pub run build_runner build --delete-conflicting-outputs