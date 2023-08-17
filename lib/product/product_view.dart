import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/bloc/product_bloc.dart';

import 'package:flutter_login/components/main_header.dart';
import 'package:flutter_login/event/product_event.dart';
import 'package:flutter_login/sate/product_state.dart';

import '../const.dart';
import 'component/product_grid.dart';
import 'component/product_loading_grid.dart';

class ProductView extends StatefulWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {


  @override
  void initState() {
    print(isSearching);
    if(isSearching == false){
      context.read<ProductBloc>().add(LoadProductEvent());
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          children: [
            MainHeader(),
            Expanded(
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context,state){
                    if(state is SearchProductComplete ){
                      isSearching = false;
                      return ProductGrid(products: state.products);
                    }
                    else if(state is ProductLoaded ) {
                      return ProductGrid(products: state.productList);
                    }else if(state is SearchProductError){
                      isSearching = false;
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline, size: 64, color: Colors.redAccent,),
                            SizedBox(height: 10,),
                            Text("Product not found!", style: TextStyle(color: Colors.redAccent),),
                          ],
                        )
                      );
                    }else{
                      return ProductLoadingGrid();
                    }
                  },
                ))
          ],
        ));
  }
}
