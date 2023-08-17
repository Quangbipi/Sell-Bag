import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/bloc/auth_bloc.dart';
import 'package:flutter_login/bloc/auth_repository.dart';
import 'package:flutter_login/bloc/banner_bloc.dart';
import 'package:flutter_login/bloc/cart_bloc.dart';
import 'package:flutter_login/bloc/login_bloc.dart';
import 'package:flutter_login/bloc/popular_product_bloc.dart';
import 'package:flutter_login/bloc/product_bloc.dart';
import 'package:flutter_login/bloc/search_bloc.dart';
import 'package:flutter_login/bloc/sign_up_bloc.dart';
import 'package:flutter_login/bloc/tab_bloc.dart';
import 'package:flutter_login/bottom_bar.dart';
import 'package:flutter_login/cart/cart_view.dart';
import 'package:flutter_login/event/banner_event.dart';
import 'package:flutter_login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_login/profile/profile_detail.dart';
import 'package:flutter_login/respository/authentication_repository.dart';
import 'package:flutter_login/respository/brand_repository.dart';
import 'package:flutter_login/respository/cart_repository.dart';
import 'package:flutter_login/respository/popular_category_repository.dart';
import 'package:flutter_login/respository/popular_product_repository.dart';
import 'package:flutter_login/respository/product_repository.dart';
import 'package:flutter_login/respository/respository_banner.dart';

import 'bloc/brand_bloc.dart';
import 'bloc/category_bloc.dart';
import 'cart/component/cart_card.dart';
import 'home.dart';
class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<BannerRepository>(
              create: (context) => BannerRepository()),
          RepositoryProvider<PopularCategoryRepository>(
              create: (context)=> PopularCategoryRepository()),
          RepositoryProvider<PopularProductRepository>(
              create: (context) => PopularProductRepository()),
          RepositoryProvider<ProductRepository>(
              create: (context) => ProductRepository()),
          RepositoryProvider<BrandRepository>(
              create: (context)=> BrandRepository()),
          RepositoryProvider<AuthenticationRepository>(
              create: (context)=> AuthenticationRepository()),
          RepositoryProvider<CartRepository>(
              create: (context)=> CartRepository()),


        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<LoginBloc>(create: (context) => LoginBloc(),),

            BlocProvider<SignUpBloc>(create: (context) => SignUpBloc(
              RepositoryProvider.of(context)
            )),
            BlocProvider<BannerBloc>(create: (context) => BannerBloc(
                RepositoryProvider.of<BannerRepository>(context))),
            BlocProvider<CategoryBloc>(create: (context) => CategoryBloc(
              RepositoryProvider.of(context)
            )),
            BlocProvider<PopularProductBloc>(create: (context) => PopularProductBloc(
              RepositoryProvider.of(context)
            )),
            BlocProvider(create: (context) => ProductBloc(
              RepositoryProvider.of(context)
            )),
            BlocProvider(create: (context) => TabBloc()),
            BlocProvider(create: (context)=> SearchBloc()),
            BlocProvider(create: (context)=> BrandBloc(
              RepositoryProvider.of(context)
            )),
            BlocProvider(create: (context) => AuthBloc(
                RepositoryProvider.of<AuthenticationRepository>(context))),
            BlocProvider(create: (context) => CartBloc(
                RepositoryProvider.of(context)))
          ],

          child:  MaterialApp(
            debugShowCheckedModeBanner: false,
            home: BottomBar()
          ),

        ))
    ;
  }

}