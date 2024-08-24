// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class GetuserdataController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<QueryDocumentSnapshot<Object?>>> getData(String uId) async {
    final QuerySnapshot userData =
        await _firestore.collection("users").where("uId", isEqualTo: uId).get();
    return userData.docs;
  }
}
