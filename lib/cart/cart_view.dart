import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/bloc/cart_bloc.dart';
import 'package:flutter_login/cart/component/cart_card.dart';
import 'package:flutter_login/event/cart_event.dart';
import 'package:flutter_login/models/cart.dart';
import 'package:flutter_login/models/product.dart';
import 'package:flutter_login/sate/cart_state.dart';
import 'package:flutter_login/services/local_auth_service.dart';

class CartView extends StatefulWidget {

  int userId;
  CartView({Key? key, required this.userId}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  double total = 0.0;
  LocalAuthService _authService = LocalAuthService();
  ButtonStyle myButtonStyle() {
    return ButtonStyle(

        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25)
        )),
        minimumSize: MaterialStateProperty.all<Size>(
          const Size(120, 50), // Chỉnh kích thước nút thành 120 chiều rộng và 40 chiều cao
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return Colors.white.withOpacity(0.04);
              }
              if (states.contains(MaterialState.focused) ||
                  states.contains(MaterialState.pressed)) {
                return Colors.white.withOpacity(0.12);
              }
              return null;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(builder: (context,state){
      if(state is GetCartSuccess){
        return Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text(
                'Cart',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),

          ),
          bottomNavigationBar: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      offset: const Offset(0, 1), // Điều chỉnh tọa độ đổ bóng theo chiều ngang và dọc
                      blurRadius: 6, // Điều chỉnh độ mờ của đổ bóng
                      spreadRadius: 2, // Điều chỉnh độ lan rộng của đổ bóng
                    ),
                  ]
              ),
              height: 100,
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Total: ',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                        ),
                      ),
                      Text("${state.cartList.where((cart) => cart.cartStatus == CartStatus.waiting)
                          .map((cart) => cart.product.tags.first.price * cart.productNumber).fold<double>(0, (a, b) => a + b)}",
                        style: const TextStyle(
                            fontSize: 24,
                            color: Colors.black
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: (){
                      print('click check out');
                      state.cartList.where((cart) => cart.cartStatus == CartStatus.waiting)
                          .forEach((cart) {
                        context.read<CartBloc>().add(ChangeCartStatusEvent(cart.id!, 'paid'));
                        context.
                        read<CartBloc>().
                        add(GetCartEvent(widget.userId));
                      });
                    },
                    child: const Text('Check out', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    style: myButtonStyle(),

                  ),
                ],
              )
          ),
          body: Stack(
            children: [
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.cartList.length,
                  itemBuilder: (context, index) => CartCard(cart: state.cartList[index],)),
            ],
          )
        );
      }else{
        return Container();
      }
    });
}
}
