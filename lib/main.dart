/* This is the start point of the Flutter Flow. 
Here we are importing all the necessary screens for the Flutter flow*/
import 'package:flutter/material.dart';
import 'package:loginout/booking_history.dart';
//import 'package:loginout/payments.dart';
import 'package:loginout/screens/home/home_screen.dart';
//import 'package:loginout/splashscreen.dart';
import 'about.dart';
import 'dashboard.dart';
import 'start.dart';
import 'login.dart';
import 'registration.dart';
import 'onboarding.dart';
import 'settings.dart';
import 'profile.dart';
import 'ResetPassword.dart';
import 'terms_conditions.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotel Booking',
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyScrollBehaviour(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A5276),
          brightness: Brightness.light,),
          useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A5276),
          brightness: Brightness.dark,
          ),
          useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      routes: {
        'settings': (context) => Setting(),
        'dashboard': (context) => Dashboard(),
        'Login': (context) => Login(),
        'start': (context) => StartPage(),
        'Register': (context) => Register(),
        'profile': (context) => Profile(),
        'onboarding': (context) => Onbording(),
        'about': (context) => About(),
        'home': (context) => HomeScreen(),
        'terms_and_conditions': (context) => TermsandConditionsPage(),
        'booking_history':(context) => BookingHistoryScreen(),
        'reset_password': (context) => ResetScreen(),
        
      },
      home: Onbording(),
    );
  }
}

class MyScrollBehaviour extends MaterialScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
