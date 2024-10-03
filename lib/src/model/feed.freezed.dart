// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Feed _$FeedFromJson(Map<String, dynamic> json) {
  return _Feed.fromJson(json);
}

/// @nodoc
mixin _$Feed {
// ignore: invalid_annotation_target
  @JsonKey(name: "photo_url")
  String? get photoUrl =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: "photo_url")
  set photoUrl(String? value) =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: "post_no")
  int? get postNo =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: "post_no")
  set postNo(int? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FeedCopyWith<Feed> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedCopyWith<$Res> {
  factory $FeedCopyWith(Feed value, $Res Function(Feed) then) =
      _$FeedCopyWithImpl<$Res, Feed>;
  @useResult
  $Res call(
      {@JsonKey(name: "photo_url") String? photoUrl,
      @JsonKey(name: "post_no") int? postNo});
}

/// @nodoc
class _$FeedCopyWithImpl<$Res, $Val extends Feed>
    implements $FeedCopyWith<$Res> {
  _$FeedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? photoUrl = freezed,
    Object? postNo = freezed,
  }) {
    return _then(_value.copyWith(
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      postNo: freezed == postNo
          ? _value.postNo
          : postNo // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeedImplCopyWith<$Res> implements $FeedCopyWith<$Res> {
  factory _$$FeedImplCopyWith(
          _$FeedImpl value, $Res Function(_$FeedImpl) then) =
      __$$FeedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "photo_url") String? photoUrl,
      @JsonKey(name: "post_no") int? postNo});
}

/// @nodoc
class __$$FeedImplCopyWithImpl<$Res>
    extends _$FeedCopyWithImpl<$Res, _$FeedImpl>
    implements _$$FeedImplCopyWith<$Res> {
  __$$FeedImplCopyWithImpl(_$FeedImpl _value, $Res Function(_$FeedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? photoUrl = freezed,
    Object? postNo = freezed,
  }) {
    return _then(_$FeedImpl(
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      postNo: freezed == postNo
          ? _value.postNo
          : postNo // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FeedImpl implements _Feed {
  _$FeedImpl(
      {@JsonKey(name: "photo_url") required this.photoUrl,
      @JsonKey(name: "post_no") required this.postNo});

  factory _$FeedImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeedImplFromJson(json);

// ignore: invalid_annotation_target
  @override
  @JsonKey(name: "photo_url")
  String? photoUrl;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: "post_no")
  int? postNo;

  @override
  String toString() {
    return 'Feed(photoUrl: $photoUrl, postNo: $postNo)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedImplCopyWith<_$FeedImpl> get copyWith =>
      __$$FeedImplCopyWithImpl<_$FeedImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeedImplToJson(
      this,
    );
  }
}

abstract class _Feed implements Feed {
  factory _Feed(
      {@JsonKey(name: "photo_url") required String? photoUrl,
      @JsonKey(name: "post_no") required int? postNo}) = _$FeedImpl;

  factory _Feed.fromJson(Map<String, dynamic> json) = _$FeedImpl.fromJson;

  @override // ignore: invalid_annotation_target
  @JsonKey(name: "photo_url")
  String? get photoUrl; // ignore: invalid_annotation_target
  @JsonKey(name: "photo_url")
  set photoUrl(String? value);
  @override // ignore: invalid_annotation_target
  @JsonKey(name: "post_no")
  int? get postNo; // ignore: invalid_annotation_target
  @JsonKey(name: "post_no")
  set postNo(int? value);
  @override
  @JsonKey(ignore: true)
  _$$FeedImplCopyWith<_$FeedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
