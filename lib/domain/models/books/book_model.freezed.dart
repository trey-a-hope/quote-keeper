// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BookModel _$BookModelFromJson(Map<String, dynamic> json) {
  return _BookModel.fromJson(json);
}

/// @nodoc
mixin _$BookModel {
  String? get id => throw _privateConstructorUsedError;
  String get quote => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get author => throw _privateConstructorUsedError;
  String? get imgPath => throw _privateConstructorUsedError;
  bool get hidden => throw _privateConstructorUsedError;
  @TimestampConverter()
  dynamic get created => throw _privateConstructorUsedError;
  @TimestampConverter()
  dynamic get modified => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BookModelCopyWith<BookModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookModelCopyWith<$Res> {
  factory $BookModelCopyWith(BookModel value, $Res Function(BookModel) then) =
      _$BookModelCopyWithImpl<$Res, BookModel>;
  @useResult
  $Res call(
      {String? id,
      String quote,
      String title,
      String author,
      String? imgPath,
      bool hidden,
      @TimestampConverter() dynamic created,
      @TimestampConverter() dynamic modified,
      String uid});
}

/// @nodoc
class _$BookModelCopyWithImpl<$Res, $Val extends BookModel>
    implements $BookModelCopyWith<$Res> {
  _$BookModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? quote = null,
    Object? title = null,
    Object? author = null,
    Object? imgPath = freezed,
    Object? hidden = null,
    Object? created = freezed,
    Object? modified = freezed,
    Object? uid = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      quote: null == quote
          ? _value.quote
          : quote // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      imgPath: freezed == imgPath
          ? _value.imgPath
          : imgPath // ignore: cast_nullable_to_non_nullable
              as String?,
      hidden: null == hidden
          ? _value.hidden
          : hidden // ignore: cast_nullable_to_non_nullable
              as bool,
      created: freezed == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as dynamic,
      modified: freezed == modified
          ? _value.modified
          : modified // ignore: cast_nullable_to_non_nullable
              as dynamic,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BookModelCopyWith<$Res> implements $BookModelCopyWith<$Res> {
  factory _$$_BookModelCopyWith(
          _$_BookModel value, $Res Function(_$_BookModel) then) =
      __$$_BookModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String quote,
      String title,
      String author,
      String? imgPath,
      bool hidden,
      @TimestampConverter() dynamic created,
      @TimestampConverter() dynamic modified,
      String uid});
}

/// @nodoc
class __$$_BookModelCopyWithImpl<$Res>
    extends _$BookModelCopyWithImpl<$Res, _$_BookModel>
    implements _$$_BookModelCopyWith<$Res> {
  __$$_BookModelCopyWithImpl(
      _$_BookModel _value, $Res Function(_$_BookModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? quote = null,
    Object? title = null,
    Object? author = null,
    Object? imgPath = freezed,
    Object? hidden = null,
    Object? created = freezed,
    Object? modified = freezed,
    Object? uid = null,
  }) {
    return _then(_$_BookModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      quote: null == quote
          ? _value.quote
          : quote // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      imgPath: freezed == imgPath
          ? _value.imgPath
          : imgPath // ignore: cast_nullable_to_non_nullable
              as String?,
      hidden: null == hidden
          ? _value.hidden
          : hidden // ignore: cast_nullable_to_non_nullable
              as bool,
      created: freezed == created ? _value.created! : created,
      modified: freezed == modified ? _value.modified! : modified,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BookModel implements _BookModel {
  const _$_BookModel(
      {this.id,
      required this.quote,
      required this.title,
      required this.author,
      required this.imgPath,
      required this.hidden,
      @TimestampConverter() this.created,
      @TimestampConverter() this.modified,
      required this.uid});

  factory _$_BookModel.fromJson(Map<String, dynamic> json) =>
      _$$_BookModelFromJson(json);

  @override
  final String? id;
  @override
  final String quote;
  @override
  final String title;
  @override
  final String author;
  @override
  final String? imgPath;
  @override
  final bool hidden;
  @override
  @TimestampConverter()
  final dynamic created;
  @override
  @TimestampConverter()
  final dynamic modified;
  @override
  final String uid;

  @override
  String toString() {
    return 'BookModel(id: $id, quote: $quote, title: $title, author: $author, imgPath: $imgPath, hidden: $hidden, created: $created, modified: $modified, uid: $uid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BookModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.quote, quote) || other.quote == quote) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.imgPath, imgPath) || other.imgPath == imgPath) &&
            (identical(other.hidden, hidden) || other.hidden == hidden) &&
            const DeepCollectionEquality().equals(other.created, created) &&
            const DeepCollectionEquality().equals(other.modified, modified) &&
            (identical(other.uid, uid) || other.uid == uid));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      quote,
      title,
      author,
      imgPath,
      hidden,
      const DeepCollectionEquality().hash(created),
      const DeepCollectionEquality().hash(modified),
      uid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BookModelCopyWith<_$_BookModel> get copyWith =>
      __$$_BookModelCopyWithImpl<_$_BookModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BookModelToJson(
      this,
    );
  }
}

abstract class _BookModel implements BookModel {
  const factory _BookModel(
      {final String? id,
      required final String quote,
      required final String title,
      required final String author,
      required final String? imgPath,
      required final bool hidden,
      @TimestampConverter() final dynamic created,
      @TimestampConverter() final dynamic modified,
      required final String uid}) = _$_BookModel;

  factory _BookModel.fromJson(Map<String, dynamic> json) =
      _$_BookModel.fromJson;

  @override
  String? get id;
  @override
  String get quote;
  @override
  String get title;
  @override
  String get author;
  @override
  String? get imgPath;
  @override
  bool get hidden;
  @override
  @TimestampConverter()
  dynamic get created;
  @override
  @TimestampConverter()
  dynamic get modified;
  @override
  String get uid;
  @override
  @JsonKey(ignore: true)
  _$$_BookModelCopyWith<_$_BookModel> get copyWith =>
      throw _privateConstructorUsedError;
}
