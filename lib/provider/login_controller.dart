import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud_operation/component/utils.dart';
import 'package:firebase_crud_operation/screen/profile_screen.dart';
import 'package:firebase_crud_operation/services/session_controller.dart';
import 'package:flutter/material.dart';

class LoginController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _loading = false;

  bool get loading => _loading;

  void login(BuildContext context, String email, String password) {
    setLoading(true);
    try {
      auth
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => {
                SessionController().userId = value.user!.uid.toString(),
                setLoading(false),
                Utils.toastMessage("Successfully login"),
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ProfileScreen();
                }))
              })
          .onError((error, stackTrace) {
        setLoading(false);
        return Utils.toastMessage(error.toString());
      });
    } catch (e) {
      setLoading(false);
      Utils.toastMessage(e.toString());
    }
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
