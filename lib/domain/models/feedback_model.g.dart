// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FeedbackModelImpl _$$FeedbackModelImplFromJson(Map<String, dynamic> json) =>
    _$FeedbackModelImpl(
      id: json['id'] as String?,
      text: json['text'] as String,
      screenshot: json['screenshot'] as String,
      created:
          const TimestampConverter().fromJson(json['created'] as Timestamp),
      uid: json['uid'] as String,
    );

Map<String, dynamic> _$$FeedbackModelImplToJson(_$FeedbackModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'screenshot': instance.screenshot,
      'created': const TimestampConverter().toJson(instance.created),
      'uid': instance.uid,
    };
