import 'package:formz/formz.dart';

enum EmailValidationError{
  invalid
}

class Email extends FormzInput<String, EmailValidationError>{
  const Email.dirty([super.value = '']) : super.dirty();

  const Email.pure([super.value = '']) : super.pure();
  static final _emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  @override
  EmailValidationError? validator(String value) {
    return _emailRegExp.hasMatch(value ?? '') ? null : EmailValidationError.invalid;
  }

  

}