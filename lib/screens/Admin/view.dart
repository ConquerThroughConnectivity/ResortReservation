import 'package:ResortReservation/colors/colors.dart';
import 'package:ResortReservation/colors/icons.dart';
import 'package:ResortReservation/screens/Admin/Resort%20Admin%20Dashboard/ResortAdmin.dart';
import 'package:ResortReservation/screens/Admin/controller.dart';
import 'package:ResortReservation/screens/Login/view.dart';
import 'package:ResortReservation/screens/User/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
final controller =Get.put(AdminController());
class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('EasyShore Admin', style: TextStyle(
          fontFamily: 'SFS',
          fontSize: 20,
          color: Colors.black54
          ),),
          IconButton(onPressed: () async {
            SharedPreferences pref = await SharedPreferences.getInstance();
            pref.remove("adminfirstname");
            pref.remove("adminlastname");
            pref.remove("adminemail");
            pref.remove("adminphoto");
            pref.remove("adminpassword");
            pref.remove("adminUserID");
            pref.remove("adminisLogin");
            pref.clear();
            Get.offAndToNamed('/login');
          }, icon: Icon(Icons.logout, color: Colors.black54,))
          ],
        )
      ),
      backgroundColor: AppColors.background,
      body: Obx((){
        return ModalProgressHUD(
          inAsyncCall: controller.isSaved.value,
          child: WillPopScope(
          onWillPop: ()async=>false,
          child: GetBuilder<SharedData>(
            init: SharedData(),
            builder: (snapshot){
            snapshot.getAdminData();
            print(snapshot.adminemail.value);
            print(snapshot.adminfirstname.value);
            print(snapshot.adminlastname.value);
            print(snapshot.adminpassword.value);
            return SingleChildScrollView(
            physics:BouncingScrollPhysics(),
            child: Stack(
              fit: StackFit.passthrough,
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(20),
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.cardGrey,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle
                                  ),
                                child: snapshot.adminphoto.value =="" ?Image.asset(AppIcons.avatar, fit: BoxFit.cover, filterQuality: FilterQuality.high,): Image.network(
                                snapshot.adminphoto.value, fit: BoxFit.cover, scale: 20, width: 150, height: 130,)
                              ),
                              SizedBox(width: 10,),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                    Text("${snapshot.adminfirstname.value}, ${snapshot.adminlastname.value}", style: TextStyle(
                                      fontFamily: 'SFS',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.purple
                                    ),),
                                    
                                    IconButton(
                                      onPressed: (){
                              
                                    },
                                    icon: Icon(
                                    Icons.add,
                                    color: Colors.purple,
                                    ))
                                  ],),
                                  Text('Super Admin', style: TextStyle(
                                      fontFamily: 'SFS',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.purple
                                    ),),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                      Container(
                        margin: EdgeInsets.only(left: 40),
                        child: Row(
                          children: [
                          Text("Hello,", style: TextStyle(
                          fontFamily: "SFS",
                          fontWeight: FontWeight.w200,
                          fontSize: 20,
                          color: Colors.black45
                        ),),
                        Text(snapshot.adminfirstname.value, style: TextStyle(
                          fontFamily: "SFS",
                          fontWeight: FontWeight.w200,
                          fontSize: 20,
                          color: Colors.black,
                        ),)
                        ],),
                      ),
                      SizedBox(height: 80,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                        InkWell(
                          onTap: (){
                           Get.toNamed("/addresort");
                          },
                          child: Container(
                          margin: EdgeInsets.only(left: 20),
                          padding: EdgeInsets.all(10),
                          height: 100,
                          width: 150,
                          decoration: BoxDecoration(
                            color: AppColors.cardRed,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: Column(
                            children: [
                              Image.asset(AppIcons.add, fit: BoxFit.contain,),
                              Text("Add New Resort", style: TextStyle(
                                fontFamily: 'SFS',
                                fontSize: 15,
                                color: Colors.white,
                              ),)
                            ],
                          ),
                          ),
                        ),
                      InkWell(
                        onTap: (){
                          Get.offAndToNamed("/addresortadmin");
                        
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          padding: EdgeInsets.all(10),
                          height: 100,
                          width: 150,
                          decoration: BoxDecoration(
                            color: AppColors.cardDarkGreen,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: Column(
                              children: [
                                Image.asset(AppIcons.addAdmin, fit: BoxFit.contain,),
                                Text("Add Resort Admin", style: TextStyle(
                                  fontFamily: 'SFS',
                                  fontSize: 15,
                                  color: Colors.white,
                                ),)
                              ],
                            ),
                        ),
                      )
                        ],
                      ),
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                        InkWell(
                          onTap: (){
                            Get.offAndToNamed("/resortlist");
                            // print("object");
                          },
                          child: Container(
                          margin: EdgeInsets.only(left: 20),
                          padding: EdgeInsets.all(10),
                          height: 100,
                          width: 150,
                          decoration: BoxDecoration(
                            color: AppColors.dark,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: Column(
                              children: [
                                Image.asset(AppIcons.list, fit: BoxFit.contain,),
                                Text("View Resort List", style: TextStyle(
                                  fontFamily: 'SFS',
                                  fontSize: 15,
                                  color: Colors.white,
                                ),)
                              ],
                            ),
                                        ),
                        ),
                      InkWell(
                        onTap: (){
                         Get.offAndToNamed("/resortadminlist");
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          padding: EdgeInsets.all(10),
                          height: 100,
                          width: 150,
                          decoration: BoxDecoration(
                            color: AppColors.cardYellow,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: Column(
                              children: [
                                Image.asset(AppIcons.viewlist, fit: BoxFit.contain,),
                                Text("View Admin List", style: TextStyle(
                                  fontFamily: 'SFS',
                                  fontSize: 15,
                                  color: Colors.white,
                                ),)
                              ],
                            ),
                        ),
                      )
                        ],
                      ),
                    SizedBox(height: 30,),
                    
                    ],
                  ),
            
                ],
              ),
          );
          })
              ),
        );
      })
  
    );
  }
}