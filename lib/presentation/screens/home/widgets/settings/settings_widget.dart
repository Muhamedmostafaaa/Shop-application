import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/business_logic/appcubit/appcubit.dart';
import 'package:shop_app/business_logic/appcubit/appstates.dart';
import 'package:shop_app/presentation/shared_widgets/textform_design.dart';

class SettingsScreen extends StatelessWidget{
  TextEditingController namecontroller=TextEditingController();
  TextEditingController phonecontroller=TextEditingController();
  TextEditingController emailcontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<AppCubit,Appstates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit= BlocProvider.of<AppCubit>(context);
          final formkey=GlobalKey<FormState>();
          namecontroller.text=cubit.userProfile?.data?.name??'';
          phonecontroller.text=cubit.userProfile?.data?.phone??'';
          emailcontroller.text=cubit.userProfile?.data?.email??'';
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is AppUpdateLoadState)
                  LinearProgressIndicator()
                ,
                SizedBox(height: 30,),
                Form(key: formkey,
                  child: Column(
                    children: [
                      TextFormDesign(prefixicon: Icon(Icons.person),
                        validate: (value){
                        if(value!.isEmpty){
                          return 'please enter name';
                        }

                      }, controller: namecontroller, labeltext: 'Name', type:TextInputType.text, ),
                      SizedBox(height: 15,),
                      TextFormDesign(prefixicon: Icon(Icons.phone),
                          validate: (value){
                        if(value!.isEmpty){
                          return 'please enter phone';
                        }
                      }, controller: phonecontroller, labeltext: 'Phone', type: TextInputType.phone),
                      SizedBox(height: 15,),
                      TextFormDesign(prefixicon: Icon(Icons.email),
                          validate: (value){
                        if(value!.isEmpty){
                          return 'please enter email';
                        }
                      }, controller: emailcontroller, labeltext: 'Email', type: TextInputType.text),
                    ],
                  ),
                ),
                SizedBox(height: 25,),
                Container(height: 45,width: double.infinity,
                    child: ElevatedButton(onPressed: (){
                      cubit.logOutProfile(context);
                      cubit.currentindex=0;
                    }, child: Text('logout',style:TextStyle(fontSize:20),))),
                SizedBox(height: 30,),
                Container(height: 45,width: double.infinity,
                    child: ElevatedButton(onPressed: (){
                      if(formkey.currentState!.validate()){
                        cubit.updateUser(phone: phonecontroller.text,email: emailcontroller.text,name: namecontroller.text);
                      }


                    }, child: Text('Update',style:TextStyle(fontSize:20),))),
              ],
            ),
          );

        },

      );
  }



}