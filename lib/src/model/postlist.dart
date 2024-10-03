import 'package:freezed_annotation/freezed_annotation.dart';

part 'postlist.freezed.dart';
part 'postlist.g.dart';

@unfreezed
class PostList with _$PostList {
  factory PostList({
    required String? content,
    required String? photo_url,
    required int? post_no,
    required int? like_count,
    required bool? like,
  }) = _PostList;
  factory PostList.fromJson(Map<String, dynamic> json) =>
      _$PostListFromJson(json);
}
