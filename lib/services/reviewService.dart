// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../modals/reviewModel.dart';
import '../utils/constant.dart';

Widget reviewWidget(String productId) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'Reviews',
        style: mainHeading(32, AppConstants.appMainColor),
      ),
      const Divider(
        thickness: 2,
        color: AppConstants.appMainColor,
        height: 2,
      ),
      Flexible(
        fit: FlexFit.tight,
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("reviews")
                .where('productId', isEqualTo: productId)
                .orderBy('rate')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                    "No Review Found",
                    style: tittle(20, AppConstants.appErrorColor),
                  ),
                );
              }
              if (snapshot.data != null) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final reviewdata = snapshot.data!.docs[index];
                      Reviewmodel reviewmodel = Reviewmodel(
                          reviewId: reviewdata['reviewId'],
                          rate: reviewdata['rate'],
                          productId: reviewdata['productId'],
                          feedback: reviewdata['feedback'],
                          productName: reviewdata['productName'],
                          customerName: reviewdata['customerName'],
                          createdAt: reviewdata['createdAt']);
                      return Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: AppConstants.appSecondryColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          leading: Container(
                              width: 60,
                              height: 60,
                              alignment: const Alignment(0, -1.5),
                              decoration: BoxDecoration(
                                color: AppConstants.appTextColor,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Text(
                                reviewmodel.customerName[0],
                                style: tittle(38, AppConstants.appSecondryColor),
                              )),
                          title: Text(
                            reviewmodel.feedback,
                            style: tittle(20, AppConstants.appTextColor),
                          ),
                          subtitle: Text(
                            reviewmodel.customerName.toUpperCase(),
                            style: tittle(12, AppConstants.appTextColor,
                                fontweight: FontWeight.bold),
                          ),
                          trailing: Text(
                            reviewmodel.rate.toString(),
                            style: tittle(28, AppConstants.appTextColor,
                                fontweight: FontWeight.bold),
                          ),
                        ),
                      );
                    });
              }
              return const Text("data");
            }),
      ),
    ],
  );
}
