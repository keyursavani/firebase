import 'package:firebase_crud_operation/component/input_text_field.dart';
import 'package:firebase_crud_operation/component/round_button.dart';
import 'package:firebase_crud_operation/component/utils.dart';
import 'package:firebase_crud_operation/provider/login_controller.dart';
import 'package:firebase_crud_operation/screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({Key? key}) :super (key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen>{
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(left: 15,right: 15,bottom: 15,top: 85),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    getTopWidget(),
                    getFormFieldWidget(),
                    getLoginButtonWidget(),
                    getBottomWidget(),
                  ],
                ),
              ),
            ),
          ),
        ),
       );
  }

  Widget getTopWidget(){
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child:const Text("Welcome",style: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.w500),),

    );
  }

  Widget getFormFieldWidget(){
    return Container(
      margin: const EdgeInsets.only(top: 50),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              InputTextField(
                myController: emailController,
                focusNode: emailFocusNode,
                onFileSubmittedValue: (value){
                  Utils.fieldFocus(context, emailFocusNode, passwordFocusNode);
                },
                onValidator: (value){
                  return value.isEmpty ? "enter email" : null;
                },
                keyBoardType: TextInputType.emailAddress,
                obscureText: false,
                hint: "Email",
              ),
              const SizedBox(height: 30,),
              InputTextField(
                myController: passwordController,
                focusNode: passwordFocusNode,
                onFileSubmittedValue: (value){

                },
                onValidator: (value){
                  return value.isEmpty ? "enter password" : null;
                },
                keyBoardType: TextInputType.emailAddress,
                obscureText: true,
                hint: "Password",
              ),
            ],
          )
      ),
    );
  }

  Widget getLoginButtonWidget(){
    return  Consumer<LoginController>(
        builder: (context , provider , child){
      return  Container(
        margin: const EdgeInsets.only(top: 50),
        child: RoundButton(
            title: "Login",
            loading: provider.loading,
            onPress: (){
              if(_formKey.currentState!.validate()){
                provider.login(context, emailController.text, passwordController.text);
              }
            }
        ),
      );
    });
  }

  Widget getBottomWidget(){
    return   Container(
      margin: const EdgeInsets.only(top: 15),
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return const SignUpScreen();
          }));
        },
        child: const Text.rich(
          TextSpan(
              text: "Don't have an account? ",
              children: [
                TextSpan(
                    text: "Sign Up",
                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black , fontSize: 17)
                )
              ]
          ),
        ),
      ),
    );
  }
}