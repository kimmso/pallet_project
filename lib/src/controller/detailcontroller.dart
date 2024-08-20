import 'package:get/get.dart';
import 'package:pallet_project/src/model/feeddetail.dart';
import 'package:pallet_project/src/repository/detail_repository.dart';

class DetailController extends GetxController {
  final Rxn<FeedDetail> _feeddetails = Rxn<FeedDetail>();

  final DetailRepository repository;
  DetailController({
    required this.repository,
  });

  Future<FeedDetail?> detailfetchData(int post_no) async {
    final feeddetail = await repository.detailApi(post_no);
    if (feeddetail != null) {
      _feeddetails.value = feeddetail;

      return feeddetail;
    } else {}
  }
}
