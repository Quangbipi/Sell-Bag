import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/bloc/bloc_observer.dart';
import 'package:flutter_login/firebase_options.dart';
import 'package:flutter_login/models/ad_banner.dart';
import 'package:flutter_login/models/product.dart';
import 'package:flutter_login/models/tag.dart';
import 'package:flutter_login/models/user_model.dart';
import 'package:flutter_login/utilies/validation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';
import 'models/category.dart';

Future<void>  main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new PostHttpOverrides();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  await Hive.initFlutter();
  Bloc.observer =LoginObserver();

  Hive.registerAdapter(AdBannerAdapter());
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(TagAdapter());
  Hive.registerAdapter(UserModelAdapter());
  runApp(MyApp());
}

class PostHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}