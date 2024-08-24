// ignore_for_file: file_names, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/modals/product_modal.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/constant.dart';

class ProductDetailScreen extends StatelessWidget {
  ProductModal productModal;
  
  ProductDetailScreen({super.key, required this.productModal});
  var isFav = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.appTextColor,
      appBar: AppBar(
        elevation: 2,
        iconTheme: const IconThemeData(),
        title: Text("Product Detail",
            style: mainHeading(28, AppConstants.appTextColor)),
        backgroundColor: AppConstants.appMainColor,
      ),
      body: SizedBox(
        width: Get.width,
        child: Column(
          children: [
            //productSlider
            CarouselSlider(
                items: productModal.productImage
                    .map((imageUrls) => ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: CachedNetworkImage(
                            imageUrl: imageUrls,
                            alignment: Alignment.topCenter,
                            fit: BoxFit.cover,
                            width: Get.width - 10,
                            placeholder: (context, url) => const ColoredBox(
                              color: Colors.white,
                              child: Center(
                                child: CupertinoActivityIndicator(),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ))
                    .toList(),
                options: CarouselOptions(
                    scrollDirection: Axis.horizontal,
                    autoPlay: true,
                    viewportFraction: 1,
                    height: Get.height * 0.3,
                    scrollPhysics: const ScrollPhysics())),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SizedBox(
                width: Get.width,
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(50),bottomRight: Radius.circular(20),bottomLeft: Radius.circular(10)),side: BorderSide(width: 3,color: AppConstants.appMainColor)
                  ),
                  color: AppConstants.appTextColor,
                  elevation: 1,
                  shadowColor: AppConstants.appMainColor,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(productModal.productName,
                                  style: mainHeading(28, AppConstants.appMainColor,
                                      fontweight: FontWeight.w600)),
                              const Icon(
                                Icons.favorite,
                                color: AppConstants.appErrorColor,
                              )
                            ],
                          ),
                          const Divider(
                            height: 10,
                            thickness: 2,
                            color: AppConstants.appMainColor,
                          ),
                          Text("Category Name: ${productModal.catName}",
                            style: mainHeading(
                              20,
                              AppConstants.appMainColor,fontweight: FontWeight.w500
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 10.0,),
                          Text(
                            productModal.productDescription,
                            style: tittle(
                              14,
                              AppConstants.appMainColor,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              productModal.isSale == true
                                  ? Row(
                                      children: [
                                        Text(
                                          "Rs ${productModal.productPrice}",
                                          style: mainHeading(
                                              24, AppConstants.appErrorColor,
                                              decoration: TextDecoration.lineThrough,
                                              dcolor: AppConstants.appErrorColor),
                                          textAlign: TextAlign.left,
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        Text("Rs ${productModal.productSalePrice}"
                                          ,
                                          style: mainHeading(
                                            24,
                                            AppConstants.appMainColor,
                                            fontweight: FontWeight.w600
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    )
                                  : Text("Rs ${productModal.productPrice}"
                                      ,
                                      style: mainHeading(
                                        24,
                                        AppConstants.appMainColor,fontweight: FontWeight.w600
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                SizedBox(
                                width: Get.width * 0.45,
                                height: Get.height / 20,
                                child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        backgroundColor: AppConstants.appMainColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        side: const BorderSide(
                                            style: BorderStyle.none)),
                                    onPressed: () {
                                      
                                    },
                                    child: Row(
                                      mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                                      children: [
                                        Text(
                                          "Add To Cart",
                                          style: mainHeading(
                                              20, AppConstants.appTextColor),
                                        ),
                                        const Icon(Icons.add_shopping_cart_outlined,color: AppConstants.appTextColor,)
                                      ],
                                    )),
                              )    
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
