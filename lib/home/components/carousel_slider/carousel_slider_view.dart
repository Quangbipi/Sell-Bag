import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_login/home/components/carousel_slider/banner_card.dart';

import '../../../models/ad_banner.dart';

class CarouselSliderView extends StatefulWidget {
  final List<AdBanner> adBannerList;
  const CarouselSliderView({Key? key, required this.adBannerList}) : super(key: key);

  @override
  State<CarouselSliderView> createState() => _CarouselSliderViewState();
}

class _CarouselSliderViewState extends State<CarouselSliderView>{

  late List<Widget> _bannerList;

  int _curenIndex = 0;
  @override
  void initState() {

    _bannerList = widget.adBannerList.map((e) => BannerCard(imageUrl: e.image)).toList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
            items: _bannerList,
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 16/9,
              viewportFraction: 1,
              onPageChanged: (index,reason){
                setState(() {
                  _curenIndex=index;
                });
              }
            )),
       Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: List.generate(
             widget.adBannerList.length,
                 (index) => Container(
                   width: 8,
                   height: 8,
                   margin: EdgeInsets.all(2),
                   decoration: BoxDecoration(
                     shape: BoxShape.circle,
                     color: _curenIndex == index ? Colors.grey : Colors.grey.shade300
                   ),
                 )),
       )
      ],
    );
  }
}
