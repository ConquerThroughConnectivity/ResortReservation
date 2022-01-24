import 'package:ResortReservation/colors/colors.dart';
import 'package:ResortReservation/colors/icons.dart';
import 'package:ResortReservation/screens/Admin/Resort%20Admin%20Dashboard/ResortAdmin.dart';
import 'package:ResortReservation/screens/Admin/Resort%20Admin%20Dashboard/controller.dart';
import 'package:ResortReservation/screens/User/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResortMessagesList extends StatelessWidget {
  final String userID;
  final String resortID;
  const ResortMessagesList({Key key, this.userID, this.resortID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(userID);
    print(resortID);
    return GetBuilder<ResortAdminController>(
      init: ResortAdminController(),
      builder: (snapshots){
        return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Get.to(()=>ResortAdminHome());
        }, icon: Icon(Icons.arrow_back_ios_new, color: Colors.black,)),
        title: Text("Messages List", style: TextStyle(
          fontFamily: 'SFS',
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),),
      ),
          body: Stack(
            children: [
              Column(
                children: [
            StreamBuilder<QuerySnapshot>(
            stream: snapshots.getMessageList(resortID),    
            builder: (context, snapshot){
            if(!snapshot.hasData){
              return Center(child: Text("No Data"));
            }if(snapshot.connectionState ==ConnectionState.waiting){
            return Center(
            child: Image.asset(AppIcons.icon, fit: BoxFit.cover, scale: 20,),
            );
          }else{
            return Container(
            height: 600,
            child: ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index){
                DocumentSnapshot doc  =snapshot.data.docs[index];
                print(doc['userID']);
                  return Container(
                    height: 150,
                    width: double.infinity,
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                     children: [
                       Row(
                         children: [
                        //    Container(
                        //     margin: EdgeInsets.all(20),
                        //     child: CircleAvatar(
                        //     radius: 30,
                        //     backgroundImage: NetworkImage(doc['photo']),
                        //   ),
                        // ),
                         ],
                       )
                     ],
                   )                
                );
            })
            );
          }
            
              })
                ],
              )
            ],
          ),
    );
    });
  }
}