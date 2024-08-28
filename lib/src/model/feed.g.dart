// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FeedImpl _$$FeedImplFromJson(Map<String, dynamic> json) => _$FeedImpl(
      photoUrl: json['photo_url'] as String?,
      postNo: (json['post_no'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$FeedImplToJson(_$FeedImpl instance) =>
    <String, dynamic>{
      'photo_url': instance.photoUrl,
      'post_no': instance.postNo,
    };
