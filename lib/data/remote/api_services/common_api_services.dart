import 'dart:convert';

import 'package:evika/data/remote/api_interface.dart';
import 'package:evika/data/remote/api_services/api_services.dart';
import 'package:evika/utils/sharedPreferenced.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getToken() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString("token")!;
}

class CommonApiServices extends CommoApiInterface {
  ApiServices apiServices = ApiServices();
  @override
  Future<List<String>>? userLikedPosts() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/api/account/likedposts/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "authorization": "Bearer $token",
      },
    );

    // // print("common response.body : ${response.body}");
    if (response.statusCode == 200) {
      List<String> likedPosts = [];
      Map<String, dynamic> res = jsonDecode(response.body);
      likedPosts = res["data"].cast<String>();

      // print("likedPosts : $likedPosts");
      return likedPosts;
    }
    return [];
  }

  @override
  Future<List>? getAndAddComments(String postId, String? text) async {
    String token = await getToken();

    final response;
    if (text == null) {
      response = await http.get(
        Uri.parse('$baseUrl/api/user/get-comments/$postId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "authorization": "Bearer $token",
        },
      );
    } else {
      var r = await http.post(
          Uri.parse('$baseUrl/api/user/post-comment/$postId'),
          headers: <String, String>{
            "authorization": "Bearer $token",
          },
          body: {
            "comment": text
          });
      Map<String, dynamic> res = jsonDecode(r.body);

      if (res["status"] == "success") {
        response = await http.get(
          Uri.parse('$baseUrl/api/user/get-comments/$postId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "authorization": "Bearer $token",
          },
        );
      } else {
        response = r;
      }
    }
    if (response.statusCode == 200) {
      List comments = [];
      Map<String, dynamic> res = jsonDecode(response.body);
      comments = res["data"];

      return comments;
    }
    return [];
  }

  @override
  Future<bool> functionalityComment(String postId, String? text) async {
    String token = await getToken();
    final response = await http.post(
        Uri.parse('$baseUrl/api/user/post-comment/$postId'),
        headers: <String, String>{
          "authorization": "Bearer $token",
        },
        body: {
          "comment": text
        });
    if (response != null && response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      return res["success"] == "success" ? true : false;
    }
    return false;
  }

  @override
  Future<bool> commentFunctionality(
      String postId, String? type, String commentId) async {
    String token = await getToken();
    final response = await http.post(
        Uri.parse('$baseUrl/api/user/commentfunctionality/$postId'),
        headers: <String, String>{
          "authorization": "Bearer $token",
        },
        body: {
          "type": type,
          "commentID": commentId
        });
    if (response != null && response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      return res["success"] == "success" ? true : false;
    }
    return false;
  }

  @override
  Future<bool> followUser(String otherUserId) async {
    String token = await getToken();
    String? userId = await SharedPrefs.getString("userId");
    // debugPrint("userId : $userId and otherUSerId : $otherUserId");
    final response = await http.get(
        Uri.parse('$baseUrl/api/account/follow/$userId/$otherUserId'),
        headers: <String, String>{
          "authorization": "Bearer $token",
        });
    if (response != null && response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      return res["success"] == "success" ? true : false;
    }
    return false;
  }

  @override
  Future<Map<String, dynamic>> getUserPost(String userId) async {
    try {
      debugPrint("fetched");
      var token = await SharedPrefs.getString("token");
      final response = await http.get(
        Uri.parse('$baseUrl/api/user/get-posts/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        // debugPrint(response.body);
        Map<String, dynamic> body = apiServices.returnResponse(response);
        return body;
      } else {
        throw Exception('Failed to load post');
      }
    } catch (err) {
      debugPrint("$err");
    }
    return {};
  }

  @override
  Future<Map<String, dynamic>> otherUsersData(String userId) async {
    print("other user id : $userId");
    final response = await http.get(
      Uri.parse('$baseUrl/api/account/user-data/$userId'),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> body = apiServices.returnResponse(response);
      return body;
    }
    return {};
  }
}
