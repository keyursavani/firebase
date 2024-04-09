import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud_operation/screen/login_screen.dart';
import 'package:firebase_crud_operation/screen/profile_screen.dart';
import 'package:firebase_crud_operation/services/session_controller.dart';
import 'package:flutter/material.dart';

class SplashServices {
  FirebaseAuth auth = FirebaseAuth.instance;

  void isLogin(context) {
    final user = auth.currentUser;

    if (user != null) {
      SessionController().userId = user.uid.toString();
      Timer(
          const Duration(seconds: 5),
          () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const ProfileScreen();
              })));
    } else {
      Timer(
          const Duration(seconds: 5),
          () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const LoginScreen();
              })));
    }
  }
}
