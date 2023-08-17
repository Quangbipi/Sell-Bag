import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_bloc.dart';
import '../event/login_event.dart';
import '../sate/login_sate.dart';

class LoginButton extends StatelessWidget{

  int type;
  LoginButton({required this.type});
  ButtonStyle myButtonStyle() {
    return ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        )),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return Colors.yellow.withOpacity(0.04);
              }
              if (states.contains(MaterialState.focused) ||
                  states.contains(MaterialState.pressed)) {
                return Colors.yellow.withOpacity(0.12);
              }
              return null;
            }));
  }
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state){
          return TextButton(

            style: myButtonStyle(),
            onPressed: state.isValid? (){
              print("Click");
              context.read<LoginBloc>().add(LoginWithEmailPassword(email: state.email.value, password: state.password.value));

            } : null,
            child: type==0?Text("Đăng nhập"):Text("Đăng ký"),
          );
        });
  }

}