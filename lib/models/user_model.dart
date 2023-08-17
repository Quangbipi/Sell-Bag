import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
part 'user_model.g.dart';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

@HiveType(typeId: 4)
class UserModel extends Equatable {
  @HiveField(0)
  String id;
  @HiveField(1)
  String fullName;
  @HiveField(2)
  String email;
  @HiveField(3)
  String? image;
  @HiveField(4)
  DateTime? birthday;

  UserModel(
      {required this.id,
      required this.fullName,
      required this.email,
      this.image,
      this.birthday
      });

  @override
  // TODO: implement props
  List<Object?> get props => [id, fullName, email, image, birthday];

  factory UserModel.fromJson(Map<String, dynamic> data) => UserModel(
      id: data['id'].toString(),
      fullName: data['fullName'],
      email: data['email'],
      image: data['image'] == null ? null : data['image']['url'],
      birthday: data['age'] == null ? null : DateTime.parse(data['age'])
  );
}
