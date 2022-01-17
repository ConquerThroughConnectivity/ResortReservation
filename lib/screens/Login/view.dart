import 'package:ResortReservation/colors/colors.dart';
import 'package:ResortReservation/colors/icons.dart';
import 'package:ResortReservation/screens/Login/controller.dart';
import 'package:ResortReservation/screens/Login/wave.dart';
import 'package:ResortReservation/screens/User/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  final logincontroller =Get.put(LoginController());
  final data =Get.put(SharedData());

class Login extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body:GetBuilder<LoginController>(
        init: LoginController(),
        builder: (snapshot){
        return ModalProgressHUD(
        color: AppColors.cardYellow,
        progressIndicator: Image.asset(AppIcons.icon, fit: BoxFit.cover, scale:20,),
        inAsyncCall: snapshot.isLogin.value, 
        child:  SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40,),
                      Center(child: Image.asset(AppIcons.icon2, fit: BoxFit.cover, scale: 40.0,)),
                      SizedBox(height: 40,),
                      Center(child: Text("EasyShore, Login to continue", style: TextStyle(fontFamily: 'SFS', fontSize:17),)),
                      SizedBox(height: 40,),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Card(
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                          elevation: 3.0,
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                          validator: (val){
                            if(val.isEmpty){
                              return "Cannot Be Empty";
                            }
                          },
                          controller: username,
                          decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        
                          labelText: "Email",
                          icon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.mail_outline, color: Colors.black),
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none
                          
                          
                            )
                          )
                        ),
                      ),
             
                      Padding(
                        padding: const EdgeInsets.all(15), 
                        child: Card(
                         shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                          color:Color(0xFFF1EBDF),
                          elevation: 3.0,
                          child: TextFormField(
                            validator: (val){
                              if(val.isEmpty){
                              return "Cannot Be Empty";
                            }
                            },
                            controller: password,
                            obscureText: true,
                            decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelStyle: TextStyle(
                            fontFamily: 'SFS'
                          ),
                          labelText: "Password",
                          icon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.password_outlined, color: Colors.black),
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none
                            )
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                      Align(
                        alignment: Alignment.centerRight,
                        child:Container(
                          child: ElevatedButton(
                           style: ElevatedButton.styleFrom(
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(10)
                             ),
                             primary: AppColors.cardDarkBlue,
                              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                              textStyle: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                           ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          onPressed: (){
                            if(_formKey.currentState.validate()){
                              logincontroller.newLogin(email: username.text, password: password.text);
                            }
                          //  if(_formKey.currentState.validate() &&username.text.contains("resort#")){
                          //    Get.offAndToNamed("/dashboardadmin");
                          //  }
                          //  }else if(_formKey.currentState.validate() &&username.text.contains("admin#")){
                          //    Get.offAndToNamed("/home");
                          //  }else if(_formKey.currentState.validate() &&username.text.contains("user#")){
                          //    Get.offAndToNamed("/user");
                          //  }
                          }, 
                          child: Text("Login ->", style: TextStyle(
                            fontFamily: 'SFS',
                            fontSize: 15
                          ),)),
                        )
                      ),
                      SizedBox(height: 50,),
                      Container(
                          padding: EdgeInsets.only(left: 50),
                          child: Row(
                            children: [
                              Text('Do you have an account?', style: TextStyle(
                                fontFamily: 'SFS',
                                fontSize: 15,
                                color: Colors.black
                              ),),
                              SizedBox(width: 10,),
                              InkWell(
                                onTap: (){
                                  Get.offAndToNamed("/signup");
                                },
                                child: Text('Signup', style: TextStyle(
                                  fontFamily: 'SFS',
                                  fontSize: 15,
                                  color:AppColors.cardDarkBlue
                                ),),
                              ),
                            ],
                          )
                        ),
                    
                    
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                    height: 800,
                    width: double.infinity,
                    child: AnimationWaveTrial(),
              ),
            )
        ],),
      ), 
          );
      })
    );
  }
}