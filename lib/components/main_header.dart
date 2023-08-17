import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/bloc/auth_bloc.dart';
import 'package:flutter_login/bloc/cart_bloc.dart';
import 'package:flutter_login/bloc/product_bloc.dart';
import 'package:flutter_login/bloc/search_bloc.dart';
import 'package:flutter_login/cart/cart_view.dart';
import 'package:flutter_login/event/cart_event.dart';
import 'package:flutter_login/event/product_event.dart';
import 'package:flutter_login/event/search_event.dart';
import 'package:flutter_login/event/tab_event.dart';
import 'package:flutter_login/sate/auth_state.dart';
import 'package:flutter_login/sate/cart_state.dart';
import 'package:flutter_login/sate/login_sate.dart';
import 'package:flutter_login/sate/product_state.dart';
import 'package:flutter_login/sate/search_state.dart';
import 'package:flutter_login/services/local_auth_service.dart';

import '../bloc/tab_bloc.dart';
import '../const.dart';

class MainHeader extends StatelessWidget {
  String _searchInput = "";
  TextEditingController _searchController = TextEditingController();
  final LocalAuthService _authService = LocalAuthService();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          // if (state.loginStatus == LoginStatus.success) {
          //   context
          //       .read<CartBloc>()
          //       .add(GetCartEvent(int.parse(_authService.getUser()!.id)));
          // }
        },
        child: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 10,
            )
          ]),
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 2,
                              blurRadius: 5,
                            )
                          ]),
                      child: BlocBuilder<SearchBloc, SearchState>(
                        builder: (context, state) {
                          return TextField(
                            controller: _searchController,
                            onSubmitted: (val) async {
                              isSearching = true;
                              context
                                  .read<ProductBloc>()
                                  .add(SearchProduct(val));
                              context
                                  .read<TabBloc>()
                                  .add(TabChange(indextInput: 1));
                              print(state.input);
                              _searchController.text = state.input;
                            },
                            decoration: InputDecoration(
                                prefixIcon: const Icon(
                                    FluentSystemIcons.ic_fluent_search_filled),
                                hintText: "Tìm kiếm",
                                border: const UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      _searchController.text = "";
                                    },
                                    icon: const Icon(Icons.clear))),
                            onChanged: (value) {
                              //context.read<TabBloc>().add(TabChange(indextInput: 1));
                              context
                                  .read<ProductBloc>()
                                  .add(SearchProduct(value));
                              context
                                  .read<SearchBloc>()
                                  .add(SearchInputChange(value));
                              _searchInput = state.input;
                            },
                          );
                        },
                      ))),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        blurRadius: 8,
                      )
                    ]),
                padding: EdgeInsets.all(12),
                child: Icon(FluentSystemIcons.ic_fluent_filter_filled),
              ),
              SizedBox(
                width: 10,
              ),
              BlocBuilder<CartBloc, CartState>(builder: (context, state) {
                return InkWell(
                  onTap: () {
                    print(isLogin);
                    if (isLogin == true ) {
                      context
                          .read<CartBloc>()
                          .add(GetCartEvent(int.parse(_authService.getUser()!.id)));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CartView()));
                    }
                  },
                  child: Stack(
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                blurRadius: 8,
                              )
                            ]),
                        padding: EdgeInsets.all(12),
                        child: Icon(Icons.shopping_cart),
                      ),
                      Positioned(
                          top: 4,
                          left: 4,
                          child: Visibility(
                              visible: isLogin,
                              child: Container(
                                width: 14,
                                height: 14,
                                alignment: AlignmentDirectional.center,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.4),
                                        blurRadius: 8,
                                      )
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Column(
                                    children: [
                                      if (state is GetCartSuccess)
                                        Text(
                                          state.cartList.length.toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10),
                                        )
                                    ],
                                  ),
                                ),
                              )))
                    ],
                  ),
                );
              })
            ],
          ),
        ));
  }
}
