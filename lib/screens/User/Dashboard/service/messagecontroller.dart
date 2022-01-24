import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/state_manager.dart';

class MessageController extends GetxController{

 final db = FirebaseFirestore.instance;

List<dynamic> chat =[].obs;


addChat(String value){
  chat.add(value);
  update();
}


 Stream<QuerySnapshot<Object>> getMessage(String userID, String resortID){
  return db.collection("Chats").where("resortID", isEqualTo: resortID).snapshots();
}

Future<void> sendMessage(String userID, String resortID, String message) async {
    try {
      final collRef = FirebaseFirestore.instance.collection('Chats');
      DocumentReference users = collRef.doc();
      var date =DateTime.now();
      await users.set(({
        'messages': message,
        'userID':userID,
        'resortID':resortID,
        'chatID':users.id,
        'isSender':true,
        'isResort':false,
        'date':date,
      })).then((value){
        return;
      });
    } catch (e) {

         
    }
  }


  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
  }
}