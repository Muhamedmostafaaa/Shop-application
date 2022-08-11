import 'package:dio/dio.dart';
import 'package:shop_app/constants/end_points.dart';
import 'package:shop_app/data/models/login_model.dart';

class DioHelper{
  static late Dio dio;
  static void init(){
    dio=Dio(BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,


    ));
  }
  static Future<Response> getData({required String path,String lang:'en',String? token})async{
    dio.options.headers={
      'lang':lang,
      'Authorization':token,
      'Content-Type':'application/json'
    };
   return await dio.get(path);
  }
  static Future<Response> postData({var query,required var data,required String path,String lang:'en',String? token})async{
    dio.options.headers={
      'lang':lang,
      'Authorization':token,
      'Content-Type':'application/json'

    };
     return await dio.post(path,data:data,queryParameters:query  );
  }
}