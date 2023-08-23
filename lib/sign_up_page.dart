import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/bloc/auth_bloc.dart';
import 'package:flutter_login/bottom_bar.dart';
import 'package:flutter_login/event/auth_event.dart';
import 'package:flutter_login/login_page.dart';
import 'package:flutter_login/sate/auth_state.dart';
import 'package:flutter_login/sate/sign_up_state.dart';

class SignUp extends StatelessWidget{

  bool show = false;

  @override
  Widget build(BuildContext context) {
    return  BlocListener<AuthBloc, AuthState>(
        listener: (context, state){
          if(state.signUpStatus == SignUpStatus.success){
            Navigator.push(context, MaterialPageRoute(
                builder:(context) =>const BottomBar()
            ));
          }
          if(state.errorMessage != "" && state.errorMessage !=null && show){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${state.errorMessage}")));
          }
        },
        child:SafeArea(
          child: Scaffold(
              body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
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
                            const Text("Sign up", style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),),
                            const SizedBox(height: 20,),
                            SizedBox(
                                height: 70,
                                child: _SignUpEmail()
                            ),
                            const SizedBox(height: 20,),
                            SizedBox(
                                height: 70,
                                child: _SignUpPassword()
                            ),
                            const SizedBox(height: 20,),
                            SizedBox(
                              height: 100,
                              child: _SignUpConFirmPass(),
                            ),
                            SizedBox(
                                height: 40,
                                width: 120,
                                child: _SignUpButton()
                            ),
                            const SizedBox(height: 20,),
                            RichText(
                              text: TextSpan(
                                  text: 'Already have an account.',
                                  style: const TextStyle(color: Colors.black, fontSize: 14),
                                  children: [
                                    TextSpan(
                                        text: ' Sign in',
                                        style: const TextStyle(color: Colors.blueAccent, fontSize: 14),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = (){
                                            print('click');
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
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
                            if(state.signUpStatus == SignUpStatus.loading){
                              return Center(
                                child: Container(
                                  margin: const EdgeInsets.only(top: 100),
                                  child: const CircularProgressIndicator(),
                                ),
                              );

                            }
                            return const SizedBox();

                          })
                    ],
                  )
              )
          ),
        )
    );

  }

}

class _SignUpButton extends StatelessWidget{
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

    return BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state){
          return TextButton(

            style: myButtonStyle(),
            onPressed: state.isValid? (){
              context.read<AuthBloc>().add(SignUpWithEmailPassword(email: state.email.value, password: state.password.value));

            } : null,
            child: const Text("Sign up"),
          );
        });
  }

}

class _SignUpEmail extends StatefulWidget{


  @override
  State<_SignUpEmail> createState() => _SignUpEmailState();
}

class _SignUpEmailState extends State<_SignUpEmail> {
  final TextEditingController _accountController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state){
          return TextField(
            onChanged: (value){
              context.read<AuthBloc>().add(EmailChangedEvent(email: value));

            },
            controller: _accountController,
            decoration: InputDecoration(
                hintText: "Enter email",
                labelText: "Email",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                contentPadding: const EdgeInsets.only(left: 10),
                errorText: !state.email.isValid && state.email.value.isNotEmpty ? "Invalid email" : null
            ),


          );

        });
  }
}

class _SignUpPassword extends StatefulWidget{

  @override
  State<_SignUpPassword> createState() => _SignUpPasswordState();
}

class _SignUpPasswordState extends State<_SignUpPassword> {
  final TextEditingController _passwordController =TextEditingController();
  bool showPass = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state){
          return TextField(
            onChanged: (value){
              context.read<AuthBloc>().add(PasswordChangedEvent(password: value));

            },
            obscureText: showPass,
            controller: _passwordController,
            decoration: InputDecoration(
                hintText: "Password",
                labelText: "Enter password",
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
                errorText: !state.password.isValid && state.password.value.isNotEmpty ? "Password > 6 characters" : null

            ),

          );

        });
  }
}

class _SignUpConFirmPass extends StatefulWidget{

  @override
  State<_SignUpConFirmPass> createState() => _SignUpConFirmPassState();
}

class _SignUpConFirmPassState extends State<_SignUpConFirmPass> {
  final TextEditingController _passwordController =TextEditingController();

  bool showPass = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state){
          return TextField(
            onChanged: (value){
              context.read<AuthBloc>().add(ConfirmPasswordChangeEvent(confirmPass: value));

            },
            controller: _passwordController,
            obscureText: showPass,
            decoration: InputDecoration(
                hintText: "Retype password",
                labelText:  "Retype password",
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
                errorText: !state.confirmPassword.isValid && state.confirmPassword.value.isNotEmpty ? "Password does not match" : null

            ),


          );

        });
  }
}