import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_bloc.dart';
import '../event/login_event.dart';
import '../sate/login_sate.dart';

class LoginPassword extends StatelessWidget{

  String _password = "";
  int type;

  LoginPassword({required this.type});
  final TextEditingController _passwordController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state){
          return TextField(
            onChanged: (value){
              context.read<LoginBloc>().add(LoginPasswordChangedEvent(password: value));
              _password = state.password.value;
            },
            controller: _passwordController,
            decoration: InputDecoration(
                hintText: type==0?"Nhập mật khẩu": "Nhập lại mật khẩu",
                labelText: type==0? "Mật khẩu":"Nhập lại mật khẩu",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                contentPadding: EdgeInsets.only(left: 10),
                errorText: !state.password.isValid && state.password.value.length > 0 ? "Mật khẩu > 6" : null
            ),


          );

        });
  }

}