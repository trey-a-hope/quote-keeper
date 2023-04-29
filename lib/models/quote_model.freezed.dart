// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quote_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

QuoteModel _$QuoteModelFromJson(Map<String, dynamic> json) {
  return _QuoteModel.fromJson(json);
}

/// @nodoc
mixin _$QuoteModel {
  String? get id => throw _privateConstructorUsedError;
  String get quote => throw _privateConstructorUsedError;
  String get bookTile => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QuoteModelCopyWith<QuoteModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuoteModelCopyWith<$Res> {
  factory $QuoteModelCopyWith(
          QuoteModel value, $Res Function(QuoteModel) then) =
      _$QuoteModelCopyWithImpl<$Res, QuoteModel>;
  @useResult
  $Res call({String? id, String quote, String bookTile, DateTime createdAt});
}

/// @nodoc
class _$QuoteModelCopyWithImpl<$Res, $Val extends QuoteModel>
    implements $QuoteModelCopyWith<$Res> {
  _$QuoteModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? quote = null,
    Object? bookTile = null,
    Object? createdAt = null,
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
      bookTile: null == bookTile
          ? _value.bookTile
          : bookTile // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_QuoteModelCopyWith<$Res>
    implements $QuoteModelCopyWith<$Res> {
  factory _$$_QuoteModelCopyWith(
          _$_QuoteModel value, $Res Function(_$_QuoteModel) then) =
      __$$_QuoteModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String quote, String bookTile, DateTime createdAt});
}

/// @nodoc
class __$$_QuoteModelCopyWithImpl<$Res>
    extends _$QuoteModelCopyWithImpl<$Res, _$_QuoteModel>
    implements _$$_QuoteModelCopyWith<$Res> {
  __$$_QuoteModelCopyWithImpl(
      _$_QuoteModel _value, $Res Function(_$_QuoteModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? quote = null,
    Object? bookTile = null,
    Object? createdAt = null,
  }) {
    return _then(_$_QuoteModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      quote: null == quote
          ? _value.quote
          : quote // ignore: cast_nullable_to_non_nullable
              as String,
      bookTile: null == bookTile
          ? _value.bookTile
          : bookTile // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_QuoteModel with DiagnosticableTreeMixin implements _QuoteModel {
  _$_QuoteModel(
      {this.id,
      required this.quote,
      required this.bookTile,
      required this.createdAt});

  factory _$_QuoteModel.fromJson(Map<String, dynamic> json) =>
      _$$_QuoteModelFromJson(json);

  @override
  final String? id;
  @override
  final String quote;
  @override
  final String bookTile;
  @override
  final DateTime createdAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'QuoteModel(id: $id, quote: $quote, bookTile: $bookTile, createdAt: $createdAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'QuoteModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('quote', quote))
      ..add(DiagnosticsProperty('bookTile', bookTile))
      ..add(DiagnosticsProperty('createdAt', createdAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QuoteModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.quote, quote) || other.quote == quote) &&
            (identical(other.bookTile, bookTile) ||
                other.bookTile == bookTile) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, quote, bookTile, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_QuoteModelCopyWith<_$_QuoteModel> get copyWith =>
      __$$_QuoteModelCopyWithImpl<_$_QuoteModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_QuoteModelToJson(
      this,
    );
  }
}

abstract class _QuoteModel implements QuoteModel {
  factory _QuoteModel(
      {final String? id,
      required final String quote,
      required final String bookTile,
      required final DateTime createdAt}) = _$_QuoteModel;

  factory _QuoteModel.fromJson(Map<String, dynamic> json) =
      _$_QuoteModel.fromJson;

  @override
  String? get id;
  @override
  String get quote;
  @override
  String get bookTile;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_QuoteModelCopyWith<_$_QuoteModel> get copyWith =>
      throw _privateConstructorUsedError;
}
