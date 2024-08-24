// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/controllers/banner_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBanner extends StatelessWidget {
  CustomBanner({super.key});
  final CarouselSliderController carouselSliderController =
      CarouselSliderController();
  final BannerController bannerController = Get.put(BannerController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CarouselSlider(
    
          items: bannerController.bannerUrls.map((imageUrls) => ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: CachedNetworkImage(imageUrl: imageUrls,fit: BoxFit.cover,width: Get.width-10,placeholder: (context,url)=>const ColoredBox(color: Colors.white,child: Center(child: CupertinoActivityIndicator(),),),
                errorWidget: (context, url, error) => const Icon(Icons.error),),             
              )).toList(),
          options: CarouselOptions(
            scrollDirection: Axis.horizontal,
            autoPlay: true,
            aspectRatio: 2,
            viewportFraction: 1,
            height: Get.height*0.25,
            scrollPhysics: const ScrollPhysics()
          ));
    });
  }
}
