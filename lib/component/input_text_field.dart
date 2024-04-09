import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController myController;
  final FocusNode focusNode;
  final FormFieldSetter onFileSubmittedValue;
  final FormFieldValidator onValidator;
  final TextInputType keyBoardType;
  final String hint;
  final bool obscureText;
  final bool enable, autoFocus;

  const InputTextField(
      {Key? key,
      required this.myController,
      required this.focusNode,
      required this.onFileSubmittedValue,
      required this.onValidator,
      required this.keyBoardType,
      required this.obscureText,
      required this.hint,
      this.autoFocus = false,
      this.enable = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      controller: myController,
      focusNode: focusNode,
      autofocus: autoFocus,
      obscureText: obscureText,
      onFieldSubmitted: onFileSubmittedValue,
      validator: onValidator,
      keyboardType: keyBoardType,
      cursorColor: Colors.black54,
      cursorWidth: 1.5,
      style: const TextStyle(fontSize: 20, color: Colors.black),
      decoration: InputDecoration(
        hintText: hint,
        enabled: enable,
        contentPadding: const EdgeInsets.all(10),
        hintStyle:
            const TextStyle(color: Colors.black54, fontSize: 15, height: 0),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.black54)),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.black)),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.black54)),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.red)),
      ),
    );
  }
}
