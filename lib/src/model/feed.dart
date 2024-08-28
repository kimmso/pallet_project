import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed.freezed.dart';
part 'feed.g.dart';

@unfreezed
class Feed with _$Feed {
  factory Feed({
    // ignore: invalid_annotation_target
    @JsonKey(name: "photo_url") required String? photoUrl,
    // ignore: invalid_annotation_target
    @JsonKey(name: "post_no") required int? postNo,
  }) = _Feed;
  factory Feed.fromJson(Map<String, dynamic> json) => _$FeedFromJson(json);
}
