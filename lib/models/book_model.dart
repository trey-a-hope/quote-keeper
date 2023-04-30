
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'book_model.freezed.dart';
part 'book_model.g.dart';

@freezed
class BookModel with _$BookModel {
  factory BookModel({
    String? id,
    required String quote,
    required String title,
    required String author,
    required String imgPath,
    required DateTime createdAt,
  }) = _BookModel;

  factory BookModel.fromJson(Map<String, dynamic> json) =>
      _$BookModelFromJson(json);
}

//flutter pub run build_runner build --delete-conflicting-outputs