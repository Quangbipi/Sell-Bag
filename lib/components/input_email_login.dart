import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_bloc.dart';
import '../event/login_event.dart';
import '../sate/login_sate.dart';

class LoginEmail extends StatelessWidget{

  int type;

  LoginEmail({required this.type});
  final TextEditingController _accountController =TextEditingController();
  String _email = "";
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state){
          return TextField(
            onChanged: (value){
              context.read<LoginBloc>().add(LoginEmailChangedEvent(email: value));
              _email = state.email.value;

            },
            controller: _accountController,
            decoration: InputDecoration(
                hintText: "Nhập tên tài khoản",
                labelText: "Tài khoản",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                contentPadding: EdgeInsets.only(left: 10),
                errorText: !state.email.isValid && state.email.value.length >0 ? "Email không hợp lệ" : null
            ),


          );

        });
  }

}