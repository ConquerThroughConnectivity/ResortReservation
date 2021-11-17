
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedData extends GetxController{

SharedPreferences pref;
var userfirstname ="".obs;
var userlastname ="".obs;
var useremail ="".obs;
var userphoto ="".obs;
var userpassword ="".obs;
var userUserId ="".obs;
var isUserlogin =false.obs;

var adminfirstname ="".obs;
var adminlastname ="".obs;
var adminemail ="".obs;
var adminphoto ="".obs;
var adminpassword ="".obs;
var adminUserId ="".obs;
var isadminlogin =false.obs;

var resortadminfirstname ="".obs;
var resortadminlastname ="".obs;
var resortadminemail ="".obs;
var resortadminpassword ="".obs;
var resortadminUserId ="".obs;
var resortadminresortname ="".obs;
var resortisadminlogin =false.obs;

@override
  void onInit() async{
    super.onInit();
    pref = await SharedPreferences.getInstance();
    getUserData();
    getAdminData();
  }
  Future<void> fetchUserData({String firstname, String lastname, String password, String photo, String email, String userID})async{
     pref.setString("userfirstname", firstname).toString();
     pref.setString("userlastname", lastname).toString();
     pref.setString("useremail", email).toString();
     pref.setString("userphoto", photo).toString();
     pref.setString("userpassword", password).toString();
     pref.setString("userUserID", userID).toString();
     pref.setBool("userisLogin", true);
}
  Future<void> getUserData()async{
    useremail =pref.getString("useremail").obs;
    userlastname =pref.getString("userlastname").obs;
    userfirstname =pref.getString("userfirstname").obs;
    userphoto =pref.getString("userphoto").obs;
    userpassword =pref.getString("userpassword").obs;
    userUserId =pref.getString("userUserID").obs;
    isUserlogin =pref.getBool("userisLogin").obs;
    
}
Future<void> getAdminData()async{
    adminemail =pref.getString("adminemail").obs;
    adminlastname =pref.getString("adminlastname").obs;
    adminfirstname =pref.getString("adminfirstname").obs;
    adminphoto =pref.getString("adminphoto").obs;
    adminpassword =pref.getString("adminpassword").obs;
    adminUserId =pref.getString("adminUserID").obs;
    isadminlogin =pref.getBool("adminisLogin").obs;
    
}
Future<void> getResortAdminData()async{
    resortadminemail =pref.getString("resortadminemail").obs;
    resortadminlastname =pref.getString("resortadminlastname").obs;
    resortadminfirstname =pref.getString("resortadminfirstname").obs;
    resortadminpassword =pref.getString("resortadminpassword").obs;
    resortadminUserId =pref.getString("resortadminUserID").obs;
    resortisadminlogin =pref.getBool("resortadminisLogin").obs;
    resortadminresortname =pref.getString("resortadminresortname").obs;
    
}
Future<void> removeResortAdminData()async{
    resortadminemail =("").obs;
    resortadminpassword =("").obs;
    resortadminfirstname =("").obs;
    resortadminlastname =("").obs;
    resortadminUserId  =("").obs;
    resortisadminlogin =false.obs;
    resortadminresortname =("").obs;
    pref.clear();
    
  }
  Future<void> removeUserData()async{
    useremail =("").obs;
    userpassword =("").obs;
    userfirstname =("").obs;
    userlastname =("").obs;
    userphoto =("").obs;
    userUserId =("").obs;
    isUserlogin =false.obs;
    pref.clear();
   
  }
  Future<void> removeAdminData()async{
    adminemail =("").obs;
    adminpassword =("").obs;
    adminfirstname =("").obs;
    adminlastname =("").obs;
    adminphoto =("").obs;
    adminUserId =("").obs;
    isadminlogin =false.obs;
    pref.clear();
   
  }
  



 

}