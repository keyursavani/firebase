import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget{

  String title;
  VoidCallback onPress;
  Color? color , textColor;
  double? height,textSize,width;
  bool? loading;

  RoundButton({Key? key ,
    required this.title,
    required this.onPress,
    this.color,
    this.textColor,
    this.height,
    this.textSize,
    this.loading}):super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: loading ?? false ? null : onPress,
      child: Container(
        height:height ?? 50,
        width: width ?? double.infinity ,
        decoration: BoxDecoration(
            color: color ?? Colors.grey,
          borderRadius: const BorderRadius.all(Radius.circular(12))
        ),
        child: loading ?? false
        ? const Center(child: CircularProgressIndicator(color: Colors.white,))
        : Center(
          child: Text(title ,style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: textSize ?? 22
          ),),
        ),
      ),
    );
  }
}