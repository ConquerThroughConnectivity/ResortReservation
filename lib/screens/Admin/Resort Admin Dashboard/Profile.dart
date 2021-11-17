import 'package:ResortReservation/colors/colors.dart';
import 'package:ResortReservation/colors/icons.dart';
import 'package:ResortReservation/screens/Admin/controller.dart';
import 'package:ResortReservation/screens/User/Signup/Signup.dart';
import 'package:ResortReservation/screens/User/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

final servicecontroller = Get.put(SharedData());

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
    print(userID);
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
                    onPressed: () {
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
                  SharedPreferences pref =
                  await SharedPreferences.getInstance();
                  pref.remove("resortadminfirstname");
                  pref.remove("resortadminlastname");
                  pref.remove("resortadminemail");
                  pref.remove("resortadminpassword");
                  pref.remove("resortadminisLogin");
                  pref.remove("resortadminresortname");
                  pref.remove("resortadminUserID");
                  pref.clear();
                  Get.offAndToNamed("/login");
                },
                icon: Icon(
                  Icons.logout_rounded,
                  color: Colors.black,
                ))
          ],
        ),
        body: GetBuilder<AdminController>(
            init: AdminController(),
            builder: (controller) {
              
              return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("Resorts").where("resortname", isEqualTo: resortname).snapshots(),
                builder: (context, snapshot) {var userDocument = snapshot.data;
                  if (!snapshot.hasData) {
                    return Center(
                      child: Container(
                          height: 100,
                          width: 100,
                          child: Image.asset(AppIcons.icon)),
                    );
                  }
                 else {




                    TextEditingController resortadminusername =
                        new TextEditingController(text: email);
                    TextEditingController resortadminfirstname =
                        new TextEditingController(text: firstname);
                    TextEditingController resortadminlastname =
                        new TextEditingController(text: lastname);
                    TextEditingController resortadminresortname =
                        new TextEditingController(text: resortname);
                    TextEditingController resortadminpassword =
                        new TextEditingController(text: password);
                    TextEditingController resortadminentrancefee =
                        new TextEditingController(
                            text: userDocument.docs[0]['resortentrancefee']);
                    var user = snapshot.data.docs;
                    List<dynamic> snap = user[0]['resortamenties'];
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
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image:
                                              AssetImage(AppIcons.background))),
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
                                margin: EdgeInsets.all(25),
                                child: TextFormField(
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Cannot Be Empty";
                                      }
                                    },
                                    controller: resortadminusername,
                                    decoration: InputDecoration(
                                      focusColor: Colors.black,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black54, width: 2.0),
                                      ),
                                      fillColor: Colors.black,
                                      labelStyle: TextStyle(
                                          fontFamily: 'SFS',
                                          fontSize: 15,
                                          color: Colors.black),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto,
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      labelText: "Email",
                                      icon: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.mail_outline,
                                            color: Colors.black),
                                      ),
                                    )),
                              ),
                              Container(
                                margin: EdgeInsets.all(25),
                                child: TextFormField(
                                    obscureText: true,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Cannot Be Empty";
                                      }
                                    },
                                    controller: resortadminpassword,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black54, width: 2.0),
                                      ),
                                      fillColor: Colors.black,
                                      labelStyle: TextStyle(
                                          fontFamily: 'SFS',
                                          fontSize: 15,
                                          color: Colors.black),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto,
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      labelText: "Password",
                                      icon: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.password_outlined,
                                            color: Colors.black),
                                      ),
                                    )),
                              ),
                              Container(
                                margin: EdgeInsets.all(25),
                                child: TextFormField(
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Cannot Be Empty";
                                      }
                                    },
                                    controller: resortadminfirstname,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black54, width: 2.0),
                                      ),
                                      fillColor: Colors.black,
                                      labelStyle: TextStyle(
                                          fontFamily: 'SFS',
                                          fontSize: 15,
                                          color: Colors.black),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto,
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      labelText: "Firstname",
                                      icon: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.people_alt,
                                            color: Colors.black),
                                      ),
                                    )),
                              ),
                              Container(
                                margin: EdgeInsets.all(25),
                                child: TextFormField(
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Cannot Be Empty";
                                      }
                                    },
                                    controller: resortadminlastname,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black54, width: 2.0),
                                      ),
                                      fillColor: Colors.black,
                                      labelStyle: TextStyle(
                                          fontFamily: 'SFS',
                                          fontSize: 15,
                                          color: Colors.black),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto,
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      labelText: "Lastname",
                                      icon: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.people_alt,
                                            color: Colors.black),
                                      ),
                                    )),
                              ),
                              Container(
                                margin: EdgeInsets.all(25),
                                child: TextFormField(
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Cannot Be Empty";
                                      }
                                    },
                                    controller: resortadminresortname,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black54, width: 2.0),
                                      ),
                                      fillColor: Colors.black,
                                      labelStyle: TextStyle(
                                          fontFamily: 'SFS',
                                          fontSize: 15,
                                          color: Colors.black),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto,
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      labelText: "Resort Name",
                                      icon: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.beach_access_outlined,
                                            color: Colors.black),
                                      ),
                                    )),
                              ),
                              Container(
                                margin: EdgeInsets.all(25),
                                child: TextFormField(
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Cannot Be Empty";
                                      }
                                    },
                                    controller: resortadminentrancefee,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black54, width: 2.0),
                                      ),
                                      fillColor: Colors.black,
                                      labelStyle: TextStyle(
                                          fontFamily: 'SFS',
                                          fontSize: 15,
                                          color: Colors.black),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto,
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      labelText: "Resort Entrance Fee",
                                      icon: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                            Icons.monetization_on_rounded,
                                            color: Colors.black),
                                      ),
                                    )),
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
                                                    return Container(
                                                      margin:
                                                          EdgeInsets.all(20),
                                                      height: 100,
                                                      child: Card(
                                                        elevation: 2,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "${snap[index]['Description']}",
                                                              style: Get
                                                                  .textTheme
                                                                  .bodyText2,
                                                            ),
                                                            Center(
                                                              child: IconButton(
                                                                  onPressed:
                                                                      () async {
                                                                      
                                                                    FirebaseFirestore.instance.collection("Resorts").doc(userID).set({
                                                                      "resortamenties": "asd"
                                                                    }).then((value){
                                                                      
                                                                    });
                                                                  },
                                                                  icon: Icon(Icons
                                                                      .remove_circle_outline_outlined)),
                                                            ),
                                                          ],
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
