import 'package:equatable/equatable.dart';

class AuthEvent extends Equatable{
  AuthEvent();

  @override

  List<Object?> get props => [];

}

class EmailChangedEvent extends AuthEvent{
  final String email;
  EmailChangedEvent({required this.email});
  @override

  List<Object?> get props => [email];

}

class  PasswordChangedEvent extends AuthEvent{
  final String password;
  PasswordChangedEvent({required this.password});
  @override

  List<Object?> get props => [password];

}

class  PasswordLoginChangedEvent extends AuthEvent{
  final String password;
  PasswordLoginChangedEvent({required this.password});
  @override

  List<Object?> get props => [password];

}

class  SignUpWithEmailPassword extends AuthEvent{
  final String email;
  final String password;
  SignUpWithEmailPassword ({required this.email, required this.password});

  @override

  List<Object?> get props => [email, password];
}

class ConfirmPasswordChangeEvent extends AuthEvent{
  final String confirmPass;

  ConfirmPasswordChangeEvent({required this.confirmPass});
  @override

  List<Object?> get props => [confirmPass];

}

class LoginWithEmailPasswordEvent extends AuthEvent{
  final String email;
  final String password;
  LoginWithEmailPasswordEvent ({required this.email, required this.password});

  @override

  List<Object?> get props => [email, password];
}

class SignOutEvent extends AuthEvent{

}

class UpdateProfileEvent extends AuthEvent{
  final int id;
  final String fullName;
  final String email;
  var image;
  final String birthday;

  UpdateProfileEvent(
      this.id,
      this.fullName,
      this.email,
      this.image,
      this.birthday,
      );
}