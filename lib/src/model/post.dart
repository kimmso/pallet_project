import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@unfreezed
class Post with _$Post {
  factory Post({
    required String? content,
    required String? photo_url,
    required bool? share_check,
  }) = _Post;
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
