import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud_operation/component/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class SignUpController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child("Users");
  bool _loading = false;

  bool get loading => _loading;

  void signUp(BuildContext context, String email, String password,
      String firstName, String lastName) {
    setLoading(true);
    try {
      auth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => {
                ref.child(value.user!.uid.toString()).set({
                  'uid': value.user!.uid.toString(),
                  'email': value.user!.email.toString(),
                  'firstName': firstName,
                  'lastName': lastName,
                  'profileImg': "",
                }).then((value) {
                  Utils.toastMessage("User created successfully");
                  setLoading(false);
                  Navigator.pop(context);
                }).onError((e, stackTrace) {
                  setLoading(false);
                  Utils.toastMessage(e.toString());
                })
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
