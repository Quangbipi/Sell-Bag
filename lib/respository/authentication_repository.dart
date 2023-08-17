import 'dart:convert';

import 'package:flutter_login/models/user_model.dart';
import 'package:flutter_login/services/local_auth_service.dart';

import '../const.dart';
import 'package:http/http.dart' as http;

class AuthenticationRepository {
  var remoteUrl = '$baseUrl/api/auth/local/register';
  final client = http.Client();
  final LocalAuthService _authService = LocalAuthService();

  Future<dynamic> signUp(
      {required String email, required String password}) async {
    var body = {"username": email, "email": email, "password": password};
    var response = await client.post(
        Uri.parse('$baseUrl/api/auth/local/register'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body));
    return response;
  }

  Future<dynamic> createProfile(
      {required String fullName, required String token}) async {
    var body = {
      "fullName": fullName
    };
    var response = await client.post(
        Uri.parse('$baseUrl/api/profile/me'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(body));
    return response;
  }

  Future<dynamic> signIn(
      {required String email, required String password}) async {
    var body = {
      "identifier": email,
      "password": password
    };
    var response = await client.post(
        Uri.parse('$baseUrl/api/auth/local'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body));

    return response;
  }

  Future<dynamic> getProfile({
    required String token,
  }) async {
    var response = await client.get(
      Uri.parse('$baseUrl/api/profile/me'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    return response;
  }

  Future<dynamic> updateProfile(
  int id,
  String fullName,
  String email,
  var image,
  String birthday) async {
    try{
      var body = {
        "data": {
          "fullName": fullName,
          "email": email,
          "age": birthday ,
          "image": image
        }
      };
      // var response = await client.put(
      //     Uri.parse('$baseUrl/api/profiles/$id'),
      //     headers: {
      //       "Content-Type": "application/json",
      //     },
      //     body: jsonEncode(body));
      // return response;
      var responsee;
      await client.put(
        Uri.parse('$baseUrl/api/profiles/$id'),
        headers: {
          "Content-Type": "application/json",
        },body: jsonEncode(body)
      ).timeout(Duration(seconds: 5))
      .then((response) async{
        if(response.statusCode == 200){

          var userResult = await getProfile(token: _authService.getToken()!);
          if (userResult.statusCode == 200) {
            UserModel userModel = userFromJson(userResult.body);
            _authService.addUser(userModel: userModel);
          }
          responsee = response;
        }
      }).catchError((e){
        print(e.toString());
      });

      return responsee;
    }catch(e){
      print(e.toString());
    }
  }
}
