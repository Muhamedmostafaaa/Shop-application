import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app/business_logic/register_cuibt/registerstates.dart';
import 'package:shop_app/constants/end_points.dart';
import 'package:shop_app/data/local/cache_helper.dart';
import 'package:shop_app/data/models/Register_model.dart';
import 'package:shop_app/data/remote/dio_helper.dart';
import 'package:shop_app/presentation/screens/home/home_screen.dart';
import 'package:shop_app/presentation/screens/onboard/onboard_screen.dart';

import '../../constants/constants.dart';
import '../../presentation/shared_widgets/toast.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  bool isskiponboard=false;



   static RegisterCubit getinstance(context)=>BlocProvider.of<RegisterCubit>(context);
   RegisterModel? registerModel;
  void registerUser({required String name,required String email,required String phone,required String password,required BuildContext context}){
    DioHelper.postData(data: {
      'name':name,
      'phone':phone,
      'email':email,
      'password':password,
    }, path: REGISTER).then((value){
      registerModel=RegisterModel.fromjson(value.data);
      if(registerModel?.status==true){
        CacheHelper.putData(key: 'token', value: registerModel?.data?.token.toString());
        token=registerModel?.data?.token??'';
        Navigator.pushReplacementNamed(context, HomeScreen.ROUTE_NAME);
        emit(RegisterSucessState());

      }else{
        print(registerModel?.message.toString());
        emit(RegisterErrorState(error:registerModel?.message.toString()));};

    }).catchError((erorr) {
      print(erorr.toString());
      emit(RegisterErrorState(error: erorr));
    });
  }
}
