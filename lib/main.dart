import 'package:deliveryportal/MainPage.dart';
import 'package:deliveryportal/constants/style.dart';
import 'package:deliveryportal/controllers/menu_controller.dart';
import 'package:deliveryportal/routes/route.dart';
import 'package:deliveryportal/views/404/error_page.dart';
import 'package:deliveryportal/views/authentication/auth.dart';
import 'package:deliveryportal/views/authentication/authentication.dart';
import 'package:deliveryportal/views/drivers/driver.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controllers/delivery_controller.dart';
import 'controllers/navigation_controller.dart';
import 'layout.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Get.put(MenuController());
  Get.put(NavigationController());
  bool isLogged = prefs.getBool('auth') ?? false;
  //print(isLogged);

  const firebaseConfig = {
    "apiKey": "AIzaSyAy3QsonkN_-n7ey2iSvVblUoiUmNFqmGo",
    "authDomain": "deliveryportal-1ab91.firebaseapp.com",
    "projectId": "deliveryportal-1ab91",
    "storageBucket": "deliveryportal-1ab91.appspot.com",
    "messagingSenderId": "439891507756",
    "appId": "1:439891507756:web:3759ca7414613792faaf89"
  };

  FirebaseApp app = await Firebase.initializeApp(options: FirebaseOptions.fromMap(firebaseConfig));
  //debugPrint(app.toString());
  runApp(MyApp(isLogged: isLogged));
}

class MyApp extends StatelessWidget {
  final bool isLogged;
  const MyApp({Key? key, required this.isLogged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   // print(isLogged);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: DeliveryController(),
        ),
      ],
      child:
    GetMaterialApp (
      initialRoute: rootRoute,
      home: MainPage(), 
      unknownRoute: GetPage (
        name: "/not-found",
        page: () => PageNotFound(),
        transition: Transition.fadeIn
      ),
      getPages: [
        GetPage(name: rootRoute, page: () => MainPage()),
        GetPage(name: authenticationPageRoute, page: () => AuthenticationPage()),
        GetPage(name: "/driver", page: () => DriversPage()),
        
      ],
      // used for the getX routing controller
      debugShowCheckedModeBanner: false, // disable debugger badge
      title: "DeliveryPortal",
      theme: ThemeData(
        scaffoldBackgroundColor: light,
        textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme).apply(bodyColor: Colors.black), // adding theme font and color
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          }
        ),
        primaryColor: Colors.blue
      ),
      //home: AuthenticationPage(), // default screen
    ));
  }
}
