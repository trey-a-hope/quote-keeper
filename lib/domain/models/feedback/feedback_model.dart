import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quote_keeper/utils/converters/timestamp_converters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feedback_model.freezed.dart';
part 'feedback_model.g.dart';

/// {@template feed_back_model}
/// FeedbackModel description
/// {@endtemplate}
@freezed
class FeedbackModel with _$FeedbackModel {
  /// {@macro book_model}
  const factory FeedbackModel({
    String? id,
    required String text,
    required dynamic screenshot,
    @TimestampConverter() required DateTime created,
    required String uid,
  }) = _FeedbackModel;

  /// Creates a BookModel from Json map
  factory FeedbackModel.fromJson(Map<String, dynamic> data) =>
      _$FeedbackModelFromJson(data);
}

//flutter pub run build_runner build --delete-conflicting-outputs