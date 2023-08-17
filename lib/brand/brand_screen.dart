import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/bloc/brand_bloc.dart';
import 'package:flutter_login/brand/components/brand_card.dart';
import 'package:flutter_login/brand/components/brands_loading_card.dart';
import 'package:flutter_login/event/brand_event.dart';
import 'package:flutter_login/sate/brand_state.dart';

import '../const.dart';

class BrandScreen extends StatefulWidget {
  const BrandScreen({Key? key}) : super(key: key);

  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {

  @override
  void initState() {
    context.read<BrandBloc>().add(LoadBrandEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandBloc, BrandState>(builder: (context,state){
      if(state is BrandLoaded){
        return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: state.categoryList.length,
            itemBuilder: (context, index) =>
                BrandCard(category: state.categoryList[index])
        );
      }else{
        return ListView.builder(
            itemCount: 9,
            itemBuilder: (context, index) =>
              BrandLoadingCard()
            );
      }
    });
  }
}
