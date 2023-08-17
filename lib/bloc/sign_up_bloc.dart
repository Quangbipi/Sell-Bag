import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/event/login_event.dart';
import 'package:flutter_login/sate/sign_up_state.dart';
import 'package:formz/formz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../event/sign_up_event.dart';
import '../models/email.dart';
import '../models/password.dart';
import '../respository/authentication_repository.dart';
import '../services/local_auth_service.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthenticationRepository _authenticationRepository;
  final  LocalAuthService _authService =  LocalAuthService();
  SignUpBloc(this._authenticationRepository) : super(SignUpState()) {
    on<SignUpEmailChangedEvent>(_handelSignUpEmailChangedEvent);
    on<SignUpPasswordChangedEvent>(_handelSignUpPasswordChangedEvent);
    on<ConfirmPasswordChangeEvent>(_handelConfirmPasswordChangeEvent);
    on<SignUpWithEmailPassword>(_handelSignUpWithEmailPassword);
  }

  FutureOr<void> _handelSignUpEmailChangedEvent(
      SignUpEmailChangedEvent event, Emitter<SignUpState> emit) async {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
        email: email, isValid: Formz.validate([email, state.password])));
  }

  FutureOr<void> _handelSignUpPasswordChangedEvent(
      SignUpPasswordChangedEvent event, Emitter<SignUpState> emit) async {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
        password: password, isValid: Formz.validate([state.email, password])));
    final confirmPassword =
        ConfirmPassword.dirty(event.password, state.confirmPassword.value);
    emit(
      state.copyWith(
          confirmPassword: confirmPassword,
          isValid:
              Formz.validate([state.email, state.password, confirmPassword])),
    );
  }

  FutureOr<void> _handelSignUpWithEmailPassword(
      SignUpWithEmailPassword event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(status: SignUpStatus.loading));
    await _authService.init();
    // try {
    //   await FirebaseAuth.instance.createUserWithEmailAndPassword(
    //       email: event.email, password: event.password);
    //
    //   emit(state.copyWith(status: SignUpStatus.success));
    // } catch (e) {
    //   emit(state.copyWith(
    //       errorMessage: "Đăng ký thất bại", status: SignUpStatus.failure));
    // }

    try{
      var result = await _authenticationRepository.signUp(email: event.email, password: event.password);
      if(result.statusCode == 200){
        print(result.body);
        emit(state.copyWith(status: SignUpStatus.success));
      }
    }catch(e){
      emit(state.copyWith(
          errorMessage: "Đăng ký thất bại", status: SignUpStatus.failure));

    }
  }

  FutureOr<void> _handelConfirmPasswordChangeEvent(
      ConfirmPasswordChangeEvent event, Emitter<SignUpState> emit) async {
    final confirmPassword =
        ConfirmPassword.dirty(state.password.value, event.confirmPass);
    emit(
      state.copyWith(
          confirmPassword: confirmPassword,
          isValid:
              Formz.validate([state.email, state.password, confirmPassword])),
    );
  }
}
