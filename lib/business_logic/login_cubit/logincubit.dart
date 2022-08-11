import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/business_logic/login_cubit/loginstates.dart';
import 'package:shop_app/constants/end_points.dart';
import 'package:shop_app/data/local/cache_helper.dart';
import 'package:shop_app/data/models/login_model.dart';
import 'package:shop_app/data/remote/dio_helper.dart';
import 'package:shop_app/presentation/screens/home/home_screen.dart';
import 'package:shop_app/presentation/screens/login/login_screen.dart';
import 'package:shop_app/presentation/screens/onboard/onboard_screen.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  late  LoginModel loginModel;
  bool isskiponboard=false;



   static LoginCubit getinstance(context)=>BlocProvider.of<LoginCubit>(context);
  void userLoginData({required String email, required String password, required BuildContext context}) {
    emit(LoginLoadingState());
    DioHelper.postData(
            data: {'email':email,
              'password': password}, path: LOGIN)
        .then((value) {
      loginModel = LoginModel.fromjson(value.data);
      if(loginModel.status==true){
        CacheHelper.putData(key: 'token', value: loginModel.data?.token.toString());
        Navigator.pushReplacementNamed(context, HomeScreen.ROUTE_NAME);
        emit(LoginSucessState(model:loginModel));

      }else{
        emit(LoginErrorState(error:loginModel.message));};

    }).catchError((erorr) {
      print(erorr.toString());
      emit(LoginErrorState(error: erorr));
    });
  }
}
