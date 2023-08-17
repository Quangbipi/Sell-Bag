import 'package:hive/hive.dart';

import '../models/user_model.dart';

class LocalAuthService{
  late Box<String> _tokenBox;
  late Box<UserModel> _userBox;

  LocalAuthService(){
    init();
  }

  Future<void> init() async {
    _tokenBox = await Hive.openBox<String>("token");
    _userBox = await Hive.openBox<UserModel>("user");
  }

  Future<void> addToken({required String token}) async {
    await _tokenBox.put("token", token);
  }

  Future<void> addUser({required UserModel userModel}) async {
    await _userBox.put("user", userModel);
  }

  Future<void> clear()async{
    _userBox.clear();
    _tokenBox.clear();
  }

  String? getToken() => _tokenBox.get("token");
  UserModel? getUser() => _userBox.get("user");
}