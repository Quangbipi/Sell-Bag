import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/bloc/cart_bloc.dart';
import 'package:flutter_login/event/cart_event.dart';
import 'package:flutter_login/sate/cart_state.dart';
import 'package:flutter_login/services/local_auth_service.dart';
import 'package:shimmer/shimmer.dart';

import '../../const.dart';
import '../../models/cart.dart';

class CartCard extends StatefulWidget {
  final Cart cart;
  CartCard({Key? key, required this.cart}) : super(key: key);

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  LocalAuthService _authService = LocalAuthService();
  late bool valueSecond;
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print('object');
    return BlocListener<CartBloc, CartState>(
        listener: (context, state){

        },
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 18),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration:  BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade500,
                  offset: const Offset(0, 2), // Điều chỉnh tọa độ đổ bóng theo chiều ngang và dọc
                  blurRadius: 6, // Điều chỉnh độ mờ của đổ bóng
                  spreadRadius: 0, // Điều chỉnh độ lan rộng của đổ bóng
                ),

              ],
              borderRadius: BorderRadius.circular(12)
          ),
          height: 120,
          child: Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: CachedNetworkImage(
                  imageUrl: baseUrl + widget.cart.product.image.first,
                  placeholder: (context, url) =>  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.white,
                    child: Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        color: Colors.grey.shade300,

                      ),
                    ),
                  ),
                  errorWidget: (context, url, erro) => Center(
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20,),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: ${widget.cart.product.name}',style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),
                      maxLines: 1, ),
                    Text('Title: ${widget.cart.product.tags.first.title}',style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey
                    ),
                      maxLines: 1, ),
                    Text('Amount: ${widget.cart.productNumber}',style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey
                    ),
                      maxLines: 1, ),
                    Text('Price: \$${widget.cart.product.tags.first.price * widget.cart.productNumber}',style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey
                    ),
                      maxLines: 1, ),

                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      widget.cart.cartStatus == CartStatus.waiting || widget.cart.cartStatus == CartStatus.unpaid
                          ? Checkbox(
                        value: widget.cart.cartStatus == CartStatus.waiting ? true:false ,
                        onChanged: (value) {

                          if(value == true){
                            context.
                            read<CartBloc>().
                            add(ChangeCartStatusEvent(widget.cart.id!, 'waiting'));
                            context.
                            read<CartBloc>().
                            add(GetCartEvent(int.parse(_authService.getUser()!.id)));
                          }
                          if(value == false){
                            context.
                            read<CartBloc>().
                            add(ChangeCartStatusEvent(widget.cart.id!, 'unpaid'));
                            context.
                            read<CartBloc>().
                            add(GetCartEvent(int.parse(_authService.getUser()!.id)));
                          }
                        },
                      ): Text('Đã thanh toán', style: TextStyle(fontSize: 11, color: Colors.grey),),
                    ],
                  ),
                ),)
            ],
          ),
        ),
      )

        );
  }
}
