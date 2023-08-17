import 'dart:html';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/models/email.dart';
import 'package:flutter_login/models/password.dart';
import 'package:flutter_login/sate/login_sate.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:formz/formz.dart';
class LoginCubit extends Cubit<LoginState>{
  LoginCubit() : super(LoginState());

  // void emailChanged(String value){
  //   final email  = Email.dirty(value);
  //   emit(
  //     state.copyWith(
  //       email: email,
  //       isValid: Formz.validate([email, state.password])
  //     )
  //   );
  // }
  //
  // void passwordChanged(String value){
  //   final password = Password.dirty(value);
  //   emit(
  //     state.copyWith(
  //       password: password,
  //       isValid: Formz.validate([state.email, password])
  //     )
  //   );
  // }


}