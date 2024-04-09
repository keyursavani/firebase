import 'package:firebase_crud_operation/services/splash_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashScreenState();
  }}

class SplashScreenState extends State<SplashScreen>{
  SplashServices splashServices = SplashServices();
  @override
  void initState(){
    splashServices.isLogin(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Scaffold(
      body: Center(
        child: Text(
          "Welcome",
          style: TextStyle(fontSize: 25,color: Colors.black),
        ),
      ),
    );
  }
}