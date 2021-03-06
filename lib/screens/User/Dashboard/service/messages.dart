
import 'package:ResortReservation/colors/colors.dart';
import 'package:ResortReservation/colors/icons.dart';
import 'package:ResortReservation/screens/User/Dashboard/service/messagecontroller.dart';
import 'package:ResortReservation/screens/User/user.dart';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class Messages extends StatelessWidget {

 final String userID;
 final String resortID;
 final String resortname;
 final String url;

  const Messages({Key key, this.userID, this.resortID, this.resortname, this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = new TextEditingController();
    final ago = new DateTime.now();
    return GetBuilder<MessageController>(
      init: MessageController(),
      builder: (snapshots){
      return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        
        height: 60,
        width: double.infinity,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.cardLightMaroon
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           Container(
             height: 90,
             width: 250,
             child: TextFormField(
               controller: controller,
               decoration: InputDecoration(
                 hintText: 'Write Message',
                 border: InputBorder.none,
               ),
               
             ),
           ),
            InkWell(
              onTap: (){
                if(controller.text ==""){
                  return;
                }else{
                  snapshots.sendMessage(userID, resortID, controller.text);
                  controller.text ="";
                }
                
              },
              child: Icon(Icons.send, color: Colors.black,)),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Get.to(()=>User());
        }, 
        icon: Icon(Icons.arrow_back_ios_new, color: Colors.black,)),
        title: Column(
          children: [
          Row(
          children: [
          CircleAvatar(
          foregroundColor: Colors.blue,
          backgroundColor: Colors.white,
          radius: 20,
          child: ClipOval(
            child: Image.network(
              url,
              fit: BoxFit.cover,
              width: 50,
              height: 50,
            ),
          )),
          SizedBox(width: 20,),
         Column(
          children: [
          Text(resortname, style: TextStyle(
          fontFamily: 'SFS',
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 15,
          ),),
          Text(timeago.format(ago), style: TextStyle(
          fontFamily: 'SFS',
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 15,
          ),),
           ],
         )
            ],
          ),

          ],
        )
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
            StreamBuilder<QuerySnapshot>(
            stream: snapshots.getMessage(userID, resortID),    
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
                if(doc['resortID'] ==resortID){
                  return Container(
                  margin: EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                   child: BubbleNormal(
                    text:doc['messages'],
                    isSender: doc['isSender'],
                    textStyle: TextStyle(
                      fontFamily: 'SFS',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: doc['isSender'] ==false ? Colors.black : Colors.white,
                    ),
                    color:doc['isSender'] ==false ? AppColors.cardLightMaroon : AppColors.cardDarkBlue,
                    tail: true,
                    sent: true,
                ),                  
                );
                }else{
                  return Container();
                }
            })
            );
          }
            
              })
            ],
          )
        ),
      ),
    );
    });
  }
}