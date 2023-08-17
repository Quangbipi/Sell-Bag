import 'package:equatable/equatable.dart';
import 'package:flutter_login/sate/login_sate.dart';
import 'package:flutter_login/sate/sign_up_state.dart';


import '../models/email.dart';
import '../models/password.dart';
import '../models/user_model.dart';

enum UpdateProfileStatus{
  success,
  failure,
}
class AuthState extends Equatable{
  final Email email;
  final Password password;
  final ConfirmPassword confirmPassword;
  final SignUpStatus signUpStatus;
  final LoginStatus loginStatus;
  final bool isValid;
  final String? errorMessage;
  final UserModel? userModel;
  final UpdateProfileStatus updateProfileStatus;

  AuthState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(''),
    this.signUpStatus = SignUpStatus.failure,
    this.loginStatus = LoginStatus.failure,
    this.isValid = false,
    this.errorMessage,
    this.userModel,
    this.updateProfileStatus = UpdateProfileStatus.failure
  });

  @override
  // TODO: implement props
  List<Object?> get props => [email, password,
    confirmPassword,
    signUpStatus,loginStatus,
    isValid, errorMessage, userModel, updateProfileStatus];

  AuthState copyWith({
    Email? email,
    Password? password,
    ConfirmPassword? confirmPassword,
    SignUpStatus? signUpStatus,
    LoginStatus? loginStatus,
    bool? isValid,
    String? errorMessage,
    UserModel? userModel,
    UpdateProfileStatus? updateProfileStatus
  }){
    return AuthState(
        email: email ?? this.email,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        signUpStatus: signUpStatus ?? this.signUpStatus,
        loginStatus: loginStatus ?? this.loginStatus,
        isValid: isValid ?? this.isValid,
        errorMessage: errorMessage ?? this.errorMessage,
        userModel: userModel ?? this.userModel,
        updateProfileStatus: updateProfileStatus ?? this.updateProfileStatus
    );
  }


}
