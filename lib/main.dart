import 'package:ResortReservation/colors/colors.dart';
import 'package:ResortReservation/colors/icons.dart';
import 'package:ResortReservation/cypher.dart';
import 'package:ResortReservation/screens/Admin/Add%20Resort%20Admin/addResortAdmin.dart';
import 'package:ResortReservation/screens/Admin/Add%20Resort/addResort.dart';
import 'package:ResortReservation/screens/Admin/Resort%20List/ResortList.dart';
import 'package:ResortReservation/screens/Admin/view.dart';

import 'package:ResortReservation/screens/Login/view.dart';
import 'package:ResortReservation/screens/User/Dashboard/Bookings.dart';
import 'package:ResortReservation/screens/User/Profile/Profile.dart';
import 'package:ResortReservation/screens/User/Signup/Signup.dart';
import 'package:ResortReservation/screens/User/service.dart';
import 'package:ResortReservation/screens/User/user.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


import 'screens/Admin/Resort Admin Dashboard/ResortAdmin.dart';
import 'screens/Admin/Resort Admin List/ResortAdminList.dart';

Future<void> main() async{
WidgetsFlutterBinding.ensureInitialized();
SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
await Firebase.initializeApp();
runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'EasyShore',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
    
      home: EasySplashScreen(
      loadingText: Text("Loading..."),
      logo: Image.asset(AppIcons.icon2, scale: 5.0,),
      title: Text("Welcome to EasyShore", style: TextStyle(
          fontFamily: 'glee',
          fontSize: 15,
          
      ),),
      navigator: Cypher(),
      showLoader: true,
      backgroundColor: AppColors.cardLightMaroon,
      
      durationInSeconds: 5,
      ),
      getPages: [
        GetPage(name:'/login', 
        page:()=> Login()
        ),
        GetPage(name:'/home', 
        page:()=> Home()
        ),
        GetPage(name:'/addresort', 
        page:()=> AddResort()
        ),
        GetPage(name:'/addresortadmin', 
        page:()=> AddResortAdmin(),
        ),
        GetPage(name:'/dashboardadmin', 
        page:()=> ResortAdminHome(),
        ),
        GetPage(name:'/signup', 
        page:()=> Signup(),
        ),
        GetPage(name:'/userprofile', 
        page:()=> UserProfile(),
        ),
         GetPage(name:'/user', 
        page:()=>User(),
        ),
        GetPage(name:'/resortlist', 
        page:()=>ResortList(),
        ),
        GetPage(name:'/resortadminlist', 
        page:()=>ResortAdminList()
        ),
        GetPage(name:'/mybookings', 
        page:()=>Booking()
        ),
 
      ],
      defaultTransition: Transition.cupertino,
    );
  }
}


