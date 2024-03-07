import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud_operation/component/round_button.dart';
import 'package:firebase_crud_operation/component/utils.dart';
import 'package:firebase_crud_operation/provider/profile_controller.dart';
import 'package:firebase_crud_operation/screen/login_screen.dart';
import 'package:firebase_crud_operation/services/session_controller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget{
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen>{
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseAuth? auth2;
  final ref = FirebaseDatabase.instance.ref("Users");
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return WillPopScope(
     onWillPop: () async{
       return false;
     },
       child: Scaffold(
         resizeToAvoidBottomInset: false,
         appBar: AppBar(
           automaticallyImplyLeading: false,
           title: const Text("Profile Screen"),
         ),
         body: Consumer<ProfileController>(
             builder: (context , provider , child){
               return Container(
                 margin: const EdgeInsets.all(15),
                 child: StreamBuilder(
                   stream: ref.child(SessionController().userId.toString()).onValue,
                   builder: (context ,AsyncSnapshot snapshot){
                     if(!snapshot.hasData){
                       return const Center(child: CircularProgressIndicator(color: Colors.black54,),);
                     }
                     else if(snapshot.hasData){

                       Map<dynamic , dynamic> map =  snapshot.data != null ? snapshot.data!.snapshot.value : "";
                       return SingleChildScrollView(
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             getImageWidget(map , provider),
                             getDataWidget(map , provider),
                             getButtonWidget(provider),
                           ],
                         ),
                       );
                     }
                     else{
                       return const Center(child: Text("Something went to wrong"));
                     }
                   },
                 ),
               );
             }
         ),
       ),
   );
  }


  Widget getImageWidget(Map<dynamic, dynamic> map, ProfileController provider){
    return Center(
      child: Stack(
        children: [
          Container(
              margin: const EdgeInsets.only(top: 40),
              width: 120,
              height: 120,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child:provider.image == null ?
              Image.network(map['profileImg'].toString() == "" ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1rTLeQraa9s-Rkj2_KMPOzh30CwK1G2D85A&usqp=CAU" : map['profileImg'].toString() ,
                fit: BoxFit.cover,
              ) : Stack(
                children: [
                  Image.file(File(provider.image!.path.toString())),
                  const Center(child: CircularProgressIndicator(color: Colors.black45,),)
                ],
              )
            ),
          Positioned(
            right: 0,
            bottom: 10,
            child: InkWell(
              onTap: (){
                provider.pickImage(context);
              },
              child: Container(
                height: 35,
                width: 35,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black
                ),
                child: const Icon(Icons.edit , size: 20,color: Colors.white,),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getDataWidget(Map<dynamic , dynamic> map , ProfileController provider){
    return Container(
      margin: const EdgeInsets.only(top: 35 ,left: 10 ,right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
      children: [
          getDetailsWidget(
              title: "First Name",
              value: map['firstName'] != null && map['firstName'] != "" ? map['firstName'] : "-",
              iconData: (Icons.edit),
              onPressed: () {
                provider.showFirstNameDialogAlert(context, map['firstName']);
              }),
          getDetailsWidget(
              title: "Last Name",
              value: map['lastName'] != null && map['lastName'] != "" ? map['lastName'] : "-",
              iconData: (Icons.edit),
              onPressed: () {
                provider.showLastNameDialogAlert(context, map['lastName']);
              }),
          getDetailsWidget(title: "Email", value: map['email'] != null && map['email'] != "" ?map['email'] : "-"),
        ],
      ),
    );
  }

  Widget getDetailsWidget({required String title, required String value , IconData? iconData , Function? onPressed}){
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title ,style: const TextStyle(fontSize: 17),),
              InkWell(
                onTap: (){
                  onPressed!();
                },
                  child: Icon(iconData ,size: 19,)),
            ],
          ),
          const SizedBox(height: 7,),
          Text(value ,style: const TextStyle(fontSize: 15),),
          const SizedBox(height: 7,),
          const Divider(color: Colors.black45,),
        ],
      ),
    );
  }

  Widget getButtonWidget(ProfileController provider){
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 40),
          child: RoundButton(
              title: "Logout",
              onPress: (){
                auth.signOut().then((value) {
                  SessionController().userId = "";
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return const LoginScreen();
                  }));
                });
              }
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 40),
          child: RoundButton(
              title: "Delete Account",
              onPress: (){
                deleteUser();
              }
          ),
        ),
      ],
    );
  }

  void deleteUser() async {
    User user = FirebaseAuth.instance.currentUser!;
    try {
      await user.delete();
      Utils.toastMessage("User account deleted successfully.");
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return const LoginScreen();
      }));
    } catch (e) {
      Utils.toastMessage("Failed to delete user account :- $e");
    }
  }
}