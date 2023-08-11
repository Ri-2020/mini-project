import 'dart:convert';
import 'package:http/http.dart' as http;

const String baseUrl = 'https://evika-backend.vercel.app';
// const String baseUrl = "http://192.168.56.1:8000";
const mlBaseUrl = "https://evika-ml.herokuapp.com";
// const String baseUrl = "http://192.168.29.29:8000";

class ApiServices {
  dynamic returnResponse(http.Response? response) {
    // debugPrint(response!.body.toString());
    switch (response!.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw Exception('Bad Request');
      case 401:
        return null;
      case 403:
        throw Exception('Unauthorized');
      case 500:
        return null;
      default:
        throw Exception('Internal Server Error');
    }
  }
}
