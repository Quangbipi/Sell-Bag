import 'package:equatable/equatable.dart';
import 'package:flutter_login/models/password.dart';
import 'package:flutter_login/models/user_model.dart';

import '../models/email.dart';

class LoginEvent extends Equatable{
  LoginEvent();

  @override

  List<Object?> get props => [];

}

class LoginEmailChangedEvent extends LoginEvent{
  final String email;
  LoginEmailChangedEvent({required this.email});
  @override

  List<Object?> get props => [email];

}

class LoginPasswordChangedEvent extends LoginEvent{
  final String password;
  LoginPasswordChangedEvent({required this.password});
  @override

  List<Object?> get props => [password];

}

class LoginWithEmailPassword extends LoginEvent{
    final String email;
    final String password;
    LoginWithEmailPassword ({required this.email, required this.password});

    @override

    List<Object?> get props => [email, password];
}


