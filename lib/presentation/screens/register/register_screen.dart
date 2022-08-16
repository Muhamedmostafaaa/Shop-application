import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/business_logic/appcubit/appcubit.dart';
import 'package:shop_app/business_logic/appcubit/appstates.dart';
import 'package:shop_app/business_logic/register_cuibt/registercubit.dart';
import 'package:shop_app/business_logic/register_cuibt/registerstates.dart';
import 'package:shop_app/presentation/screens/login/login_screen.dart';
import 'package:shop_app/presentation/styles/colors.dart';

import '../../shared_widgets/textform_design.dart';

class RegisterScreen extends StatelessWidget {
  static const String ROUTE_NAME = 'registerscreen';
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BlocProvider.of<RegisterCubit>(context);
          return Scaffold(resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 60,
                                        ),
                    Text('Register',style:TextStyle(fontSize:35,fontWeight: FontWeight.bold ),),
                    SizedBox(height: 40,),
                    Form(
                      key: formkey,
                      child: Column(
                        children: [
                          TextFormDesign(prefixicon: Icon(Icons.person),
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Name';
                              }
                            },
                            controller: namecontroller,
                            labeltext: 'Name',
                            type: TextInputType.text,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormDesign(prefixicon: Icon(Icons.phone),
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Phone';
                                }
                              },
                              controller: phonecontroller,
                              labeltext: 'Phone',
                              type: TextInputType.phone),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormDesign(prefixicon: Icon(Icons.email),
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Email';
                                }
                              },
                              controller: emailcontroller,
                              labeltext: 'Email',
                              type: TextInputType.text),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormDesign(sufffixicon: Icon(Icons.visibility_off),
                              prefixicon: Icon(Icons.password_outlined),issecured: true,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Password';
                                }
                              },
                              controller: passwordcontroller,
                              labeltext: 'Password',
                              type: TextInputType.text),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            cubit.registerUser(
                                name: namecontroller.text,
                                email: emailcontroller.text,
                                phone: phonecontroller.text,
                                password: passwordcontroller.text,
                                context: context);
                          }
                        },
                        child: Text('Register',style: TextStyle(fontSize:20),),
                      ),
                    ),
                    SizedBox(height: 20,),

                    InkWell(onTap: (){
                      Navigator.pushReplacementNamed(context, LoginScreen.ROUTE_NAME);
                    },
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Aleardy Have Account?',style: TextStyle(fontSize: 16),),
                          SizedBox(width: 5,),
                          Text('Login',style: TextStyle(color: AppColors.primary,fontSize: 16),),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
