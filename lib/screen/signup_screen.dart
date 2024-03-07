import 'package:firebase_crud_operation/component/input_text_field.dart';
import 'package:firebase_crud_operation/component/round_button.dart';
import 'package:firebase_crud_operation/component/utils.dart';
import 'package:firebase_crud_operation/provider/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget{
  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return SignUpScreenState();
  }
}

class SignUpScreenState extends State<SignUpScreen>{

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getTopWidget(),
                getFormFieldWidget(),
                getButtonWidget(),
                getBottomWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getTopWidget(){
    return Container(
      margin: const EdgeInsets.only(top:40),
        child: const Text("Welcome",style: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.w500),)
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
                myController: firstNameController,
                focusNode: firstNameFocusNode,
                onFileSubmittedValue: (value){
                  Utils.fieldFocus(context, firstNameFocusNode, lastNameFocusNode);
                },
                onValidator: (value){
                  return value.isEmpty ? "enter first name" : null;
                },
                keyBoardType: TextInputType.name,
                obscureText: false,
                hint: "First Name",
              ),
              const SizedBox(height: 20,),
              InputTextField(
                myController: lastNameController,
                focusNode: lastNameFocusNode,
                onFileSubmittedValue: (value){
                  Utils.fieldFocus(context, lastNameFocusNode, emailFocusNode);
                },
                onValidator: (value){
                  return value.isEmpty ? "enter last name" : null;
                },
                keyBoardType: TextInputType.name,
                obscureText: false,
                hint: "Last Name",
              ),
              const SizedBox(height: 20,),
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
              const SizedBox(height: 20,),
              InputTextField(
                myController: passwordController,
                focusNode: passwordFocusNode,
                onFileSubmittedValue: (value){
                  Utils.fieldFocus(context, passwordFocusNode, confirmPasswordFocusNode);
                },
                onValidator: (value){
                  return value.isEmpty ? "enter password" : null;
                },
                keyBoardType: TextInputType.text,
                obscureText: true,
                hint: "Password",
              ),
              const SizedBox(height: 20,),
              InputTextField(
                myController: confirmPasswordController,
                focusNode: confirmPasswordFocusNode,
                onFileSubmittedValue: (value){
                },
                onValidator: (value){
                  return value.isEmpty ? "enter confirm password" : null;
                },
                keyBoardType: TextInputType.text,
                obscureText: true,
                hint: "Confirm Password",
              ),
            ],
          )
      ),
    );
  }

  Widget getButtonWidget(){
    return Consumer<SignUpController>(
        builder: (context , provider , child){
      return Container(
        margin: const EdgeInsets.only(top: 50),
        child: RoundButton(
            title: "SignUp",
            loading: provider.loading,
            onPress: (){
              if(_formKey.currentState!.validate()){
                if(passwordController.text.trim().toString() == confirmPasswordController.text.trim().toString()){
                  provider.signUp(context,emailController.text, passwordController.text, firstNameController.text ,lastNameController.text);
                }else{
                  Utils.toastMessage("Password and Confirm Password must be same");
                }
              }
            }
        ),
      );
    });
  }

  Widget getBottomWidget(){
    return Container(
      margin:  const EdgeInsets.only(top: 15),
      child: InkWell(
        onTap: (){
          Navigator.pop(context);
        },
        child: const Text.rich(
          TextSpan(
              text: "Already have an account? ",
              children: [
                TextSpan(
                    text: "Login",
                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black , fontSize: 17)
                )
              ]
          ),
        ),
      ),
    );
  }
}