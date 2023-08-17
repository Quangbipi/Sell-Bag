import 'package:formz/formz.dart';

enum PasswordValidationError{
  invalid
}

class Password extends FormzInput<String, PasswordValidationError>{
  const Password.dirty([super.value = '']) : super.dirty();

  const Password.pure([super.value = '']) : super.pure();
  static final _passwordLength = 6;
  @override
  PasswordValidationError? validator(String value) {
    return value.length >= _passwordLength ? null : PasswordValidationError.invalid;
  }
}
enum ConfirmPasswordValidationError { invalid }

class ConfirmPassword extends FormzInput<String, ConfirmPasswordValidationError> {
  final String password;

  const ConfirmPassword.pure(this.password) : super.pure('');
  const ConfirmPassword.dirty(this.password, [String value = '']) : super.dirty(value);

  @override
  ConfirmPasswordValidationError? validator(String value) {
    return value == password ? null : ConfirmPasswordValidationError.invalid;
  }
}