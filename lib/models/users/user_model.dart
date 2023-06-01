import 'package:book_quotes/utils/timestamp_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// {@template user_model}
/// UserModel description
/// {@endtemplate}
@freezed
class UserModel with _$UserModel {
  /// {@macro user_model}
  const factory UserModel({
    required String uid,
    required String email,
    required String imgUrl,
    String? fcmToken,
    @TimestampConverter() created,
    @TimestampConverter() modified,
    required String username,
    required List<String> bookIDs,
  }) = _UserModel;

  /// Creates a UserModel from Json map
  factory UserModel.fromJson(Map<String, dynamic> data) =>
      _$UserModelFromJson(data);
}
