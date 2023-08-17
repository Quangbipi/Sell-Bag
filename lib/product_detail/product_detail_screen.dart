import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/bloc/cart_bloc.dart';
import 'package:flutter_login/event/cart_event.dart';
import 'package:flutter_login/login_page.dart';
import 'package:flutter_login/product_detail/component/product_carousel_slider.dart';
import 'package:flutter_login/sate/cart_state.dart';
import 'package:flutter_login/services/local_auth_service.dart';
import 'package:intl/intl.dart';

import '../const.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  final LocalAuthService _authService = LocalAuthService();
  ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  NumberFormat numberFormat = NumberFormat('00');
  int _qty = 1;
  final LocalAuthService _authService = LocalAuthService();
  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
        listener: (context, state){
          if(state is AddToCartSuccess){
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('success'),
                ));
            context.read<CartBloc>().add(GetCartEvent(int.parse(_authService.getUser()!.id)));
          }
        },
        child: SafeArea(
          child: Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductCarouselSlider(images: widget.product.image),
                const SizedBox(height: 10,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    widget.product.name,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),
                  ),

                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '\$ ${widget.product.tags.first.price.toString()}',
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black
                    ),
                  ),

                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10))

                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: (){
                                setState(() {
                                  if(_qty>1){
                                    _qty--;
                                  }
                                });
                              },
                              child: const Icon(
                                Icons.keyboard_arrow_left,
                                size: 32,
                              ),
                            ),
                            Text(
                              numberFormat.format(_qty),
                              style: const TextStyle(
                                  fontSize: 18
                              ),),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  _qty++;
                                });
                              },
                              child: const Icon(
                                Icons.keyboard_arrow_right,
                                size: 32,
                              ),
                            )
                          ],
                        ),

                      )
                    ],
                  ),

                ),
                const SizedBox(height: 10,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'About this product: ',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    widget.product.description,
                    style:const TextStyle(
                      fontSize: 16,
                      color: Colors.black,

                    ),
                  ),

                ),
              ],
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state){
                    return TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).primaryColor
                        ),

                      ),
                      onPressed: (){
                        if(isLogin == true){
                          context.read<CartBloc>().add(
                              AddToCartEvent(
                                  userId: int.parse(widget._authService.getUser()!.id),
                                  productId: widget.product.id,
                                  productNumber: _qty,

                              ));


                        }else{
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()));
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: Text(
                          'Add to Cart',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  }

              ),
            ),
          ),
        ),
        );
  }
}
