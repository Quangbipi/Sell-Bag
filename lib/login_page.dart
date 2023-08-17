import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/bloc/auth_bloc.dart';
import 'package:flutter_login/bloc/cart_bloc.dart';
import 'package:flutter_login/bottom_bar.dart';
import 'package:flutter_login/const.dart';
import 'package:flutter_login/event/auth_event.dart';
import 'package:flutter_login/event/cart_event.dart';
import 'package:flutter_login/home.dart';
import 'package:flutter_login/sate/auth_state.dart';
import 'package:flutter_login/sate/login_sate.dart';
import 'package:flutter_login/services/local_auth_service.dart';
import 'package:flutter_login/sign_up_page.dart';
import 'package:flutter_login/styles/my_button_style.dart';


class LoginPage extends StatelessWidget{

  LoginPage({Key? key}) : super(key: key);

  final TextEditingController _accountController = TextEditingController();
  final LocalAuthService _authService = LocalAuthService();
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return  BlocListener<AuthBloc, AuthState>(
        listener: (context, state){
            if(state.loginStatus== LoginStatus.success){
              isLogin = true;
              Navigator.push(context, MaterialPageRoute(
                builder:(context) =>BottomBar()
              ));
              context
                  .read<CartBloc>()
                  .add(GetCartEvent(int.parse(_authService.getUser()!.id)));

            }
            if(state.loginStatus == LoginStatus.failure && state.errorMessage != null){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.errorMessage}'),
                ),
              );
            }
            // if(state.status == LoginStatus.loading){
            //   Center(
            //       child: Container(
            //         margin: EdgeInsets.only(top: 100),
            //         child: CircularProgressIndicator(),
            //       )
            //   );
            // }
        },
        child:SafeArea(
          child: Scaffold(
              body: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Loggin", style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),),
                                SizedBox(height: 20,),
                                SizedBox(
                                  height: 70,
                                  child: _LoginEmail(),
                                ),
                                SizedBox(height: 20,),
                                SizedBox(
                                  height: 100,
                                  child: _LoginPassword(),
                                ),
                                SizedBox(
                                    height: 40,
                                    width: 120,
                                    child: _LoginButton()
                                ),
                                SizedBox(height: 20,),
                                RichText(
                                  text: TextSpan(
                                      text: 'Don\'t have an account?',
                                      style: TextStyle(color: Colors.black, fontSize: 14),
                                      children: [
                                        TextSpan(
                                            text: ' Sign up',
                                            style: TextStyle(color: Colors.blueAccent, fontSize: 14),
                                            recognizer: TapGestureRecognizer()
                                            ..onTap = (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                                            }
                                        )
                                      ]
                                  ),
                                ),


                              ],
                            ),
                            BlocBuilder<AuthBloc, AuthState>(
                                builder: (context, state){
                                  if(state.loginStatus == LoginStatus.loading){
                                    return Center(
                                      child: Container(
                                        margin: EdgeInsets.only(top: 100),
                                        child: CircularProgressIndicator(),
                                      ),
                                    );

                                  }
                                  if(state.loginStatus == LoginStatus.failure ){
                                    return SizedBox();
                                  }
                                  return SizedBox();

                            })
                          ],
                        )
                      )
                  )
              )
          ),
        )
        );

  }

}

class _LoginButton extends StatelessWidget{
  // ButtonStyle myButtonStyle() {
  //   return ButtonStyle(
  //       shape: MaterialStateProperty.all(RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(10)
  //       )),
  //       backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
  //       foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
  //       overlayColor: MaterialStateProperty.resolveWith<Color?>(
  //               (Set<MaterialState> states) {
  //             if (states.contains(MaterialState.hovered)) {
  //               return Colors.yellow.withOpacity(0.04);
  //             }
  //             if (states.contains(MaterialState.focused) ||
  //                 states.contains(MaterialState.pressed)) {
  //               return Colors.yellow.withOpacity(0.12);
  //             }
  //             return null;
  //           }));
  // }
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state){
          return TextButton(

            style: myButtonStyle(140, 40),
            onPressed: state.isValid? (){
              print("Click");
              context.read<AuthBloc>().add(LoginWithEmailPasswordEvent(email: state.email.value, password: state.password.value));

            } : null,
            child: Text("Đăng nhập"),
          );
        });
  }

}

class _LoginPassword extends StatelessWidget{

  String _password = "";

  final TextEditingController _passwordController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state){
          return TextField(
            onChanged: (value){
              context.read<AuthBloc>().add(PasswordLoginChangedEvent(password: value));
              _password = state.password.value;
            },
            controller: _passwordController,
            decoration: InputDecoration(
                hintText: "Nhập mật khẩu",
                labelText: "Mật khẩu",
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
class _LoginEmail extends StatelessWidget{


  final TextEditingController _accountController =TextEditingController();
  String _email = "";
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state){
          return TextField(
            onChanged: (value){
              context.read<AuthBloc>().add(EmailChangedEvent(email: value));
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

