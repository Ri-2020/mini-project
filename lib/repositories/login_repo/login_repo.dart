abstract class LoginRepo {
  Future<Map>? userSignup(Map data);
  Future<Map>? userSignin(Map data);
}