import 'dart:io';
import 'package:firebase_crud_operation/component/input_text_field.dart';
import 'package:firebase_crud_operation/component/utils.dart';
import 'package:firebase_crud_operation/services/session_controller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController with ChangeNotifier {
  final _formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();

  DatabaseReference ref = FirebaseDatabase.instance.ref().child("Users");
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final picker = ImagePicker();

  File? _image;

  File? get image => _image;

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void pickImage(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Wrap(
              children: [
                ListTile(
                  title: const Text("Camera"),
                  leading: const Icon(Icons.camera_alt_outlined),
                  onTap: () {
                    pickCameraImage(context);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text("Gallery"),
                  leading: const Icon(Icons.image_outlined),
                  onTap: () {
                    pickGalleryImage(context);
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          );
        });
  }

  Future pickGalleryImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      uploadImage(context);
      notifyListeners();
      // uploadImage(context);
    }
  }

  Future pickCameraImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      uploadImage(context);
      notifyListeners();
      // uploadImage(context);
    }
  }

  void uploadImage(BuildContext context) async {
    setLoading(true);

    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref('/profileImage${SessionController().userId}');

    firebase_storage.UploadTask uploadTask =
        storageRef.putFile(_image!.absolute);

    await Future.value(uploadTask);

    var imageUrl = await storageRef.getDownloadURL();

    ref.child(SessionController().userId.toString()).update({
      'profileImg': imageUrl.toString(),
    }).then((value) {
      Utils.toastMessage("Profile Updated");
      setLoading(false);
      _image = null;
    }).onError((error, stackTrace) {
      Utils.toastMessage(error.toString());
      setLoading(false);
    });
  }

  Future<void> showFirstNameDialogAlert(BuildContext context, String name) {
    firstNameController.text = name;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: Text("Update first name")),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                      key: _formKey,
                      child: InputTextField(
                          myController: firstNameController,
                          focusNode: firstNameFocusNode,
                          onFileSubmittedValue: (value) {},
                          onValidator: (value) {
                            return value.isEmpty ? "enter first name" : null;
                          },
                          keyBoardType: TextInputType.text,
                          obscureText: false,
                          hint: "Enter first name"))
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ref.child(SessionController().userId.toString()).update({
                        "firstName": firstNameController.text.toString(),
                      }).then((value) {
                        Navigator.pop(context);
                        firstNameController.clear();
                      });
                    } else {
                      Utils.toastMessage("Enter first name");
                    }
                  },
                  child: const Text("Update")),
            ],
          );
        });
  }

  Future<void> showLastNameDialogAlert(BuildContext context, String name) {
    lastNameController.text = name;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: Text("Update Last name")),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                      key: _formKey,
                      child: InputTextField(
                          myController: lastNameController,
                          focusNode: lastNameFocusNode,
                          onFileSubmittedValue: (value) {},
                          onValidator: (value) {
                            return value.isEmpty ? "enter last name" : null;
                          },
                          keyBoardType: TextInputType.text,
                          obscureText: false,
                          hint: "Enter last name"))
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ref.child(SessionController().userId.toString()).update({
                        "lastName": lastNameController.text.toString(),
                      }).then((value) {
                        Navigator.pop(context);
                        lastNameController.clear();
                      });
                    } else {
                      Utils.toastMessage("Enter last name");
                    }
                  },
                  child: const Text("Update")),
            ],
          );
        });
  }
}
