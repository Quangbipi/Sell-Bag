import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About us'),
        centerTitle: true,
      ),
      body: Text("  Hana Store is an online shopping application, "
          "helping you to search and buy yourself the best handbags from famous brands. \n   "
          "Currently our application is only in the early stages of development, we will try to develop more and give you the best experience.",
          style: TextStyle(
            fontSize: 18,

          ),
      ),
    );
  }
}
