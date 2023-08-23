import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/bloc/theme_bloc.dart';
import 'package:flutter_login/event/theme_event.dart';
import 'package:flutter_login/sate/theme_state.dart';

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  //bool val = false;
  onChangeMethod(bool newVal){
    context.read<ThemeBloc>().add(ChangeTheme(isDark: newVal));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
        centerTitle: true,
        elevation: 0,

      ),
      body: Stack(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(26),
                            topLeft: Radius.circular(26))),
                    child: customSwitch('Dark mode', onChangeMethod)
                ),)
              ],
            )
      ]));
  }
}

Widget customSwitch (String text, Function onChangeMethod){
  return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context,state){
        return Padding(
          padding: EdgeInsets.only(top: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
              ),
              Spacer(),
              CupertinoSwitch(
                  trackColor: Colors.grey,
                  activeColor: Colors.blue,
                  value: state.isDark,
                  onChanged: (value){
                    print(value);
                    onChangeMethod(value);

                  })
            ],
          ),
        );
      });
}
