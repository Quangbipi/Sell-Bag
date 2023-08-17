import 'package:equatable/equatable.dart';
import 'package:flutter_login/models/email.dart';
import 'package:flutter_login/models/password.dart';
import 'package:formz/formz.dart';

enum SignUpStatus{
  success,
  failure,
  loading
}

class SignUpState extends Equatable{

  final Email email;
  final Password password;
  final ConfirmPassword confirmPassword;
  final SignUpStatus status;
  final bool isValid;
  final String? errorMessage;

  SignUpState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(''),
    this.status = SignUpStatus.failure,
    this.isValid = false,
    this.errorMessage
  });

  @override
  // TODO: implement props
  List<Object?> get props => [email, password,confirmPassword, status, isValid, errorMessage];

  SignUpState copyWith({
    Email? email,
    Password? password,
    ConfirmPassword? confirmPassword,
    SignUpStatus? status,
    bool? isValid,
    String? errorMessage
  }){
    return SignUpState(
        email: email ?? this.email,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        status: status ?? this.status,
        isValid: isValid ?? this.isValid,
        errorMessage: errorMessage ?? this.errorMessage
    );
  }


}