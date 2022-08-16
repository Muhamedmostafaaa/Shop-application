import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/business_logic/login_cubit/logincubit.dart';
import 'package:shop_app/business_logic/login_cubit/loginstates.dart';
import 'package:shop_app/presentation/screens/home/home_screen.dart';
import 'package:shop_app/presentation/shared_widgets/textform_design.dart';
import 'package:shop_app/presentation/shared_widgets/toast.dart';

import '../register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String ROUTE_NAME = 'loginscreen';
  TextEditingController emailcontrooler = TextEditingController();
  TextEditingController passwordcontrooler = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if(state is LoginSucessState){
            toast(message: state.model!.message.toString());

          }else if(state is LoginErrorState){
          toast(message:state.error.toString());

          }
        },
        builder: (context, state) {
          var cubit = BlocProvider.of<LoginCubit>(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 200,
                      ),
                      Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 36, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        'login now to browse our hot offers',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormDesign(
                        controller: emailcontrooler,
                        labeltext: 'Email Address',
                        type: TextInputType.text,
                        prefixicon: Icon(Icons.email),
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Email Address';
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormDesign(
                        controller: passwordcontrooler,
                        labeltext: 'Password',
                        type: TextInputType.number,
                        prefixicon: Icon(Icons.lock),
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Password';
                          }
                        },
                        sufffixicon: Icon(Icons.visibility_off),
                        issecured: true,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                          height: 50,
                          child: ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context) => ElevatedButton(
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    cubit.userLoginData(
                                        email: emailcontrooler.text,
                                        password: passwordcontrooler.text,
                                    context: context);



                                  }
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(fontSize: 20),
                                )),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: InkWell(onTap: (){
                          Navigator.pushNamed(context, RegisterScreen.ROUTE_NAME);
                        },
                          child: RichText(
                            text: TextSpan(
                                text: 'Dont have account? ',
                                style:
                                    TextStyle(fontSize: 16, color: Colors.black),
                                children: [
                                  TextSpan(
                                      text: 'Register',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.blue))
                                ]),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
