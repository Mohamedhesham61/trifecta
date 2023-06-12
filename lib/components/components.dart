// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trifecta/components/constant.dart';

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget));


Widget defaultTextFormField({
  required TextEditingController controller,
  required String? Function(String? value) validator,
  required TextInputType inputType,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function()? onSuffixPressed,
  Function()? onTap,
  Function(String s)? onSubmit,
  bool isPassword = false,
  int? max,
  bool enable = true,
}) =>
    TextFormField(
      maxLines: max,
      enabled: enable,
      controller: controller,
      keyboardType: inputType,
      obscureText: isPassword,
      onTap: onTap,
      onFieldSubmitted: onSubmit,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontFamily: 'Poppin'
      ),
      decoration: InputDecoration(
        fillColor: Colors.white.withOpacity(0.4),
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontFamily: 'Poppin',
        ),
        prefixIcon: Icon(prefix,color: Colors.black,),
        suffixIcon: IconButton(icon: Icon(suffix),color: primaryColor, onPressed: onSuffixPressed),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide:  BorderSide(color: primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide:  BorderSide(color: primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide:  BorderSide(color: primaryColor),

        ),
      ),
      validator: validator,
    );

Widget defaultButton({
  double width = double.infinity, // giv it default width but can edit later
  double height = 55,
  Color textColor = Colors.white,
  Color backgroundColor = Colors.white,
  double radius = 5.0,
  required String text,
  required Function()? onPressed,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(width: 1,color: primaryColor)
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child:  FittedBox(
          child: Text(
            text,
            style: TextStyle(
              color:textColor,
              fontSize: 16,
              fontFamily: 'Poppin',
            ),
          ),
        ),
      ),
    );

Widget defaultTextButton(
    {required Function() function, required String text, required color,}) =>
    TextButton(
      onPressed: function,
      child: Text(text,
        style:  TextStyle(
          fontSize: 15,
          color: primaryColor,
          fontFamily: 'Poppin',
        ),
      ),
    );


void showToast({required String message, required ToastStates state}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: choseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}
enum ToastStates {SUCCESS, ERROR, WARNING }

// get hte color of the toast depend on the state
// success, error and warning
Color choseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}


Widget buildSuchAsContainer({
  required String text,
}){
  return Container(
    height: 40,
    decoration: BoxDecoration(
      color: const Color(0xffEDDEE8),
      borderRadius: BorderRadius.circular(20),
    ),
    child:  Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
        child: Text(text,
          style: const TextStyle(
              fontFamily: 'Poppin'
          ),
        ),
      ),
    ),
  );
}