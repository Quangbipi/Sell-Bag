import 'package:equatable/equatable.dart';
import 'package:flutter_login/models/email.dart';
import 'package:flutter_login/models/password.dart';
import 'package:formz/formz.dart';

enum LoginStatus{
  success,
  failure,
  loading
}

class LoginState extends Equatable{

  final Email email;
  final Password password;
  final LoginStatus status;
  final bool isValid;
  final String? errorMessage;

  LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = LoginStatus.failure,
    this.isValid = false,
    this.errorMessage
  });

  @override
  // TODO: implement props
  List<Object?> get props => [email, password, status, isValid, errorMessage];

  LoginState copyWith({
    Email? email,
    Password? password,
    LoginStatus? status,
    bool? isValid,
    String? errorMessage
  }){
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }


}