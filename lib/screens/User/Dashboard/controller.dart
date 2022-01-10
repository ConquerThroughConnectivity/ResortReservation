import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class UserController extends GetxController{

  
  var isResult ="".obs;
  var isPool ="".obs;
  final db = FirebaseFirestore.instance;

   Stream<QuerySnapshot<Object>> searchBeach(){
    return db.collection("Resorts").where("resortname", isGreaterThanOrEqualTo: isResult.value.toString()).where("resortname", isLessThan: isResult.value.toString()+'z').snapshots();
  }
  Stream<QuerySnapshot<Object>> searchPool(){
    return db.collection("Resorts").where("resortname", isGreaterThanOrEqualTo: isPool.value.toString()).where("resortname", isLessThan: isPool.value.toString()+'z').snapshots();
  }

  resultPool(String val){
    isPool =val.obs;
    update();
  }


  result(String val){
    isResult =val.obs;
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  
}