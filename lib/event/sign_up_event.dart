import 'package:equatable/equatable.dart';
import 'package:flutter_login/models/password.dart';
import 'package:flutter_login/models/user_model.dart';

import '../models/email.dart';

class SignUpEvent extends Equatable{
  SignUpEvent();

  @override

  List<Object?> get props => [];

}

class SignUpEmailChangedEvent extends SignUpEvent{
  final String email;
  SignUpEmailChangedEvent({required this.email});
  @override

  List<Object?> get props => [email];

}

class  SignUpPasswordChangedEvent extends SignUpEvent{
  final String password;
  SignUpPasswordChangedEvent({required this.password});
  @override

  List<Object?> get props => [password];

}

class  SignUpWithEmailPassword extends SignUpEvent{
  final String email;
  final String password;
  SignUpWithEmailPassword ({required this.email, required this.password});

  @override

  List<Object?> get props => [email, password];
}

class ConfirmPasswordChangeEvent extends SignUpEvent{
  final String confirmPass;

  ConfirmPasswordChangeEvent({required this.confirmPass});
  @override

  List<Object?> get props => [confirmPass];

}

