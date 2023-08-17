import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/bloc/cart_bloc.dart';
import 'package:flutter_login/const.dart';
import 'package:flutter_login/event/cart_event.dart';
import 'package:flutter_login/event/tab_event.dart';

import 'package:flutter_login/home.dart';
import 'package:flutter_login/product/product_view.dart';
import 'package:flutter_login/profile/profile_screen.dart';
import 'package:flutter_login/sate/tab_state.dart';
import 'package:flutter_login/services/local_auth_service.dart';

import 'bloc/tab_bloc.dart';
import 'brand/brand_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  //int _selectIndex = 0;
  final LocalAuthService _authService = LocalAuthService();

  static final List<Widget> _widgetOption = <Widget>[
    Home(),
    ProductView(),
    BrandScreen(),
    ProfileScreen(),
  ];

  void _onTapIcon(int index){
    // setState(() {
    //   _selectIndex = index;
    // });
    context.read<TabBloc>().add(TabChange(indextInput: index));
  }

  @override
  void initState() {
    _authService.init();


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, TabState>(
        builder: (context, state){
          return Scaffold(
            body: Center(
                child: _widgetOption[state.index]
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.index,
              elevation: 10,
              onTap: _onTapIcon,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: Colors.blueGrey,
              unselectedItemColor: Colors.blueGrey.shade200,
              iconSize: 30,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home_outlined),
                    activeIcon: Icon(Icons.home_filled),
                    label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.category_outlined),
                    activeIcon: Icon(Icons.category),
                    label: "Category"),
                BottomNavigationBarItem(icon: Icon(Icons.menu_outlined),
                    activeIcon: Icon(Icons.menu_rounded),
                    label: "Brand"),
                BottomNavigationBarItem(icon: Icon(Icons.person_outline),
                    activeIcon: Icon(Icons.person),
                    label: "Profile"),
              ],
            ),
          );

    });
  }
}
