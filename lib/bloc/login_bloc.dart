import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/event/login_event.dart';
import 'package:flutter_login/models/email.dart';
import 'package:flutter_login/models/password.dart';
import 'package:flutter_login/sate/login_sate.dart';
import 'package:formz/formz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class LoginBloc extends Bloc<LoginEvent, LoginState>{



  LoginBloc() : super(LoginState()){
    on<LoginEmailChangedEvent>(_handelLoginEmailChangedEvent);
    on<LoginPasswordChangedEvent>(_handelLoginPasswordChangedEvent);
    on<LoginWithEmailPassword>(_handelLoginWithEmailPassword);
  }

  FutureOr<void> _handelLoginEmailChangedEvent(
      LoginEmailChangedEvent event,
      Emitter<LoginState> emit
      ) async{
        final email = Email.dirty(event.email);
        emit(state.copyWith(email: email, errorMessage: null,
            isValid: Formz.validate([email, state.password])));
  }

  FutureOr<void> _handelLoginPasswordChangedEvent(
      LoginPasswordChangedEvent event,
      Emitter<LoginState> emit
      ) async{
    final password = Password.dirty(event.password);
    emit(state.copyWith(password: password, errorMessage: null,
        isValid: Formz.validate([state.email, password])));
  }



  FutureOr<void> _handelLoginWithEmailPassword(
      LoginWithEmailPassword event,
      Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      emit(state.copyWith(status: LoginStatus.success));
    }catch(e){

      emit(state.copyWith(errorMessage:"Tên đăng nhập hoặc mật khẩu không chính xác", status: LoginStatus.failure));
    }

  }
}