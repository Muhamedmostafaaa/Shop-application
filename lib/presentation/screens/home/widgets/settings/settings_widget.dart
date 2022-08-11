import 'package:flutter/material.dart';
import 'package:shop_app/presentation/shared_widgets/textform_design.dart';

class SettingsScreen extends StatelessWidget{
  TextEditingController namecontroller=TextEditingController();
  TextEditingController phonecontroller=TextEditingController();
  TextEditingController emailcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 30,),
            TextFormDesign(validate: (value){

            }, controller: namecontroller, labeltext: 'Name', type:TextInputType.text, ),
            SizedBox(height: 15,),
            TextFormDesign(validate: (value){}, controller: phonecontroller, labeltext: 'Phone', type: TextInputType.phone),
            SizedBox(height: 15,),
            TextFormDesign(validate: (value){}, controller: emailcontroller, labeltext: 'Email', type: TextInputType.text),
          ],
        ),
      );
  }



}