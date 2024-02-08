// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_books_result_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SearchBooksResultModel _$SearchBooksResultModelFromJson(
    Map<String, dynamic> json) {
  return _SearchBooksResultModel.fromJson(json);
}

/// @nodoc
mixin _$SearchBooksResultModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get author => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get imgUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SearchBooksResultModelCopyWith<SearchBooksResultModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchBooksResultModelCopyWith<$Res> {
  factory $SearchBooksResultModelCopyWith(SearchBooksResultModel value,
          $Res Function(SearchBooksResultModel) then) =
      _$SearchBooksResultModelCopyWithImpl<$Res, SearchBooksResultModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      String? author,
      String? description,
      String? imgUrl});
}

/// @nodoc
class _$SearchBooksResultModelCopyWithImpl<$Res,
        $Val extends SearchBooksResultModel>
    implements $SearchBooksResultModelCopyWith<$Res> {
  _$SearchBooksResultModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? author = freezed,
    Object? description = freezed,
    Object? imgUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imgUrl: freezed == imgUrl
          ? _value.imgUrl
          : imgUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchBooksResultModelImplCopyWith<$Res>
    implements $SearchBooksResultModelCopyWith<$Res> {
  factory _$$SearchBooksResultModelImplCopyWith(
          _$SearchBooksResultModelImpl value,
          $Res Function(_$SearchBooksResultModelImpl) then) =
      __$$SearchBooksResultModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String? author,
      String? description,
      String? imgUrl});
}

/// @nodoc
class __$$SearchBooksResultModelImplCopyWithImpl<$Res>
    extends _$SearchBooksResultModelCopyWithImpl<$Res,
        _$SearchBooksResultModelImpl>
    implements _$$SearchBooksResultModelImplCopyWith<$Res> {
  __$$SearchBooksResultModelImplCopyWithImpl(
      _$SearchBooksResultModelImpl _value,
      $Res Function(_$SearchBooksResultModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? author = freezed,
    Object? description = freezed,
    Object? imgUrl = freezed,
  }) {
    return _then(_$SearchBooksResultModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imgUrl: freezed == imgUrl
          ? _value.imgUrl
          : imgUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SearchBooksResultModelImpl implements _SearchBooksResultModel {
  _$SearchBooksResultModelImpl(
      {required this.id,
      required this.title,
      required this.author,
      required this.description,
      required this.imgUrl});

  factory _$SearchBooksResultModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearchBooksResultModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? author;
  @override
  final String? description;
  @override
  final String? imgUrl;

  @override
  String toString() {
    return 'SearchBooksResultModel(id: $id, title: $title, author: $author, description: $description, imgUrl: $imgUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchBooksResultModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imgUrl, imgUrl) || other.imgUrl == imgUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, author, description, imgUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchBooksResultModelImplCopyWith<_$SearchBooksResultModelImpl>
      get copyWith => __$$SearchBooksResultModelImplCopyWithImpl<
          _$SearchBooksResultModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchBooksResultModelImplToJson(
      this,
    );
  }
}

abstract class _SearchBooksResultModel implements SearchBooksResultModel {
  factory _SearchBooksResultModel(
      {required final String id,
      required final String title,
      required final String? author,
      required final String? description,
      required final String? imgUrl}) = _$SearchBooksResultModelImpl;

  factory _SearchBooksResultModel.fromJson(Map<String, dynamic> json) =
      _$SearchBooksResultModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get author;
  @override
  String? get description;
  @override
  String? get imgUrl;
  @override
  @JsonKey(ignore: true)
  _$$SearchBooksResultModelImplCopyWith<_$SearchBooksResultModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
