
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/bloc/banner_bloc.dart';
import 'package:flutter_login/bloc/category_bloc.dart';
import 'package:flutter_login/bloc/popular_product_bloc.dart';
import 'package:flutter_login/components/banner.dart';
import 'package:flutter_login/components/main_header.dart';
import 'package:flutter_login/event/banner_event.dart';
import 'package:flutter_login/event/category_event.dart';
import 'package:flutter_login/event/popular_product_event.dart';
import 'package:flutter_login/event/product_event.dart';
import 'package:flutter_login/home/components/carousel_slider/carousel_slider_view.dart';
import 'package:flutter_login/home/components/popular_category/popular_category_loading_card.dart';
import 'package:flutter_login/home/components/popular_product/popular_product_loading.dart';
import 'package:flutter_login/sate/popular_product_state.dart';
import 'package:flutter_login/services/local_ad_banner_service.dart';
import 'package:flutter_login/sate/banner_state.dart';
import 'package:flutter_login/sate/category_state.dart';
import 'package:flutter_login/sate/product_state.dart';
import 'package:flutter_login/services/local_brand_service.dart';
import 'package:flutter_login/services/local_product_service.dart';

import 'home/components/popular_category/popular_category.dart';
import 'home/components/popular_category/popular_category_loading.dart';
import 'home/components/popular_product/popular_product.dart';
import 'home/components/section_title.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final LocalAdBannerService _localAdBannerService = LocalAdBannerService();
  final LocalBrandService _localBrandService = LocalBrandService();
  final LocalProductService _localProductService = LocalProductService();

  @override
  void initState(){
    context.read<BannerBloc>().add(LoadBannerEvent());
    context.read<CategoryBloc>().add(LoadCategoryEvent());
    context.read<PopularProductBloc>().add(LoadPopularProductEvent());
    _localAdBannerService.init();
    _localBrandService.init();
    _localProductService.init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(

          body: Column(
            children: [
              MainHeader(),
              Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        BlocBuilder<BannerBloc, BannerState>(
                            builder: (context, state){
                              if(state is BannerLoaded){
                                return CarouselSliderView(adBannerList: state.bannerList);
                              }else if(state is BannerLoading){

                                return const BannerView();
                              }else{
                                return const BannerView();
                              }
                            }
                        ),
                        SectionTitle(title: 'Brand', check: 0,),
                        BlocBuilder<CategoryBloc, CategoryState>(
                            builder: (context, state){
                              if(state is CategoryLoaded){
                                return PopularCategory(categories: state.categoryList,);
                              }else{
                                return const PopularCategoryLoading();
                              }
                            }),
                        SectionTitle(title: 'Popular product', check: 1,),
                        BlocBuilder<PopularProductBloc, PopularProductState>(
                            builder: (context,state){
                              if(state is PopularProductLoaded) {
                                return PopularProduct(productList: state.productList,);
                              }else {
                                return const PopularProductLoadingView();
                              }
                            })
                      ],
                    ),
                  )
              ),

            ],
          ),
        )
    );
  }
}




