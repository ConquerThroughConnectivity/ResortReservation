import 'package:ResortReservation/colors/colors.dart';
import 'package:ResortReservation/colors/icons.dart';
import 'package:ResortReservation/screens/Admin/controller.dart';
import 'package:ResortReservation/screens/Admin/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:select_form_field/select_form_field.dart';



final controller =Get.put(AdminController());
class AddResortAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Get.offAndToNamed("/home");
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Text(
          "Resort Admin",
          style: TextStyle(
            fontFamily: 'SFS',
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      body: GetBuilder<AdminController>(
        init: AdminController(),
        builder: (snapshot){
        return ModalProgressHUD(
        inAsyncCall: snapshot.isResortLogin.value,
        color: AppColors.cardYellow,
        progressIndicator: Image.asset(AppIcons.icon, fit: BoxFit.cover, scale:20,),
        child: Stack(
          children: [
            Form(
              
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        elevation: 3.0,
                        child: TextFormField(
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Cannot Be Empty";
                              }
                            },
                            controller: snapshot.username,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              labelText: "Email Address",
                              icon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.email_sharp,
                                    color: Colors.blue),
                              ),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        elevation: 3.0,
                        child: TextFormField(
                           
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Cannot Be Empty";
                              }
                            },
                            controller: snapshot.password,
                            obscureText: true,
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              labelText: "Password",
                              icon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.password,
                                    color: Colors.blue),
                              ),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ))),
                  ),
                   Padding(
                    padding: const EdgeInsets.all(20),
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        elevation: 3.0,
                        child: TextFormField(
                            
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Cannot Be Empty";
                              }
                            },
                            controller: snapshot.firstname,
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              labelText: "Firstname",
                              icon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.people_alt,
                                    color: Colors.blue),
                              ),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        elevation: 3.0,
                        child: TextFormField(
                            
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Cannot Be Empty";
                              }
                            },
                            controller: snapshot.lastname,
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                              labelText: "Lastname",
                              icon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.people_alt,
                                    color: Colors.blue),
                              ),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ))),
                  ),
                  Padding(
                          padding: const EdgeInsets.all(20),
                          child: Card(
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                            elevation: 3.0,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SelectFormField(
                              type: SelectFormFieldType.dropdown,
                              controller: snapshot.resortname,
                              labelText: 'Select Resort',
                              items: controller.itemsuck,
                              onChanged: (val){
            
                              },
                              
                          ),
                            )
                          ),
                        ),
                  SizedBox(height: 20,),
                        Container(
                              child: ElevatedButton(
                               style: ElevatedButton.styleFrom(
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(10)
                                 ),
                                 primary: Color(0xFF306EFF),
                                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                  textStyle: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                               ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              onPressed: (){
                            
                              snapshot.resortAdminSignup();
                              }, 
                              child: Text("Register Admin", style: TextStyle(
                                fontFamily: 'SFS',
                                fontSize: 15
                              ),)),
                            ),
                ],
              ),
            )
          ],
        ),
      );
      },)
      
    );
  }
}
