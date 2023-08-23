import 'dart:async';
import 'dart:convert';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/models/user_model.dart';
import 'package:flutter_login/sate/auth_state.dart';
import 'package:flutter_login/sate/login_sate.dart';
import 'package:formz/formz.dart';
import '../event/auth_event.dart';
import '../models/email.dart';
import '../models/password.dart';
import '../respository/authentication_repository.dart';
import '../sate/sign_up_state.dart';
import '../services/local_auth_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationRepository _authenticationRepository;
  final LocalAuthService _authService = LocalAuthService();
  AuthBloc(this._authenticationRepository) : super(AuthState()) {
    on<EmailChangedEvent>(_handlerEmailChangedEvent);
    on<PasswordChangedEvent>(_handlerPasswordChangedEvent);
    on<ConfirmPasswordChangeEvent>(_handlerConfirmPasswordChangeEvent);
    on<SignUpWithEmailPassword>(_handlerSignUpWithEmailPassword);
    on<LoginWithEmailPasswordEvent>(_handlerLoginWithEmailPassword);
    on<SignOutEvent>(_handlerSignOut);
    on<PasswordLoginChangedEvent>(_handlerPasswordLoginChangedEvent);
    on<UpdateProfileEvent>(_handlerUpdateProfileEvent);
    on<ErrorStateEvent>(_handlerError);
  }

  FutureOr<void> _handlerEmailChangedEvent(
      EmailChangedEvent event, Emitter<AuthState> emit) async {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.password])
    ));
  }

  FutureOr<void> _handlerPasswordChangedEvent(
      PasswordChangedEvent event, Emitter<AuthState> emit) async {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
        password: password,
        isValid: Formz.validate([state.email, password]),
    ));
    final confirmPassword =
        ConfirmPassword.dirty(event.password, state.confirmPassword.value);
    emit(
      state.copyWith(
          confirmPassword: confirmPassword,
          isValid:
              Formz.validate([state.email, state.password, confirmPassword])),
    );
  }

  FutureOr<void> _handlerSignUpWithEmailPassword(
      SignUpWithEmailPassword event, Emitter<AuthState> emit) async {
    emit(state.copyWith(signUpStatus: SignUpStatus.loading));
    await _authService.init();
    try {
      var response = await _authenticationRepository.signUp(
          email: event.email, password: event.password);

      if (response.statusCode == 200) {
        String token = json.decode(response.body)['jwt'];
        var userResult = await _authenticationRepository.createProfile(
            fullName: event.email, token: token);
        if (userResult.statusCode == 200) {
          UserModel userModel = userFromJson(userResult.body);
          emit(state.copyWith(
              signUpStatus: SignUpStatus.success,
              loginStatus: LoginStatus.success,
              userModel: userModel
          ));
          _authService.addToken(token: token);
          _authService.addUser(userModel: userModel);
        } else {
          print("Đăng ký lỗi 1 ${userResult.statusCode}");
        }
      } else {
        print("Đăng ký lỗi2 ${response.statusCode}");
      }
    } catch (e) {
      emit(state.copyWith(
          errorMessage: "Đăng ký thất bại",
          signUpStatus: SignUpStatus.failure));
    }
  }

  FutureOr<void> _handlerConfirmPasswordChangeEvent(
      ConfirmPasswordChangeEvent event, Emitter<AuthState> emit) async {
    final confirmPassword =
        ConfirmPassword.dirty(state.password.value, event.confirmPass);
    emit(
      state.copyWith(
          confirmPassword: confirmPassword,
          isValid:
              Formz.validate([state.email, state.password, confirmPassword])),
    );
  }

  FutureOr<void> _handlerLoginWithEmailPassword(
      LoginWithEmailPasswordEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(loginStatus: LoginStatus.loading));
    await _authService.init();
    try {
      var response = await _authenticationRepository.signIn(
          email: event.email, password: event.password);

      if (response.statusCode == 200) {
        String token = json.decode(response.body)['jwt'];
        var userResult = await _authenticationRepository.getProfile(token: token);
        if (userResult.statusCode == 200) {
          UserModel userModel = userFromJson(userResult.body);
          emit(state.copyWith(
              loginStatus: LoginStatus.success,
              userModel: userModel
          ));
          _authService.addToken(token: token);
          _authService.addUser(userModel: userModel);
        } else {
          print("Đăng nhập lỗi 1 ${userResult.statusCode}");
        }
      } else {
        emit(state.copyWith(errorMessage: "Sign in failed", loginStatus: LoginStatus.failure));
        print("Đăng nhập lỗi2 ${response.statusCode}");
      }
    } catch (e) {
      emit(state.copyWith(
          errorMessage: "Sign in failed",
          loginStatus: LoginStatus.failure));
    }
  }

  FutureOr<void> _handlerSignOut(
      SignOutEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(loginStatus: LoginStatus.failure, signUpStatus: SignUpStatus.failure));
  }

  FutureOr<void> _handlerPasswordLoginChangedEvent(
      PasswordLoginChangedEvent event, Emitter<AuthState> emit) async{
    final password = Password.dirty(event.password);
    emit(state.copyWith(password: password, errorMessage: null,
        isValid: Formz.validate([state.email, password])));
  }

  FutureOr<void> _handlerUpdateProfileEvent(
      UpdateProfileEvent event, Emitter<AuthState> emit) async {
    try{
      var response = await _authenticationRepository.updateProfile(
          event.id, event.fullName, event.email, event.image, event.birthday);
      if(response.statusCode == 200){

        emit(state.copyWith(updateProfileStatus: UpdateProfileStatus.success, userModel: _authService.getUser()));


      }
    }catch(e){
      emit(state.copyWith(updateProfileStatus: UpdateProfileStatus.failure));
      print(e.toString());
    }
  }

  FutureOr<void> _handlerError(ErrorStateEvent event, Emitter<AuthState> emit) {

    emit(state.copyWith(errorMessage: event.error));
  }
}
