import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_books_result_model.freezed.dart';
part 'search_books_result_model.g.dart';

@freezed
class SearchBooksResultModel with _$SearchBooksResultModel {
  factory SearchBooksResultModel({
    required String id,
    required String title,
    required String? author,
    required String? description,
    required String? imgUrl,
  }) = _SearchBooksResultModel;

  factory SearchBooksResultModel.fromJson(Map<String, dynamic> json) =>
      _$SearchBooksResultModelFromJson(json);
}

//flutter pub run build_runner build --delete-conflicting-outputs