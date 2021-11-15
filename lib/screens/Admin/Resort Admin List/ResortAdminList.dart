import 'package:ResortReservation/colors/colors.dart';
import 'package:ResortReservation/colors/icons.dart';
import 'package:ResortReservation/screens/Admin/controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResortAdminList extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
        appBar: AppBar(
          toolbarHeight: 100,
          elevation: 0.0,
          backgroundColor: AppColors.background,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.offAndToNamed("/home");
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: Text(
            "Resort Admin List",
            style: TextStyle(
              fontFamily: 'SFS',
              color: Colors.black54,
            ),
          ),
        ),
        body: GetBuilder<AdminController>(
          init: AdminController(),
          builder: (controller) {
            return WillPopScope(
              onWillPop: () async => false,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                            stream:controller.db.collection("Users").where("tags", isEqualTo: "resortadmin#").snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: Text("No Data"),
                                );
                              }
                              if (snapshot.connectionState ==ConnectionState.waiting) {
                                 return Center(
                                  child: Image.asset(
                                    AppIcons.icon,
                                    fit: BoxFit.cover,
                                    scale: 20,
                                  ),
                                );
                              } else {
                                return Container(
                                    height: MediaQuery.of(context).size.height /
                                            2 *
                                            2 -
                                        150,
                                    child: ListView.builder(
                                        itemCount: snapshot.data.docs.length,
                                        itemBuilder: (context, index) {
                                          DocumentSnapshot document =snapshot.data.docs[index];
                                          
                                          return Container(
                                            margin: EdgeInsets.all(20),
                                            padding: EdgeInsets.all(30),
                                            height: 150,
                                            width: double.infinity,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                     Column(
                                                      children: [
                                                        Text(
                                                      document['resortName'],
                                                      style: TextStyle(
                                                          fontFamily: 'SFS',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(width: 10,),
                                                     Row(
                                                        children: [
                                                          SizedBox(width: 10,),
                                                          Text(
                                                         document['email'],
                                                          style: TextStyle(
                                                            fontFamily: 'SFS',
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.bold),
                                                        ),
                                                        ],
                                                      ),
                                                    
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Container(
                                                        height: 70,
                                                        width: 70,
                                                        child: Image.asset(AppIcons.icon2, fit: BoxFit.cover, )
                                                      ),
                                                      SizedBox(
                                                      width: 20,
                                                    ),
                                                    IconButton(
                                                    onPressed: (){
                                                    controller.db.collection("Users").doc(document['userID']).delete().then((value){
                                                      Get.snackbar("Admin", "Resort Admin Delete Succefull", backgroundColor: AppColors.lighgrey, snackPosition: SnackPosition.BOTTOM);
                                                    });
                                                    
                                                    }, icon: Image.asset(AppIcons.removeResort)),
                                                   

                                                  ],
                                                ),
                                               
                                              ],
                                            ),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                          );
                                        }));
                              }
                            })
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ));

    
  }
}