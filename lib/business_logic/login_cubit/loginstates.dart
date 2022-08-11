import 'package:shop_app/data/models/login_model.dart';

abstract class LoginStates{}
class LoginInitialState extends LoginStates{}
class LoginSucessState extends LoginStates{
  LoginModel? model;
  LoginSucessState({this.model});
}
class LoginErrorState extends LoginStates{
  final error;
  LoginErrorState({required this.error});
}
class LoginLoadingState extends LoginStates{}