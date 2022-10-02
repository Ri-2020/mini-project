import 'dart:convert';

import 'package:evika/data/remote/api_responce.dart';
import 'package:evika/data/remote/api_services/post_api_service.dart';
import 'package:evika/models/user/post_model.dart';
import 'package:evika/repositories/post_repo/post_repo_imp.dart';
import 'package:get/get.dart';

class PostVM extends GetxController {
  ApiResponce<Map<dynamic, dynamic>?> response = ApiResponce.loading();
  PostData postData = PostData();
  List<PostData> postList = <PostData>[].obs;

  late final Future? futurePosts;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    futurePosts = getAllPost();
  }

  PostApiServices postApiServices = PostApiServices();
  PostRepoImp postRepoImp = PostRepoImp();
  Future<List<PostData>?> getAllPost() async {
    response = ApiResponce.loading();
    update();
    Map<dynamic, dynamic>? data = await postRepoImp.getAllPost();
    // print(data);
    if (data != null) {
      List<dynamic> list = data['data'];
      response = ApiResponce.completed(data);
      update();
      // postList = parsePhotos(postdata);
      postList = [];
      for (int i = 0; i < list.length; i++) {
        String postdataStr = jsonEncode(list[i]);
        PostData postData = PostData.fromJson(postdataStr);
        // postList.add(pop);
        // postData = PostData(
        //   createdAt: list[i]['createdAt'] as String?,
        //   description: list[i]['description'] as String?,
        //   eventCategory: list[i]['eventCategory'] as String?,
        //   eventEndAt: list[i]['eventEndAt'] as String?,
        // );
        print("aaaaaaaaaaaaaaaaaaa");
        postList.add(postData);
        update();
      }
      print(postList.length);
      return postList;
    } else {
      response = ApiResponce.error("No data found");
      update();
      return null;
    }
  }
}