// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/modals/category_modal.dart';
import 'package:ecommerce_app/screens/user-panel/single-Category-productScreen.dart';
import 'package:ecommerce_app/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection("categories").limit(8).get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error",
                style: tittle(20, AppConstants.appErrorColor),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: Get.height / 5,
              child: const Center(
                child: CupertinoActivityIndicator(
                  color: AppConstants.appyellowColor,
                ),
              ),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "No Categories Found",
                style: tittle(20, AppConstants.appErrorColor),
              ),
            );
          }
          if (snapshot.data != null) {
           return SizedBox(
              height: Get.height /5,
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    CategoryModal categoryModal = CategoryModal(
                        catId: snapshot.data!.docs[index]['catId'],
                        catImage: snapshot.data!.docs[index]['catImage'],
                        catName: snapshot.data!.docs[index]['catName'],
                        createAt: snapshot.data!.docs[index]['createAt'],
                        updatedAt: snapshot.data!.docs[index]['updatedAt']);
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: ()=>Get.to(SingleCategoryProductScreen(catId: categoryModal.catId, catName: categoryModal.catName)),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: FillImageCard(
                              tagRunSpacing: 0.0,
                              tagSpacing:0.0 ,
                              color: AppConstants.appSecondryColor,
                              borderRadius: 10.0,
                              
                              width: Get.width/4.0,
                              heightImage: Get.height/9,
                              imageProvider: CachedNetworkImageProvider(categoryModal.catImage,),
                              title: Center(child: Text(categoryModal.catName,style: mainHeading(18, AppConstants.appTextColor,fontweight: FontWeight.w600),overflow: TextOverflow.ellipsis,)),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            );
          }
          return const Text("data");
        });
  }
}
