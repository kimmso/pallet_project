import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pallet_project/src/model/feed.dart';

part 'myprofil.freezed.dart';
part 'myprofil.g.dart';

@freezed
class MyProfil with _$MyProfil {
  factory MyProfil({
    required String? id,
    required String? name,
    required int? total_like_count,
    required int? total_post_count,
    required List<Feed> myPost,
  }) = _MyProfil;
  factory MyProfil.fromJson(Map<String, dynamic> json) =>
      _$MyProfilFromJson(json);
}
