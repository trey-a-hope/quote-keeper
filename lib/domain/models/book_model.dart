import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quote_keeper/utils/converters/timestamp_converters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'books/book_model.freezed.dart';
part 'books/book_model.g.dart';

/// {@template book_model}
/// BookModel description
/// {@endtemplate}
@freezed
class BookModel with _$BookModel {
  /// {@macro book_model}
  const factory BookModel({
    String? id,
    required String quote,
    required String title,
    required String author,
    required String? imgPath,
    required bool hidden,
    @TimestampConverter() required DateTime created,
    @TimestampConverter() required DateTime modified,
    required String uid,
    required bool complete,
  }) = _BookModel;

  /// Creates a BookModel from Json map
  factory BookModel.fromJson(Map<String, dynamic> data) =>
      _$BookModelFromJson(data);
}

//flutter pub run build_runner build --delete-conflicting-outputs