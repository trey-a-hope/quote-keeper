// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      uid: json['uid'] as String,
      email: json['email'] as String,
      imgUrl: json['imgUrl'] as String,
      fcmToken: json['fcmToken'] as String?,
      created: json['created'],
      modified: json['modified'],
      username: json['username'] as String,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'imgUrl': instance.imgUrl,
      'fcmToken': instance.fcmToken,
      'created': instance.created,
      'modified': instance.modified,
      'username': instance.username,
    };
