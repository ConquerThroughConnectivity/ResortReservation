
import 'dart:developer';

import 'package:ResortReservation/colors/colors.dart';
import 'package:ResortReservation/colors/icons.dart';
import 'package:ResortReservation/screens/User/Dashboard/Ticket.dart';
import 'package:ResortReservation/screens/User/Dashboard/controller.dart';
import 'package:ResortReservation/screens/User/Dashboard/widgets/cardDescription.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:smart_select/smart_select.dart';
import 'package:tab_container/tab_container.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
FocusNode _focusNode = FocusNode();

class ResortDetails extends GetView<UserController> {
  final List<dynamic> photos;
  final List<dynamic> amenties;
  final String resortname;
  final String address;
  final String fee;
  final String resortID;
  final String details;
  final String contact;
  final String type;
  final String userID;
  final String limitation;
  ResortDetails(this.photos, this.resortname, this.address, this.fee, this.resortID, this.details, this.contact, this.type, this.amenties, this.userID, this.limitation);

  @override
  Widget build(BuildContext context) {
   
   return GetBuilder<UserController>(
     init: UserController(),
     builder: (snapshots){
     snapshots.getReview(resortID: resortID);
  
    
      
     final format = DateFormat("yyyy-MM-dd");
     double total =0.0;
     for(int z=0;z<snapshots.addReviews.length;z++){
       print(snapshots.addReviews.length);
       total =(total + double.parse(snapshots.addReviews[z]['Rating']) /5);
     }
     print("Held: ${snapshots.addReviews.length}");
     List<S2Choice<String>> held =[];

       for(int z=0;z<amenties.length;z++){
         held.add(S2Choice<String>(value: amenties[z]['Price'], title: "\n ${amenties[z]['Title'].toString()} \n ${amenties[z]['Description'].toString()} \n ${amenties[z]['Price'].toString()}")); 
      }


      final ago = new DateTime.now();
      print(snapshots.addReviews);


     
    

      return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          snapshots.reset();
          snapshots.removeAmenties();
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios, color: Colors.black,)),
        title: Text("Resort Details", style: TextStyle(
          fontFamily: 'SFS',
          fontSize: 20,
          color: Colors.black
        ),),
        actions: [
          //  IconButton(onPressed: (){
          //    Get.to(()=>Messages(
          //      url: photos[0],
          //      userID: userID,
          //      resortname: resortname,
          //      resortID: resortID,
          //    ));
          //    }, 
          //    icon: Icon(Icons.message, color: Colors.black)),
        ],
        
      ),
      bottomNavigationBar:Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Container(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      primary: AppColors.cardDarkBlue,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    onPressed: ()async{
                      if(int.parse(limitation) >0){
                        if(snapshots.amentiesAdd.length ==0 || snapshots.dateFrom.value.text.isEmpty || snapshots.dateTo.value.text.isEmpty || snapshots.stayIn.text.isEmpty || snapshots.persons.text =="0"){
                      Get.snackbar(
                        "Please Input Required Fields", "Error!", 
                        backgroundColor: AppColors.cardRed, 
                        barBlur: 1.0, 
                        dismissDirection: SnackDismissDirection.HORIZONTAL,
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.all(20),
                        snackPosition: SnackPosition.TOP, colorText: Colors.white);
                      }else{
                      final date1 =DateTime.parse(snapshots.dateFrom.value.text);
                      final date2 =DateTime.parse(snapshots.dateTo.value.text);
                      int finalDate=date2.difference(date1).inDays;
                      Get.to(()=>Receipt(
                        userID: userID,
                        amenties: snapshots.amentiesAdd,
                        total: (snapshots.total.value + int.parse(fee) + (snapshots.total.value * finalDate)).toString(),
                        resortID: resortID,
                        resortname: resortname,
                        details: details,
                        dateFrom: snapshots.dateFrom.value.text,
                        dateTo: snapshots.dateTo.value.text,
                        stayin: snapshots.stayIn.text,
                        persons: snapshots.persons.text,

                      ));
                      }
                      }else{
                         Get.snackbar(
                        "This Resort is fully Book", "Error!", 
                        backgroundColor: AppColors.cardRed, 
                        barBlur: 1.0, 
                        dismissDirection: SnackDismissDirection.HORIZONTAL,
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.all(20),
                        snackPosition: SnackPosition.TOP, colorText: Colors.white);
                      }
                    },
                    child: Text(
                      "Book This Resort",
                      style: TextStyle(fontFamily: 'SFS', fontSize: 15),
                    )),
              )),
        ), 
      backgroundColor: AppColors.background,
      body: WillPopScope(
        onWillPop: ()async=>false,
        child: ModalProgressHUD(
        color: AppColors.cardYellow,
        progressIndicator: Image.asset(AppIcons.icon, fit: BoxFit.cover, scale:20,),
        inAsyncCall: snapshots.isLoad.value, 
        child: Hero(
            tag: "Card",
            child:SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Stack(
                children: [
                Column(
                children: [
                Container(
                 height: 200,
                 width: double.infinity,
                 child: Carousel(
                 dotSize: 6.0,
                 dotSpacing: 15.0,
                images: photos.map((e) => Container(
                child: CachedNetworkImage(
                imageUrl: e,
                fit: BoxFit.cover,
                      ),
                )).toList(),
                ),
              ),
              Row(
                children: [
                  Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Container(
                  child: Center(
                      child: RatingBar.builder(
                        glow: true,
                        glowColor: AppColors.cardDarkBlue,
                        ignoreGestures: true,
                        initialRating: total,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                           print(rating);
                          },
                        ),
                      ),
                    ),
                ),
                      SizedBox(width: 5,),
                      Container(
                      padding: EdgeInsets.only(top: 15),
                      child: IconButton(onPressed:(){
      
                          }, icon: Icon(Icons.pin_drop_outlined, color: Colors.black)),
                      ),
                      Container(
                           padding: EdgeInsets.only(top: 15),
                           child: Text("Location", style: TextStyle(
                            fontFamily: 'SFS',
                            fontSize: 15,
                           ),),
                         ),
                       
                        ],
                      ),
          SizedBox(height: 20,),
          Container(
          height: MediaQuery.of(context).size.height / 2* 4.6,
          child: TabContainer(
            enabled: true,
            transitionBuilder: (child, animation) {
            animation = CurvedAnimation(curve: Curves.easeIn, parent: animation);
            return SlideTransition(
             position: Tween(
             begin: const Offset(0.2, 0.0),
             end: const Offset(0.0, 0.0),
            ).animate(animation),
            child: FadeTransition(
            opacity: animation,
            child: child,
                ),
              );
          },
            color: AppColors.cardLightMaroon,
            tabEdge: TabEdge.top,    
            radius: 20,
            children: [  
              //Details   //Details //Details //Details //Details //Details //Details //Details //Details //Details //Details //Details //Details //Details //Details //Details //Details //Details //Details //Details //Details //Details
              // 
               Container(
                 padding: EdgeInsets.only(top: 40),
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Center(
                       child: Container(
                         child: Text("Additional Information", style: TextStyle(
                           fontFamily: "SFS",
                           fontWeight: FontWeight.bold,
                           fontSize: 13
                         ),),
                       ),
                     ),
                     Container(
                       padding: EdgeInsets.all(15),
                       child: Card(
                         color: AppColors.cardLightMaroon,
                         elevation: 2.0,
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(10)
                         ),
                         child: Container(
                           margin: EdgeInsets.all(20),
                           child: Column(
                             children: [
                              ResortDetailsCard(text: "Resort Name" , name: resortname, isCheck: true, isCard: true,),
                              ResortDetailsCard(text: "Resort Details" , name: details, isCheck: true, isCard: true,),
                              ResortDetailsCard(text: "Resort Address" , name: address, isCheck: true, isCard: true,),
                             ],
                           ),
                         ),
                       ),
                     ),
                     SizedBox(height: 20,),
                     Center(
                       child: Container(
                         child: Text("Additional Information", style: TextStyle(
                           fontFamily: "SFS",
                           fontWeight: FontWeight.bold,
                           fontSize: 13
                         ),),
                       ),
                     ),
                     Container(
                       padding: EdgeInsets.all(15),
                       child: Card(
                         color: AppColors.cardLightMaroon,
                         elevation: 2.0,
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(10)
                         ),
                         child: Container(
                           margin: EdgeInsets.all(20),
                           child: Column(
                             children: [
                               ResortDetailsCard(text: "Resort Fee" , name: fee, isCheck:false, isCard: true,),
                               ResortDetailsCard(text: "Resort Type" , name: type, isCheck: false, isCard: true,),
                               ResortDetailsCard(text: "Resort Contact" , name: contact, isCheck: true, isCard: true,),
                             ],
                           ),
                         ),
                       ),
                     ),
                     SizedBox(height: 10,),
                     Center(
                       child: Container(
                         child: Text("Amenties", style: TextStyle(
                           fontFamily: "SFS",
                           fontWeight: FontWeight.bold,
                           fontSize: 12
                         ),),
                       ),
                     ),
                    GetBuilder<UserController>(
                      init: UserController(),
                      builder: (snaps){
                      
                  
                        return  Container(
                    
                       padding: EdgeInsets.all(14),
                       child: Card(
                         color: AppColors.cardLightMaroon,
                         elevation: 2.0,
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(10)
                         ),
                    child:  Column(
                    
                    children: [
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,                      
                        children: [
                        Text("Select Amenties to continue", style: TextStyle(
                        fontFamily: 'SFS',
                        fontWeight: FontWeight.bold,
                        fontSize: 13
                      ),),
                      SizedBox(width: 40,),
                      IconButton(
                        onPressed: (){
                         snapshots.reset();
                         snapshots.removeAmenties();
                      }, icon: Icon(Icons.remove_circle), color: Colors.black38,)
                      ],)
                    ),
      
                 Container(
                   margin: EdgeInsets.all(10),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10),
                     color: AppColors.background
                   ),
                   child:  SmartSelect<String>.single(
                      title: 'Amenties',
                      value:"Select",
                      choiceItems: held,
                      onChange: (state) {
                        snapshots.isTotal(int.parse(state.value));
                        snapshots.addAmenties(state.valueTitle);
                        print(snapshots.amentiesAdd);
                      }
                    ),
                 ),
                 
                Container(
                   margin: EdgeInsets.all(10),
                   padding: EdgeInsets.all(5),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10),
                     color: AppColors.background
                   ),
                   child: DateTimeField(
                     controller: snapshots.dateFrom.value,
                     decoration: InputDecoration(
                       border: InputBorder.none,
                       labelText: "Date From"
                     ),
                  format: format,
                  onShowPicker: (context, currentValue) async {
                    return showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                    
                  },
                ),
                 ),
                  Container(
                   margin: EdgeInsets.all(10),
                   padding: EdgeInsets.all(5),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10),
                     color: AppColors.background
                   ),
                   child: DateTimeField(
                     controller: snapshots.dateTo.value,
                     decoration: InputDecoration(
                       border: InputBorder.none,
                       labelText: "Date To"
                     ),
                  format: format,
                  onShowPicker: (context, currentValue) async {
                    return showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                    
                  },
                ),
                 ),
                 GetBuilder<UserController>(
                   init: UserController(),
                   builder: (snaps){
                    return Container(
                   height: 70,
                   margin: EdgeInsets.all(10),
                   padding: EdgeInsets.all(5),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10),
                     color: AppColors.background
                   ),
                   
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,                      
                        children: [
                        Text("Persons ", style: TextStyle(
                        fontFamily: 'SFS',
                      
                        fontSize: 15
                      ),),
                      SizedBox(width: 40,),
                      Container(
                        height: 70,
                        width: 90,
                        child: NumberInputWithIncrementDecrement(
                        controller: snapshots.persons,
                        min: 0,
                        max: 100,
                      ),
                      )
                   
                   
                      ],)
                    );
                 }),
                     Padding(
                            padding: const EdgeInsets.all(5),
                            child: Card(
                              
                            color: AppColors.background,
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                            elevation: 3.0,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: SelectFormField(
                                   decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Stay In'),
                                focusNode: _focusNode,
                                type: SelectFormFieldType.dropdown,
                                controller: snapshots.stayIn,
                        
                                items: snapshots.items,
                                onChanged: (val){
                                   
                                },
                                
                            ),
                              )
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 90,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.background
                        ),
                        child: 
                        ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshots.amentiesAdd.length,
                          itemBuilder: (__, index){
                            return Container(
                            height: 70,
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                            child: Text("${snaps.amentiesAdd[index]}",
                              style: TextStyle(
                              fontFamily: 'SFS',
                              fontWeight: FontWeight.bold,
                              fontSize: 10),
                            ),
                          );
                        })
                      ),
                    ),
      
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.background
                        ),
                        child: Center(
                          child: Text('SubTotal: ${snaps.total.value + int.parse(fee)}', style: TextStyle(
                            fontFamily: 'glee',
                            fontSize: 12
                          ),),
                        ),
                      ),
                    ),
                   
                    ],)
                       ),
                     );
                    })
                     
                      ],
                    ),
                  ),
                  //Details //Details //Details //Details //Details //Details //Details //Details //Details //Details //Details //Details //Details //Details //Details 

               //Reviews   //Reviews  //Reviews //Reviews //Reviews //Reviews //Reviews //Reviews //Reviews //Reviews //Reviews //Reviews //Reviews //Reviews //Reviews 
              
                Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Center(
                          child: Text("Resort Reviews", style: TextStyle(
                          fontFamily: "sfs",
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                      ),),
                        ),
                      Text("See All", style: TextStyle(
                        fontFamily: "SFS",
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),)
                        ],
                      ),
                      SizedBox(height: 30,),
                      Container(
                        height: 500,
                        child: ListView.builder(
                        itemCount: snapshots.addReviews.length,
                        itemBuilder: (context,index){  
                            return Container(
                              margin: EdgeInsets.all(10),
                              height: 240,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: AppColors.background
                              ),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(20),
                                        child: CircleAvatar(
                                          radius: 30,
                                          backgroundImage: NetworkImage("${snapshots.addReviews[index]['Photo']}"),
                                        ),
                                      ),
                                      SizedBox(width: 20,),
                                      Column(
                                        children: [
                                          Container(
                                        child: Text("${snapshots.addReviews[index]['Firstname']} ${snapshots.addReviews[index]['Lastname']}", style: TextStyle(
                                          fontFamily: 'SFS',
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold
                                        ),)
                                      ),
                                      SizedBox(height: 10),
                                       Container(
                                        child: Text(timeago.format(ago), style: TextStyle(
                                          fontFamily: 'SFS',
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold
                                        ),)
                                      ),
                                        ],
                                      ),
                                      
                                    ],
                                  ),
                                   Container(
                                            height: 70,
                                            margin: EdgeInsets.only(left: 20),
                                            width: double.infinity,
                                            child: ListView(
                                              children: [
                                              Text(snapshots.addReviews[index]['Comment'], 
                                              style: TextStyle(
                                              fontFamily: 'SFS',
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold
                                              ),),
                                              ],
                                            )
                                      ),
                                    Center(
                                  child: RatingBar.builder(
                                    glow: true,
                                    glowColor: AppColors.cardDarkBlue,
                                    ignoreGestures: true,
                                    initialRating: double.parse(snapshots.addReviews[index]['Rating']),
                                    minRating: 0,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                      print(rating);
                                      },
                                    ),
                                  ),  

                                ],
                              ),
                            );
                      }),
                            
                      )
                        
                    
                    ],
                  ),
                ),
              //Reviews //Reviews //Reviews //Reviews //Reviews //Reviews //Reviews //Reviews //Reviews //Reviews //Reviews //Reviews //Reviews //Reviews //Reviews //Reviews 
            ], 
           
           tabs: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Details", style: TextStyle(
                  fontFamily: "glee",
                  fontSize: 15
                ),),
                SizedBox(width: 10,),
                Icon(Icons.book),
              ],
            ),
           Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Reviews", style: TextStyle(
                  fontFamily: "glee",
                  fontSize: 15
                ),),
                SizedBox(width: 10,),
                Icon(Icons.reviews),
              ],
            ),
           
           ]),
        )
                  ],
                ),
                  
                ],
              ),
            )),),
      )
    );
   });
  }
  
}
