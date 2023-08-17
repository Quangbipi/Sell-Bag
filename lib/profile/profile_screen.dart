import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/bloc/auth_bloc.dart';
import 'package:flutter_login/event/auth_event.dart';
import 'package:flutter_login/login_page.dart';
import 'package:flutter_login/profile/profile_detail.dart';
import 'package:flutter_login/sate/auth_state.dart';
import 'package:flutter_login/sate/login_sate.dart';
import 'package:flutter_login/services/local_auth_service.dart';

import '../const.dart';
class ProfileScreen extends StatefulWidget {

  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final LocalAuthService _authService = LocalAuthService();

  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context,state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 20,),
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 36,
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage('assets/user_image.png'),
                    ),

                  ),
                  const SizedBox(width: 12,),
                  Text(
                    state.loginStatus == LoginStatus.success ? state.userModel!.fullName :'Sign in your account ',
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40,),
              buildProfileCard(
                  title: "Profile Info",
                  onClick: (){
                    if(state.loginStatus == LoginStatus.success){

                      print(_authService.getUser()!.email);
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProfileDetail(userModel: _authService.getUser()!,)));
                      return;
                    }else{
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    }

                  }
              ),
              buildProfileCard(
                  title: "Notification",
                  onClick: (){

                  }
              ),
              buildProfileCard(
                  title: "Settings",
                  onClick: (){

                  }
              ),
              buildProfileCard(
                  title: "About us",
                  onClick: (){

                  }
              ),
              buildProfileCard(
                  title: "Terms of service",
                  onClick: (){

                  }
              ),
              buildProfileCard(
                  title: state.loginStatus == LoginStatus.success?"Sign out":"Sign in",
                  onClick: (){
                    if(state.loginStatus == LoginStatus.success){
                      _authService.clear();
                      isLogin = false;
                      context.read<AuthBloc>().add(SignOutEvent());
                    }else{
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    }

                  }
              ),

            ],
          ),
        );
      },
    );

  }
}

Widget buildProfileCard ({required String title,
  required Function() onClick
}){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: (){
        onClick();
      },
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 0.1,
                  blurRadius: 7
              )
            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),
            const Icon(Icons.keyboard_arrow_right)
          ],
        ),
      ),
    ),
  );
}
