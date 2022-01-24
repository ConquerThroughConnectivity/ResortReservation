import 'package:ResortReservation/colors/colors.dart';
import 'package:ResortReservation/colors/icons.dart';
import 'package:ResortReservation/screens/Admin/Resort%20Admin%20Dashboard/controller.dart';
import 'package:ResortReservation/screens/Admin/controller.dart';
import 'package:ResortReservation/screens/Admin/widgets/text_field_widget.dart';
import 'package:ResortReservation/screens/User/service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';

final servicecontroller = Get.put(SharedData());
final controller =Get.put(AdminController());
final controller1 =Get.put(ResortAdminController());

class ResortProfile extends StatelessWidget {
  final String email;
  final String firstname;
  final String lastname;
  final String password;
  final String userID;
  final String resortname;

  const ResortProfile(
      {Key key,
      this.email,
      this.firstname,
      this.lastname,
      this.password,
      this.userID,
      this.resortname})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    // onEmail.selection =TextSelection.fromPosition(TextPosition(offset: onEmail.text.length));
    // onPassword.selection =TextSelection.fromPosition(TextPosition(offset: onPassword.text.length));
    // onFirstname.selection =TextSelection.fromPosition(TextPosition(offset: onFirstname.text.length));
    // onLastname.selection =TextSelection.fromPosition(TextPosition(offset: onLastname.text.length));
    // onResort.selection =TextSelection.fromPosition(TextPosition(offset: onResort.text.length));
    // onEntrance.selection =TextSelection.fromPosition(TextPosition(offset: onEntrance.text.length));
    var entranceFee;
    var resortID;
    return Scaffold(
        backgroundColor: AppColors.background,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Container(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      primary: Color(0xFF306EFF),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      textStyle:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    onPressed: ()async{
                    controller1.updateDetails(
                          email: controller1.onEmail.value.isEmpty ? email : controller1.onEmail.value.isNotEmpty ?controller1.onEmail.value :controller1.onEmail.value,
                          password: controller1.onPassword.value.isEmpty ?password :controller1.onPassword.value.isNotEmpty ?controller1.onPassword.value :controller1.onPassword.value,
                          firstname: controller1.onFirstname.value.isEmpty ?firstname :controller1.onFirstname.value.isNotEmpty ?controller1.onFirstname.value :controller1.onFirstname.value,
                          lastname: controller1.onLastname.value.isEmpty ?lastname :controller1.onLastname.value.isNotEmpty ?controller1.onLastname.value :controller1.onLastname.value,
                          userID: userID,
                    );
                    // print(controller1.onEmail.value.isEmpty ? email : controller1.onEmail.value.isNotEmpty ?controller1.onEmail.value :"");
                    // print(controller1.onEmail.value);
                      // if(controller1.onEmail.isEmpty || controller1.onPassword.isEmpty){
                        
                      // }else{
                      //   Get.showSnackbar(controller.SuccessSnackBar(message: "Saved Succesful"));
                      // }
                      //  if(_formKey.currentState.validate() &&username.text.contains("resort#")){
                      //    Get.offAndToNamed("/dashboardadmin");
                      //  }
                      //  }else if(_formKey.currentState.validate() &&username.text.contains("admin#")){
                      //    Get.offAndToNamed("/home");
                      //  }else if(_formKey.currentState.validate() &&username.text.contains("user#")){
                      //    Get.offAndToNamed("/user");
                      //  }
                    },
                    child: Text(
                      "Save Details",
                      style: TextStyle(fontFamily: 'SFS', fontSize: 15),
                    )),
              )),
        ),
        appBar: AppBar(
          // leading: IconButton(
          //    onPressed: (){
          //   //  Get.to(()=>ResortMessagesList(resortID: resortID, userID: userID,));
          //   Get.to(()=>ResortMessages(resortID: resortID,));
          // }, icon: Icon(Icons.message, color: Colors.black,)),
          toolbarHeight: 100,
          elevation: 0.0,
          backgroundColor: AppColors.background,
          centerTitle: true,
          title: Text(
            "Resort Admin Profile",
            style: TextStyle(
              fontFamily: 'SFS',
              color: Colors.black54,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  SharedPreferences pref =await SharedPreferences.getInstance();
                  pref.remove("resortadminfirstname");
                  pref.remove("resortadminlastname");
                  pref.remove("resortadminemail");
                  pref.remove("resortadminpassword");
                  pref.remove("resortadminisLogin");
                  pref.remove("resortadminresortname");
                  pref.remove("resortadminUserID");
                  pref.clear();
                  // controller1.clearSets();
                  Get.offAndToNamed("/login");
                },
                icon: Icon(
                  Icons.logout_rounded,
                  color: Colors.black,
                )),
          ],
        ),
        body: GetBuilder<ResortAdminController>(
            init: ResortAdminController(),
            builder: (snapshots) {
              return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("Resorts").where("resortname", isEqualTo: resortname).snapshots(),
                builder: (context, snapshot) {
                  var userDocument = snapshot.data;
                  if (!snapshot.hasData) {
                    return Center(
                      child: Container(
                          height: 100,
                          width: 100,
                          child: Image.asset(AppIcons.icon)),
                    );
                  }else{
                    var user = snapshot.data.docs;
                    // controller1.emailCheck(resortadminusername.text);
                    print(user[0]['userID']);
                    entranceFee =userDocument.docs[0]['resortentrancefee'];
                    resortID =userDocument.docs[0]['userID'];

                    List<dynamic> snap = user[0]['resortamenties'];
                    List<dynamic> photo = user[0]['resortphoto'];

                    List<String> displayphoto =[];
                    photo.forEach((photos){
                    displayphoto.add(photos);
                    });
                    


                    return SingleChildScrollView(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Form(
                                child: Container(
                                  // height: MediaQuery.of(context).size.height /2,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(fit: BoxFit.fill,
                                      image:AssetImage(AppIcons.background))),
                                  child: Container(
                                    height: 100,
                                    margin: EdgeInsets.all(30),
                                    child: CircleAvatar(
                                      minRadius: 50,
                                      maxRadius: 75,
                                      backgroundColor: AppColors.cardGrey,
                                      child: Container(
                                        height: 70,
                                        child: Image.asset(
                                          AppIcons.admin,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(5),
                                child: TextFieldWidget(
                                  labelText: "Email Address".tr,
                                  hintText: email,
                                  initialValue: email,
                                  onChanged: (input){
                                    snapshots.onEmail.value =input;
                                    snapshots.emailCheck(input);
                                  },
                                  onSaved: (input){
                                    snapshots.onEmail.value =input;
                                     snapshots.emailCheck(input);
                                  },
                                  validator: (input) => !EmailValidator.validate(input) ? "Should be a valid email".tr : null,
                                  iconData: Icons.alternate_email,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(5),
                                child: TextFieldWidget(
                                  labelText: "Password".tr,
                                  hintText: "••••••••••••".tr,
                                  initialValue: password,
                                  onChanged: (input){
                                    snapshots.onPassword.value =input;
                                    snapshots.passwordCheck(input);
                                  },
                                  onSaved: (input){
                                     snapshots.onPassword.value =input;
                                     snapshots.passwordCheck(input);
                                  },
                                  validator: (input) => input.length < 3 ? "Should be more than 3 characters".tr : null,
                                  iconData: Icons.lock_outline,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(5),
                                child: TextFieldWidget(
                                  labelText: "Firstname".tr,
                                  hintText: firstname,
                                  initialValue: firstname,
                                  onChanged: (input){
                                    snapshots.onFirstname.value =input;
                                    snapshots.firstnameCheck(input);
                                  },
                                  onSaved: (input){
                                    snapshots.onFirstname.value =input;
                                    snapshots.firstnameCheck(input);
                                  },
                                  validator: (input) => input.length < 3 ? "Should be more than 3 characters".tr : null,
                                  iconData: Icons.alternate_email,
                                
                                ),
                              ),
                             Container(
                                margin: EdgeInsets.all(5),
                                child: TextFieldWidget(
                                  labelText: "Lastname".tr,
                                  hintText: lastname,
                                  initialValue: lastname,
                                  onChanged: (input){
                                  snapshots.onLastname.value =input;
                                  snapshots.lastnameCheck(input);
                                  },
                                  onSaved: (input){
                                  snapshots.onLastname.value =input;
                                  snapshots.lastnameCheck(input);
                                  },
                                  validator: (input) => input.length < 3 ? "Should be more than 3 characters".tr : null,
                                  iconData: Icons.alternate_email,
                                
                                ),
                              ),
                               Container(
                                margin: EdgeInsets.all(5),
                                child: TextFieldWidget(
                                  labelText: "Resortname".tr,
                                  hintText: resortname,
                                  initialValue:resortname,
                                  onChanged: (input){
                                    snapshots.onResort.value = input;
                                    snapshots.resortCheck(input);
                                  },
                                  onSaved: (input){
                                    snapshots.onResort.value = input;
                                    snapshots.resortCheck(input);
                                  },
                                  validator: (input) => input.length < 3 ? "Should be more than 3 characters".tr : null,
                                  iconData: Icons.alternate_email,
                                
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(5),
                                child: TextFieldWidget(
                                  labelText: "Resort Fee".tr,
                                  hintText: userDocument.docs[0]['resortentrancefee'],
                                  initialValue: userDocument.docs[0]['resortentrancefee'],
                                  onChanged: (input){
                                    snapshots.onEntrance.value =input;
                                    snapshots.entranceCheck(input);
                                  },
                                  onSaved: (input){
                                    snapshots.onEntrance.value =input;
                                    snapshots.entranceCheck(input);
                                  },
                                  validator: (input) => input.length < 3 ? "Should be more than 3 characters".tr : null,
                                  iconData: Icons.alternate_email,
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    height: 400,
                                    margin: EdgeInsets.all(25),
                                    child: Container(
                                        margin: EdgeInsets.all(20),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: AppColors.cardGrey),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(height: 20),
                                            Text(
                                              "Amenities",
                                              style: TextStyle(
                                                  fontFamily: 'SFS',
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold, 
                                                  color: Colors.black54),
                                            ),
                                            // IconButton(onPressed: (){
                                            //     controller.showAlertDialog(context);
                                            // }, icon:Image.asset(AppIcons.add, fit: BoxFit.cover,) ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Container(
                                              height: 250,
                                              child: ListView.builder(
                                                  itemCount: snap.length,
                                                  itemBuilder:
                                                      (context, index) {   
                                                    return Container(margin:EdgeInsets.all(20),
                                                      height:180,
                                                      child: Card(
                                                        elevation: 2,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(20)),
                                                        child: Padding(
                                                          padding: EdgeInsets.only(top: 10),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment.center,
                                                            children: [
                                                              Text(
                                                                    "Description: ${snap[index]['Description']}",
                                                                    style: TextStyle(
                                                                      fontSize: 15,
                                                                      fontFamily: 'SFS',
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                                  ),
                                                                  SizedBox(height: 10),
                                                              Text(
                                                                    "Price: ${snap[index]['Price']}",
                                                                    style: TextStyle(
                                                                      fontSize: 15,
                                                                      fontFamily: 'SFS',
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                                  ),
                                                                  SizedBox(height: 10),
                                                              Text(
                                                                    "Title: ${snap[index]['Title']}",
                                                                    style: TextStyle(
                                                                      fontSize: 15,
                                                                      fontFamily: 'SFS',
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                                  ),
                                                              Center(
                                                                child: IconButton(
                                                                    onPressed:
                                                                        () async {
                                                                      var val =[snap.length];
                                                                      // snap.removeAt(index);
                                                                      //  for(int c=0;c<snap.length-1;c++){
                                                                      //    print(val);
                                                                      //  }

                                                                      //  FirebaseFirestore.instance.collection("Resorts").doc(userDocument.docs[0]['userID']).update({
                                                                      //   "resortamenties": FieldValue.arrayRemove([{
                                                                      //     'Description',
                                                                      //     'Price',
                                                                      //     'Title',
                                                                      //   }]),
                                                                      // }).then((value){
                                                                      //   print("Dome");
                                                                      // });
                                                                      print(val);
                                                                    },
                                                                    icon: Icon(Icons.remove_circle_outline_outlined)),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                          ],
                                        )),
                                  ),
                                  
                                  Text(
                                    "Resort Photos",
                                    style: TextStyle(
                                        fontFamily: 'SFS',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                  Container(
                                      margin: EdgeInsets.all(20),
                                      height: 150,
                                      child: Carousel(
                                      dotSize: 6.0,
                                      dotSpacing: 15.0,
                                      images: displayphoto.map((e) =>Container(
                                      child: CachedNetworkImage(
                                      imageUrl: e,
                                      fit: BoxFit.cover,),
                                      )).toList(),
                                      ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }
                },
              );
            }));
  }
}
