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
                builder:(context) =>const BottomBar()
              ));
              context
                  .read<CartBloc>()
                  .add(GetCartEvent(int.parse(_authService.getUser()!.id)));

            }
            if(state.errorMessage != "" && state.errorMessage !=null && show
            ){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.errorMessage}'),
                ),
              );
              context.read<AuthBloc>().add(ErrorStateEvent(""));
            }
            show = true;

        },
        child:SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/Hana.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Sign in", style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),),
                        const SizedBox(height: 20,),
                        SizedBox(
                          height: 70,
                          child: _LoginEmail(),
                        ),
                        const SizedBox(height: 20,),
                        SizedBox(
                          height: 100,
                          child: _LoginPassword(),
                        ),
                        SizedBox(
                            height: 40,
                            width: 120,
                            child: _LoginButton()
                        ),
                        const SizedBox(height: 20,),
                        RichText(
                          text: TextSpan(
                              text: 'Don\'t have an account?',
                              style: const TextStyle(color: Colors.black, fontSize: 14),
                              children: [
                                TextSpan(
                                    text: ' Sign up',
                                    style: const TextStyle(color: Colors.blueAccent, fontSize: 14),
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
                  ),
                  BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state){
                        if(state.loginStatus == LoginStatus.loading){
                          return Center(
                            child: Container(
                              margin: const EdgeInsets.only(top: 100),
                              child: const CircularProgressIndicator(),
                            ),
                          );

                        }
                        if(state.loginStatus == LoginStatus.failure ){
                          return const SizedBox();
                        }
                        return const SizedBox();

                      })
                ],
              ),
            ),
          )
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
            child: const Text("Sign in"),
          );
        });
  }

}

class _LoginPassword extends StatefulWidget{

  @override
  State<_LoginPassword> createState() => _LoginPasswordState();
}

class _LoginPasswordState extends State<_LoginPassword> {
  String _password = "";

  bool showPass = true;

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
            obscureText: showPass,
            controller: _passwordController,
            decoration: InputDecoration(
                hintText: "Enter password",
                labelText: "Password",
                suffixIcon: IconButton(
                  onPressed: (){
                    setState(() {
                      showPass = !showPass;
                    });
                  },
                  icon: const Icon(Icons.remove_red_eye_outlined),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                contentPadding: const EdgeInsets.only(left: 10),
                errorText: !state.password.isValid && state.password.value.length > 0 ? "Password > 6 characters" : null
            ),


          );

    });
  }
}
class _LoginEmail extends StatefulWidget{
  @override
  State<_LoginEmail> createState() => _LoginEmailState();
}

class _LoginEmailState extends State<_LoginEmail> {
  String _email = "";

  final TextEditingController _accountController =TextEditingController();

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
                hintText: "Enter email",
                labelText: "Email",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                contentPadding: const EdgeInsets.only(left: 10),
                errorText: !state.email.isValid && state.email.value.length >0 ? "Invalid email" : null
            ),
          );

        });
  }
}

