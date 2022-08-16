import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constants/constants.dart';
import 'package:shop_app/constants/end_points.dart';
import 'package:shop_app/data/local/cache_helper.dart';
import 'package:shop_app/data/models/categories_model.dart';
import 'package:shop_app/data/models/change_favorites_model.dart';
import 'package:shop_app/data/models/favorites_model.dart';
import 'package:shop_app/data/models/home_model.dart';
import 'package:shop_app/data/models/login_model.dart';
import 'package:shop_app/data/models/register_model.dart';
import 'package:shop_app/data/models/search_model.dart';
import 'package:shop_app/data/models/update_model.dart';
import 'package:shop_app/data/remote/dio_helper.dart';
import 'package:shop_app/presentation/screens/home/home_screen.dart';
import 'package:shop_app/presentation/screens/home/widgets/categories/categories_widget.dart';
import 'package:shop_app/presentation/screens/home/widgets/favorites/favorites_widget.dart';
import 'package:shop_app/presentation/screens/home/widgets/product/product_widget.dart';
import 'package:shop_app/presentation/screens/home/widgets/settings/settings_widget.dart';
import 'package:shop_app/presentation/screens/login/login_screen.dart';
import 'package:shop_app/presentation/shared_widgets/toast.dart';

import 'appstates.dart';


class AppCubit extends Cubit<Appstates>{
  AppCubit(): super(AppInialState());
   HomeModel? homeModel;
   Map<int,bool>favorites={};
  int currentindex=0;


  void changeBottomNavState(index){
    currentindex=index;
    emit(AppBottomNavState());
  }
  List<Widget>bottomScreens=[ProductScreen(),CategoriesScreen(),FavoritesScreen(),SettingsScreen()];

  void getHomeData(){
     DioHelper.getData(path: HOME,token: token).then((value){
       homeModel=HomeModel.fromJson(value.data);
       print(homeModel?.data?.products?.length);
       homeModel?.data?.products?.forEach((element) {

           favorites.addAll({
             element.id!: element.inFovrites!
           });

       });
       print(favorites.toString()
       );

       emit(AppHomeDataSucessState());

     }).catchError((error){
       print(error.toString());
       emit(AppHomeDataErorrState());
     });
  }
   CategoriesModel? categoriesModel;
  void getCategoriesData(){
    DioHelper.getData(path:CATEGORIES).then((value){
      categoriesModel=CategoriesModel.fromJson(value.data);
      print(categoriesModel?.status);
      emit(AppCategoriesDataSucessState());
    }).catchError((erorr){
      print(erorr.toString());
      emit(AppCategoriesDataErorrState());
    });
  }


   FavoritesModel? favoritesModel;
  void getFavoritesData(){
    emit(AppFavoritesDataLoadState());
    DioHelper.getData(path:FAVORITES,token: token).then((value){
      favoritesModel=FavoritesModel.fromJson(value.data);
      print(favoritesModel?.status);
      emit(AppFavritesDataSucessState());
    }).catchError((erorr){
      print(erorr.toString());
      emit(AppFavoritesDataErorrState());
    });
  }
  ChangeFavModel? changeFavModel;
  void addOrDelteToFavorite(int? id){
    changeProductState(id!);

    DioHelper.postData(data: {
      'product_id':id
    }, path: FAVORITES,token: token).then((value){
        changeFavModel=ChangeFavModel.fromJson(value.data);
        print(changeFavModel?.message.toString());
        if(changeFavModel?.status==true){
        getFavoritesData();}else{changeProductState(id);
        toast(message: changeFavModel?.message.toString()??'');
        }
      emit(AppFavritesDataSucessState());
    }).catchError((erorr){

      print(erorr.toString());
      emit(AppFavAddOrDeleteErorrState());
    });
  }
  void changeProductState(int id){
    favorites[id]=!favorites[id]!;
    emit(AppChangeProductState());
  }
  LoginModel? userProfile;
  void getUserProfile(){
    DioHelper.getData(path: PROFILE,token: token).then((value){
      userProfile=LoginModel.fromjson(value.data);
      emit(AppGetProfileSucessState());
    }).catchError((error){
      emit(AppGetProfileErrorState());
    });
  }
  void logOutProfile(BuildContext context){
    DioHelper.postData(data: {
      'fcm_token':token
    }, path:LOGOUT).then((value){
      CacheHelper.removeData(key: 'token');
      Navigator.pushReplacementNamed(context, LoginScreen.ROUTE_NAME);
      emit(AppLogoutSucessState());
    }).catchError((error){
      emit(AppLogoutErroeState());
    });
  }
  UpdateModel? updateModel;
void updateUser({String? name,String? phone, String? email}){
  emit(AppUpdateLoadState());
    DioHelper.putData(data:{
      'name':name,
      'phone':phone,
      'email':email,

    }, path: UPDATE,token:token).then((value){
      updateModel=UpdateModel.fromJson(value.data);
      if(updateModel?.status==true){
        toast(message: updateModel?.message.toString()??'');

        getUserProfile();
        emit(AppUpdateSucessState());
      }else{
        toast(message: updateModel?.message.toString()??'');
        emit(AppUpdateErrorState());
      }
    }).catchError((error){
    toast(message:error.toString());
    emit(AppUpdateErrorState());

    });
}



}