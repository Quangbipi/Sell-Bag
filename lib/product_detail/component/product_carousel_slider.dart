import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/product_detail/component/product_carousel_card.dart';
import 'package:shimmer/shimmer.dart';

import '../../const.dart';

class ProductCarouselSlider extends StatefulWidget {
  final List<String> images;
  const ProductCarouselSlider({Key? key,  required this.images}) : super(key: key);

  @override
  State<ProductCarouselSlider> createState() => _ProductCarouselSliderState();
}

class _ProductCarouselSliderState extends State<ProductCarouselSlider> {
  int _currentIndex = 0;
  late List<Widget>  _productImageList;
  @override
  void initState() {

    _productImageList = widget.images.map((e) => ProductCarouselCard(image: e,)).toList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: CarouselSlider(
                  items: _productImageList,
                  options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: true,
                      aspectRatio: 16/9,
                      viewportFraction: 1,
                      onPageChanged: (index,reason){
                        setState(() {
                          _currentIndex=index;
                        });
                      }
                  )),
            ),
            Positioned(
                child: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                ),

            )
          ],
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              widget.images.length,
                  (index) => Container(
                    width: 8,
                    height: 8,
                    margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentIndex == index ? Colors.grey : Colors.grey.shade300
                    ),
                  )),

        )

      ],
    );
  }
}

