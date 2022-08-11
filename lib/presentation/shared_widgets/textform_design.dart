import 'package:flutter/material.dart';

class TextFormDesign extends StatelessWidget{
  String labeltext;
  Widget? prefixicon;
  Widget? sufffixicon;
  bool issecured;
  TextInputType type;
  String? Function(String?)? validate;
  TextEditingController controller;
  TextFormDesign({required this.validate,required this.controller,
    required this.labeltext,this.prefixicon,this.sufffixicon,this.issecured:false,required this.type});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  TextFormField(
      controller: controller,
      validator: validate,
      keyboardType: type,
        obscureText: issecured,
        decoration: InputDecoration(
        filled: true,labelText:labeltext,
        focusedBorder: OutlineInputBorder(

          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
        enabledBorder: OutlineInputBorder(

          borderSide: BorderSide(
            color: Colors.grey,
            width: 2.0,
          ),),prefixIcon: prefixicon,suffixIcon: sufffixicon,
        border:OutlineInputBorder(

          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ), )
    );
  }

}