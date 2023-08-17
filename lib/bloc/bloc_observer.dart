import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/bloc/auth_bloc.dart';
import 'package:flutter_login/bloc/banner_bloc.dart';
import 'package:flutter_login/bloc/cart_bloc.dart';
import 'package:flutter_login/bloc/category_bloc.dart';
import 'package:flutter_login/bloc/login_bloc.dart';
import 'package:flutter_login/bloc/popular_product_bloc.dart';
import 'package:flutter_login/bloc/product_bloc.dart';
import 'package:flutter_login/bloc/search_bloc.dart';
import 'package:flutter_login/bloc/sign_up_bloc.dart';
import 'package:flutter_login/bloc/tab_bloc.dart';

class LoginObserver extends BlocObserver{
    @override
  void onChange(BlocBase bloc, Change change) {
    // TODO: implement onChange
    super.onChange(bloc, change);
    // if(bloc is LoginBloc){
    //     print("Change: $change");
    // }
    // if(bloc is SignUpBloc){
    //   print("Change: $change");
    // }
    // if(bloc is BannerBloc){
    //   print("Change: $change");
    // }
    // if(bloc is CategoryBloc){
    //   print("Change: $change");
    // }
    // if(bloc is PopularProductBloc){
    //   print("Change: $change");
    // }
    // if(bloc is ProductBloc){
    //   print("Change: $change");
    // }
    // if(bloc is TabBloc){
    //   print("Change: $change");
    // }
    // if(bloc is SearchBloc){
    //   print("Change: $change");
    // }
    // if(bloc is AuthBloc){
    //   print("Change: $change");
    // }
    if(bloc is CartBloc){
      print("Change: $change");
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    // TODO: implement onTransition
    super.onTransition(bloc, transition);
    // if(bloc is LoginBloc){
    //     print("Transition: $transition");
    // }
    // if(bloc is SignUpBloc){
    //   print("Transition: $transition");
    // }
    // if(bloc is BannerBloc){
    //   print("Transition: $transition");
    // }
    // if(bloc is CategoryBloc){
    //   print("Transition: $transition");
    // }
    // if(bloc is PopularProductBloc){
    //   print("Transition: $transition");
    // }
    // if(bloc is TabBloc){
    //   print("Transition: $transition");
    // }
    // if(bloc is SearchBloc){
    //   print("Transition: $transition");
    // }
    // if(bloc is AuthBloc){
    //   print("Transition: $transition");
    // }
    if(bloc is CartBloc){
      print("Transition: $transition");
    }
  }
}