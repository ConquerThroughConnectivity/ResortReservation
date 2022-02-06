import 'dart:io';
import 'dart:ui';

import 'package:ResortReservation/colors/colors.dart';
import 'package:ResortReservation/colors/icons.dart';
import 'package:ResortReservation/screens/Admin/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:textfield_tags/textfield_tags.dart';
 FocusNode _focusNode = FocusNode();

  
 final controller =Get.put(AdminController());
  class AddResort extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Get.offAndToNamed("/home");
        }, icon: Icon(Icons.arrow_back_ios, color: Colors.black,)),
        backgroundColor: Colors.transparent,
    
        title: Text('Add Resort', style: TextStyle(fontFamily: 'SFS', color: Colors.black87, fontSize: 20),),
      ),
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
                        if(_formKey.currentState.validate() && controller.resorttype.text.isNotEmpty && controller.images.isNotEmpty){
                                  controller.checkDuplicate(controller.resortname.text);
                                  // Get.toNamed("/home");
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
                    child: Text(
                      "Save Resort",
                      style: TextStyle(fontFamily: 'SFS', fontSize: 15),
                    )),
              )),
        ),
      body: GetBuilder<AdminController>(
        init: AdminController(),
        builder: (snapshot){
        return ModalProgressHUD(
          inAsyncCall: snapshot.isSaved.value,
          color: AppColors.cardYellow,
          progressIndicator: Image.asset(AppIcons.icon, fit: BoxFit.cover, scale:20,),
          child: SingleChildScrollView(
          child: Stack(
            children: [
              Form(
                key: _formKey,
                child: Column(
                    children: [
                         SizedBox(height: 20,),
                        InkWell(
                          onTap: (){
                            // controller.getImage(ImageSource.gallery, context);
                            controller.pickImages();
                            
                           
                          },
                          child: Column(
                            children: [
                              Text('Resort Photos', style: TextStyle(
                                fontFamily: 'SFS',
                                fontSize: 15,
                              
                              ),),
                              SizedBox(height: 15,),
                              Obx((){
                                return controller.images.isEmpty? Image.asset(AppIcons.addImage, fit: BoxFit.cover,)
                                :Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Swipe Right", 
                                style: TextStyle(fontFamily: 'SFS', color: Colors.black, fontSize: 10),),
                                SizedBox(height: 10,),
                                    SizedBox(
                                  height:250,
                                  width: 250,
                                  child: PageView.builder(
                                    controller: controller.pagecontroller,
                                    itemCount: controller.images.length,
                                    onPageChanged: controller.selectedImage,
        
                                    itemBuilder: (context, snapshot){
                                      return Container(
                                        height: 250,
                                        width: 250,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
        
                                        ),
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(20),
                                              child: SizedBox(
                                                height: 250,
                                                width: 250,
                                                child: Image.file(File(controller.images[snapshot].path), fit: BoxFit.cover,),
                                              ),
                                            )
                                        ],),
                                      );
                                  }),
                                ),
                                SizedBox(height: 10,),
                                Text("Swipe Left", 
                                style: TextStyle(fontFamily: 'SFS', color: Colors.black, fontSize: 10),),
                                  ],
                                );
                              }) 
                            ],
                          )
                          
                          
                          
                          ),
                          SizedBox(height: 20,),
                         Padding(
                            padding: const EdgeInsets.all(20),
                            child: Card(
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                              elevation: 3.0,
                              child: TextFormField(
                                // autofocus: true,
                              maxLines: 5,
                              validator: (val){
                                if(val.isEmpty){
                                  return "Cannot Be Empty";
                                }
                              },
                              controller: controller.resortdetails,
                              decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                            
                              labelText: "Resort Details",
                              icon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.details, color: Colors.blue),
                              ),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              
                              
                                )
                              )
                            ),
                          ),
                          SizedBox(height: 20,),
                         Padding(
                            padding: const EdgeInsets.all(20),
                            child: Card(
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                              elevation: 3.0,
                              child: TextFormField(
                                // autofocus: true,
                              maxLines: 2,
                              validator: (val){
                                if(val.isEmpty){
                                  return "Cannot Be Empty";
                                }
                              },
                              controller: controller.resortname,
                              decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                            
                              labelText: "Resort Name",
                              icon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.beach_access_outlined, color: Colors.blue),
                              ),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              
                              
                                )
                              )
                            ),
                          ),
                          SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Card(
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                              elevation: 3.0,
                              child: TextFormField(
                              maxLines: 1,
                              validator: (val){
                                if(val.isEmpty){
                                  return "Cannot Be Empty";
                                }
                              },
                              controller: controller.resortaddress,
                              decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                            
                              labelText: "Resort Address",
                              icon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.add_location_outlined, color: Colors.blue),
                              ),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none
                              
                              
                                )
                              )
                            ),
                          ),
                          Container(
                            
                            padding: const EdgeInsets.all(20),
                            child: Card(
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                              elevation: 3.0,
                              child: IntlPhoneField(
                              controller: controller.resortcontact,
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                
                              ),
                              initialCountryCode: 'PH',
                              countryCodeTextColor: Colors.white,
                              onChanged: (phone) {},
                            ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Card(
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                              elevation: 3.0,
                              child: TextFormField(
                                
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              validator: (val){
                                if(val.isEmpty){
                                  return "Cannot Be Empty";
                                }
                              },
                              controller: controller.entrancefee,
                              
                              decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                            
                              labelText: "Resort Entrance Fee",
                              icon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.monetization_on, color: Colors.blue),
                              ),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none
                              
                              
                                )
                              )
                            ),
                          ),
                           Padding(
                            padding: const EdgeInsets.all(20),
                            child: Card(
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                              elevation: 3.0,
                              child: TextFormField(
                                
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              validator: (val){
                                if(val.isEmpty){
                                  return "Cannot Be Empty";
                                }
                              },
                              controller: controller.limitations,
                              decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                            
                              labelText: "Resort Limitations",
                              icon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.production_quantity_limits, color: Colors.blue),
                              ),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none
                              
                              
                                )
                              )
                            ),
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
                                  focusNode: _focusNode,
                                type: SelectFormFieldType.dropdown,
                                controller: controller.resorttype,
                                labelText: 'Select Resort Type',
                                items: controller.items,
                                onChanged: (val){
              
                                },
                                
                            ),
                              )
                            ),
                          ),
                          
                          Obx((){
                            return Container(
                            margin: EdgeInsets.all(20),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.cardGrey
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 20),
                                Text("Add Amenities", style: TextStyle(fontFamily: 'SFS',fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54 ),),
                                IconButton(onPressed: (){
                                    controller.showAlertDialog(context);
                                }, icon:Image.asset(AppIcons.add, fit: BoxFit.cover,) ),
                                SizedBox(height: 30,),
                               SingleChildScrollView(
                                 child: Container(
                                   height: 250,
                                   child: ListView.builder(
                                     itemCount: controller.amenities.length,
                                     itemBuilder: (context, index){
                                      return Container(
                                              margin: EdgeInsets.all(20),
                                              height: 200,
                                              child: Card(
                                                elevation: 10.5,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20)
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Flexible(child: Text("${controller.amenities[index]}", style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: 'SFS'),)),
                                                    Center(
                                                      child: IconButton(onPressed: (){
                                                          controller.amenities.removeAt(index);
                                                          }, icon: Icon(Icons.remove_circle_outline_outlined)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            
                                                                  
                                      );
                                   }),
                                 ),
                               ),
                                SizedBox(height: 30,),
                            ],)
                          );
                          }),
                          SizedBox(height: 50,),
                          
                            SizedBox(height: 40),
                    ],
                ),
              )
            ],
          ),
              ),
        );
      },)
    );
  }
}