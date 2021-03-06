import 'dart:io';

import 'package:ResortReservation/colors/colors.dart';
import 'package:ResortReservation/colors/icons.dart';
import 'package:ResortReservation/screens/Admin/Resort%20Admin%20Dashboard/Profile.dart';
import 'package:ResortReservation/screens/Admin/Resort%20Admin%20Dashboard/Reservation.dart';
import 'package:ResortReservation/screens/Admin/view.dart';
import 'package:ResortReservation/screens/User/StorageService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AdminController extends GetxController {
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;
  
  final db = FirebaseFirestore.instance;
  final db1 = FirebaseFirestore.instance;
  var issearch ="".obs;

  final GlobalKey<FormState> adminkey = GlobalKey<FormState>();
  final GlobalKey<FormState> resortkey = GlobalKey<FormState>();
  final isLoop = 3.obs;
  var isSaved = false.obs;
  var isResortLogin = false.obs;
  Rx<String> resorT ="".obs;
  List<TextEditingController> shabu = [];
  List<Widget> controllers = [];

  List<String> amenities = <String>[].obs;

  Map<String, dynamic> classics = Map<String, dynamic>().obs;
  List<Map<String, dynamic>> amend =<Map<String,dynamic>>[];
  List<Map<String, dynamic>> amendamenties =<Map<String,dynamic>>[].obs;

  List<XFile> images = <XFile>[].obs;
  List<String> downloadUrls = <String>[].obs;
  List<DropdownMenuItem<dynamic>> itemsuck = <DropdownMenuItem<dynamic>>[].obs;

  final pagecontroller = PageController();
  final selectedImage = 0.obs;


  TextEditingController title = new TextEditingController();
  TextEditingController description = new TextEditingController();
  TextEditingController price = new TextEditingController();
  TextEditingController quantity = new TextEditingController();

  TextEditingController resortname = new TextEditingController();
  TextEditingController resortaddress = new TextEditingController();
  TextEditingController resortcontact = new TextEditingController();
  TextEditingController resorttype = new TextEditingController();
  TextEditingController entrancefee = new TextEditingController();
  TextEditingController limitations = new TextEditingController();

  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController firstname = new TextEditingController();
  TextEditingController lastname = new TextEditingController();
  TextEditingController resort = new TextEditingController();
  TextEditingController resortdetails = new TextEditingController();
  TextEditingController searchResort = new TextEditingController();

  FirebaseFirestore firestore;
  @override
  void onInit() {
    super.onInit();
    firestore = FirebaseFirestore.instance;
    getResort();
  }
  final List<Map<String, dynamic>> items = [
    {
      'value': 'Beach',
      'label': 'Beach',
      'icon': Icon(Icons.beach_access_outlined),
      'textStyle': TextStyle(color: Colors.black54),
    },
    {
      'value': 'Pool',
      'label': 'Pool',
      'icon': Icon(Icons.pool),
      'textStyle': TextStyle(color: Colors.black54),
    },
  ];
  void pickImages() async {
    try {
      final selectedImage = await ImagePicker().pickMultiImage();
      selectedImage.map((e) => images.add(e)).toList();
      print("Soledad ${images.map((e) => e.path).toList()}");
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  void getResortName(String value)async{
    resorT =value.obs;
    update();
  }

  // isonTop
  void isonTop() {
    TextEditingController chuy = TextEditingController();
    shabu.add(chuy);
    for (int c = 0; c < shabu.length; c++) {}
  }

  changedText(String resort){
    issearch =resort.obs;         
    update();
  }
  Stream<QuerySnapshot<Object>> findResort(){
    if(issearch.value!=null || issearch.value!=""){
      return db.collection("Resorts").where("resortname", isGreaterThanOrEqualTo: issearch.value).where("resortname", isLessThan: issearch.value +'z').snapshots();
    }else{
      return db.collection("Resorts").snapshots();
    }
  }
  



  Stream<QuerySnapshot<Object>> resortadminfields(String userID){
    return db1.collection("Resorts").where("resortname", isEqualTo: userID).snapshots();
  }

  Future<void> addResort() async {
    isSaved = true.obs;
    update();
    try {
      final collRef = FirebaseFirestore.instance.collection('Resorts');
      DocumentReference insert = collRef.doc();
      firebase_storage.Reference ref;
      int i = 0;
      for (var img in images) {
        ref = firebase_storage.FirebaseStorage.instance.ref().child('files/${img.path}');
        await ref.putFile(File(img.path)).whenComplete(() async {
          await ref.getDownloadURL().then((value) {
            downloadUrls.addAll([value]);
            i++;
          });
        });
      }

      if (downloadUrls != null) {
        List<String> addAmenties = <String>[];
        for (int c = 0; c < amenities.length; c++) {
          addAmenties.addAll([amenities[c]]);
        }
        
        await insert
            .set(({
          'resortname': resortname.text,
          'resortaddress': resortaddress.text,
          'resortcontact': resortcontact.text,
          'resortentrancefee': entrancefee.text,
          'resorttype': resorttype.text,
          'resortphoto': downloadUrls,
          'resortamenties': amendamenties,
          'resortlimit':limitations.text,
          'resortdetails':resortdetails.text,
          'userID': insert.id,
        }))
          .then((value) {
          Get.snackbar("Success", "Resort Saved Succesful",
              backgroundColor: AppColors.cardLightMaroon,
              barBlur: 2.5,
              snackPosition: SnackPosition.BOTTOM);
          isSaved = false.obs;
          update();
          resortname.clear();
          resortaddress.clear();
          resortcontact.clear();
          resorttype.clear();
          entrancefee.clear();
          resortname.clear();
          resortdetails.clear();
          amendamenties.clear();
          amenities.clear();
          images.clear();
          downloadUrls.clear();
          Get.to(() => Home());

          return;
        });
        isSaved = false.obs;
        update();
      }
    } catch (e) {
      Get.snackbar("Warning", "Error! $e",
          backgroundColor: AppColors.cardGreyDark,
          barBlur: 2.5,
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white);
      isSaved = false.obs;
      update();
    }
  }
  Future<void> resortAdminSignup() async {
    isResortLogin = true.obs;
    update();

    try {
      // UploadTask task;
      // task =FirebaseFileStore.uploadFile('files/$selectedImagePath', File(selectedImagePath.value));

      final collRef = FirebaseFirestore.instance.collection('Users');
      DocumentReference users = collRef.doc();

      // if(task ==null){
      //   return;
      // }
      // final snapshot =await task.whenComplete(() {
      //   isResortLogin=false.obs;
      //   update();
      // });
      // final urlDownload =await snapshot.ref.getDownloadURL();
      await users
          .set(({
        'email': username.text,
        'password': password.text,
        'firstname': firstname.text,
        'lastname': lastname.text,
        'tags': "resortadmin#",
        // 'photo':urlDownload,
        'resortName': resorT.value.toString(),
        'userID': users.id
      }))
          .then((value) {
        Get.snackbar("Success", "Resort Admin add Sucess",
        backgroundColor: AppColors.cardLightMaroon,
        barBlur: 2.5,
        snackPosition: SnackPosition.BOTTOM);
        username.clear();
        password.clear();
        firstname.clear();
        lastname.clear();
        selectedImagePath = ''.obs;
        isResortLogin = false.obs;
        update();
        resortname.clear();
        Get.offAndToNamed('/home');
        return;
      });
    } catch (e) {
      Get.snackbar("Warning", "Error!",
          backgroundColor: AppColors.cardGreyDark,
          barBlur: 2.5,
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white);
      isResortLogin = false.obs;
      
    }
  }
  Future<void> checkDuplicate(String resortname) async {
    try {
      await FirebaseFirestore.instance
          .collection("Resorts")
          .where("resortname", isEqualTo: resortname)
          .get()
          .then((value) {
        if (value.size > 0) {
          Get.snackbar("Warning", "Resortname Already Used please use another",
              backgroundColor: AppColors.cardGreyDark,
              barBlur: 2.5,
              colorText: Colors.white);
        } else {
          addResort();
        }
      });
    } catch (e) {}
  }
  Future<void> getResort() async {
    try {
      CollectionReference col1 =FirebaseFirestore.instance.collection('Resorts');
      final list = await col1.get();
      for (int c = 0; c < list.size; c++) {
        List<DropdownMenuItem<dynamic>> itemss = [

          DropdownMenuItem(
            value: list.docs[c]['resortname'],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  Text(list.docs[c]['resortname'], style: TextStyle(
                    fontFamily: 'SFS',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),),
                 list.docs[c]['resorttype'] =="Pool"? Icon(Icons.pool):Icon(Icons.beach_access_outlined),
              ],
              
            )),
        ];
        itemsuck.addAll(itemss);
      }
      for (int z = 0; z < itemsuck.length; z++) {
        print(itemsuck[z]);
      }
    } catch (e) {
      print(e);
    }
  }
  showAlertDialog(BuildContext context){
    // set up the button
    Widget okButton = TextButton(
      child: Text("Save"),
      onPressed: ()async {
        String concat ="\n Title: ${title.text} \n Description: ${description.text} \n Price: ${price.text}";
        List<String> add = [concat];

       try{
        UploadTask task;
        task =FirebaseFileStore.uploadFile('files/$selectedImagePath', File(selectedImagePath.value));
        amenities.addAll(add);
         if(task ==null){
          return;
          }
        final snapshots =await task.whenComplete(() {
        });
        final urlDownload =await snapshots.ref.getDownloadURL();
        
        classics = {
          "Title": title.text,
          "Description": description.text,
          "Price": price.text,
          "Photo":urlDownload,
        };

        amendamenties.add(classics);
        print(amendamenties);
        Navigator.pop(context);

       }catch(e){
         print(e);
       }
        
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Center(
        child: Row(
          children: [
            Text(
              "Amenities",
              style: TextStyle(
                  fontFamily: 'SFS',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
            SizedBox(
              height: 15,
            ),
            Image.asset(
              AppIcons.amenities,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
      content: Container(
        height: 600,
        child: Column(
          children: [
            Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                elevation: 3.0,
                child: TextFormField(
                  
                    maxLines: 2,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Cannot Be Empty";
                      }
                    },
                    controller: title,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      labelText: "Title",
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.title, color: Colors.blue),
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ))),
            SizedBox(
              height: 20,
            ),
            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                elevation: 3.0,
                child: TextFormField(
                   
                    maxLines: 5,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Cannot Be Empty";
                      }
                    },
                    controller: description,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      labelText: "Description",
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.description, color: Colors.blue),
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ))),
            SizedBox(
              height: 20,
            ),
            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                elevation: 3.0,
                child: TextFormField(
                    keyboardType: TextInputType.number,
                   
                    maxLines: 1,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Cannot Be Empty";
                      }
                    },
                    controller: price,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      labelText: "Price",
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.price_check_outlined,
                            color: Colors.blue),
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ))),
                    SizedBox(height: 20,),
                    InkWell(
                          onTap: () {
                                getImage(ImageSource.gallery, context);
                          },
                          child: Center(
                            child: Obx(() =>selectedImagePath.value == ''? Image.asset(AppIcons.addImage,
                                              fit: BoxFit.cover,
                                              height: 50,
                                              width: 50)
                                          : Container(
                                              height: 150,
                                              width: 150,
                                              
                                              child: ClipRRect(
                                                
                                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                                child: Image.file(
                                                  File(selectedImagePath.value),
                                                  fit: BoxFit.cover,
                                                  filterQuality: FilterQuality.high,
                                                ),
                                              ),
                                            )))),
                // Expanded(
                  
                //   child: Card(
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.all(Radius.circular(10))),
                //   elevation: 3.0,
                //   child: TextFormField(
                //       keyboardType: TextInputType.number,
                   
                //       maxLines: 1,
                //       validator: (val) {
                //         if (val.isEmpty) {
                //           return "Cannot Be Empty";
                //         }
                //       },
                //       controller: quantity,
                //       decoration: InputDecoration(
                //         floatingLabelBehavior: FloatingLabelBehavior.auto,
                //         contentPadding: EdgeInsets.symmetric(horizontal: 10),
                //         labelText: "Quantity",
                //         icon: Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Icon(Icons.production_quantity_limits,
                //               color: Colors.blue),
                //         ),
                //         border: InputBorder.none,
                //         focusedBorder: InputBorder.none,
                //       ))),
                // ),

                    SizedBox(height: 20,),
          ],
        ),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: alert,
        );
      },
    );
  }

  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Reservations"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.profile_circled),
        title: ("Profile"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  List<Widget> buildScreens() {
    return [ResortProfile(), ResortAdminReservation()];
  }

  void getImage(ImageSource imageSource, BuildContext context) async {
    final picked = await ImagePicker().pickImage(source: imageSource);
    if (picked != null) {
      selectedImagePath.value = picked.path;
      selectedImageSize.value =
          ((File(selectedImagePath.value)).lengthSync() / 1024 / 1024)
                  .toStringAsFixed(2) +
              " Mb";
    } else {
      Get.snackbar('Error', 'No Image selected',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white);
    }
  }

   GetBar ErrorSnackBar({String title = 'Error', String message}) {
    Get.log("[$title] $message", isError: true);
    return GetBar(
      // titleText: Text(title.tr, style: Get.textTheme.headline6.merge(TextStyle(color: Get.theme.primaryColor, fontSize:15))),
      messageText: Text(message, style: Get.textTheme.caption.merge(TextStyle(color: Colors.white, fontSize:15))),
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.all(20),
      backgroundColor: Colors.redAccent,
      icon: Icon(Icons.remove_circle_outline, size: 32, color: Colors.white),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      dismissDirection: SnackDismissDirection.HORIZONTAL,
      borderRadius: 8,
      duration: Duration(seconds: 5),
    );
  }

   GetBar SuccessSnackBar({String title = 'Success', String message}) {
    Get.log("[$title] $message");
    return GetBar(
      titleText: Text(title.tr, style: Get.textTheme.headline6.merge(TextStyle(color: Colors.white, fontSize:15))),
      messageText: Text(message, style: Get.textTheme.caption.merge(TextStyle(color: Colors.white, fontSize:15))),
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.all(20),
      backgroundColor: Colors.green,
      icon: Icon(Icons.check_circle_outline, size: 32, color: Colors.white),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      dismissDirection: SnackDismissDirection.HORIZONTAL,
      duration: Duration(seconds: 5),
    );
  }
  
}
