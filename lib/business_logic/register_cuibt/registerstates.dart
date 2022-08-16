import 'package:shop_app/data/models/Register_model.dart';

abstract class RegisterStates{}
class RegisterInitialState extends RegisterStates{}
class RegisterSucessState extends RegisterStates{
  RegisterModel? model;
  RegisterSucessState({this.model});
}
class RegisterErrorState extends RegisterStates{
  final error;
  RegisterErrorState({required this.error});
}
class RegisterLoadingState extends RegisterStates{}