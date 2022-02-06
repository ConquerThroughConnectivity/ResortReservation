import 'package:ResortReservation/colors/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class UserController extends GetxController{

  
  var isResult ="".obs;
  var isPool ="".obs;
  final db = FirebaseFirestore.instance;
  var total = 0.obs;
  var isPrimary = <bool>[].obs;
  var isLoad =false.obs;
  var isUpdateProfile =false.obs;

  var email ="".obs;
  var password ="".obs;
  var firstname ="".obs;
  var lastname ="".obs;
  var finalDate =0.obs;
  var counter =0.obs;

  Rx<TextEditingController> dateFrom =TextEditingController().obs;
  Rx<TextEditingController> dateTo =TextEditingController().obs;

  TextEditingController stayIn =TextEditingController();
  TextEditingController persons =TextEditingController();

   final List<Map<String, dynamic>> items = [
    {
      'value': 'DayTour',
      'label': 'DayTour',
      'icon': Icon(Icons.tour),
      'textStyle': TextStyle(color: Colors.black54),
    },
    {
      'value': 'NightTour',
      'label': 'NightTour',
      'icon': Icon(Icons.tour_outlined),
      'textStyle': TextStyle(color: Colors.black54),
    },
    {
      'value': 'Overnight',
      'label': 'Overnight',
      'icon': Icon(Icons.nightlife),
      'textStyle': TextStyle(color: Colors.black54),
    },
  ];
  getCounter(int val){
    counter =val.obs;
    update();
  }

  getEmail(String val){
    email =val.obs;
    update();
  }

  getPassword(String val){
    password =val.obs;
    update();
  }

  getFirstname(String val){
    firstname =val.obs;
    update();
  }

  getLastname(String val){
    lastname =val.obs;
    update();
  }

  getDaysTotal(date1, date2){
     finalDate=date2.difference(date1).inDays;
     update();
  }


List<dynamic> amentiesAdd =[].obs;

 Map<String, dynamic> listreviews = Map<String, dynamic>().obs;
 List<Map<String, dynamic>> addReviews =<Map<String,dynamic>>[].obs;

removeAmenties(){
  amentiesAdd =[].obs;
  update();
}
addAmenties(String value){
  amentiesAdd.add(value);
  update();
}
Stream<QuerySnapshot<Object>> getResort1(String userID){
  return db.collection("Resorts").where("userID", isEqualTo: userID).snapshots();
}
Stream<QuerySnapshot<Object>> mybookings(String userID){
  return db.collection("Reservation").where("userID", isEqualTo: userID).snapshots();
}
Stream<QuerySnapshot<Object>> getResort(String resortID){
  return db.collection("Resorts").where("resortID", isEqualTo: resortID).snapshots();
}

updateFields({String email, String firstname, String lastname, String password, String userID}){
  isUpdateProfile =true.obs;
  update();
  var collection = FirebaseFirestore.instance.collection('Users');
  collection.doc(userID).update(
    {
    'email' : email,
    'firstname':firstname,
    'lastname':lastname,
    'password':password
    }) .then((_) {
          Get.snackbar("Profile Update", "Success", backgroundColor: AppColors.green, barBlur: 2.5,
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(20),
          colorText: Colors.white,
          dismissDirection: SnackDismissDirection.HORIZONTAL,
          snackPosition: SnackPosition.TOP);
    isUpdateProfile =false.obs;
    update();
    }).catchError((error){
    Get.snackbar("Warning", "Error!", backgroundColor: AppColors.cardRed,
       margin: EdgeInsets.all(15),
       padding: EdgeInsets.all(20),
       dismissDirection: SnackDismissDirection.HORIZONTAL,
       barBlur: 2.5, snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
       isUpdateProfile =false.obs;
       update();
    });
}

limitation({String total, String resortID}){
  isUpdateProfile =true.obs;
  update();
  var collection = FirebaseFirestore.instance.collection('Resorts');
  collection.doc(resortID).update(
    {
    'resortlimit' : total,
    }) .then((_) {
          Get.snackbar("Reserve Success", "Success", backgroundColor: AppColors.green, barBlur: 2.5,
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(20),
          colorText: Colors.white,
          dismissDirection: SnackDismissDirection.HORIZONTAL,
          snackPosition: SnackPosition.TOP);
    isUpdateProfile =false.obs;
    update();
    }).catchError((error){
    Get.snackbar("Warning", "Error!", backgroundColor: AppColors.cardRed,
       margin: EdgeInsets.all(15),
       padding: EdgeInsets.all(20),
       dismissDirection: SnackDismissDirection.HORIZONTAL,
       barBlur: 2.5, snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
       isUpdateProfile =false.obs;
       update();
    });
}



Future<void> book(String userID, List<dynamic> amenties,String total, String resortID, String resortname, String resortdetails, String dateFrom, String dateTo, String stay, String persons) async {
    isLoad =true.obs;
    update();
      final collRef = FirebaseFirestore.instance.collection('Reservation');
      DocumentReference users = collRef.doc();
    try {
      await users.set(({
        'total':total,
        'amenties':amenties,
        'userID':userID,      
        'reservationID':users.id,
        'resortID':resortID,
        'resortname':resortname,
        'resortdetails':resortdetails,
        'date-from':dateFrom,
        'date-to':dateTo,
        'persons':persons,
        'stay-in':stay,
        'Confirmation':false,
      })).then((value){
          Get.snackbar("Success", "Booking Success", backgroundColor: AppColors.green, barBlur: 2.5,
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(20),
          colorText: Colors.white,
          dismissDirection: SnackDismissDirection.HORIZONTAL,
          snackPosition: SnackPosition.TOP);
          isLoad =false.obs;
          update();
          // Get.offAndToNamed("/user");
        return;
      });
      
      
    } catch (e) {
      Get.snackbar(e, "Error!", backgroundColor: AppColors.cardRed,
       margin: EdgeInsets.all(15),
       padding: EdgeInsets.all(20),
       dismissDirection: SnackDismissDirection.HORIZONTAL,
       barBlur: 2.5, snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
     
    }
  }
  Future<void> review({String resortID, String comment, String rating, String userID}) async {
    isLoad =true.obs;
    update();
      final collRef = FirebaseFirestore.instance.collection('Reviews');
      DocumentReference users = collRef.doc();
    try {
      await users.set(({
        'rating':rating,
        'comment':comment,
        'userID':userID,
        'reviewID':users.id,
        'resortID':resortID,
      })).then((value){
          Get.snackbar("Review", "Thank you for the response", backgroundColor: AppColors.green, barBlur: 2.5,
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(20),
          colorText: Colors.white,
          dismissDirection: SnackDismissDirection.HORIZONTAL,
          snackPosition: SnackPosition.TOP);
          isLoad =false.obs;
          update();
          // Get.offAndToNamed("/user");
        return;
      });
      
      
    } catch (e) {
      Get.snackbar("Warning", "Error!", backgroundColor: AppColors.cardRed,
       margin: EdgeInsets.all(15),
       padding: EdgeInsets.all(20),
       dismissDirection: SnackDismissDirection.HORIZONTAL,
       barBlur: 2.5, snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
     
    }
  }

  Future<void> getReview({String resortID})async{
  print("ontap");
  CollectionReference col1 = FirebaseFirestore.instance.collection('Reviews');
  final list =await col1.get();
  for(int c =0;c<list.size;c++){
    // print("ReviewID: ${list.docs[c]['reviewID']}");
    // print("Comment ${list.docs[c]['comment']}");
  Query col=  db.collection("Users").where("userID", isEqualTo: list.docs[c]['userID']);

  QuerySnapshot co1=  await FirebaseFirestore.instance.collection("Resorts").get();
  final user =await col.get(); 
   final List<DocumentSnapshot> documents = co1.docs;
    if(documents[0]['userID'] ==list.docs[c]['resortID']){
       for(int z= 0;z<user.size;z++){
         
         listreviews ={
           "Firstname":user.docs[z]['firstname'],
           "Lastname":user.docs[z]['lastname'],
           "Comment":list.docs[c]['comment'],
           "Photo":user.docs[z]['photo'],
           "Rating":list.docs[c]['rating'],
         };  
         addReviews.add(listreviews);
      }
   }
  
  
  }


}


  isBookTrue(){
    isLoad =true.obs;
    update();
  }

  isBookFalse(){
    isLoad =false.obs;
    update();
  }

  isTotal(var num){
    total +=num;
    update();
  }

  reset(){
    total =0.obs;
    update();
  }

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

  setList({List<dynamic> amenties}){
    isPrimary = RxList.filled(amenties.length, false, growable: true);
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