import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constants/constants.dart';
import 'package:shop_app/constants/end_points.dart';
import 'package:shop_app/data/local/cache_helper.dart';
import 'package:shop_app/data/models/categories_model.dart';
import 'package:shop_app/data/models/favorites_model.dart';
import 'package:shop_app/data/models/home_model.dart';
import 'package:shop_app/data/remote/dio_helper.dart';
import 'package:shop_app/presentation/screens/home/widgets/categories/categories_widget.dart';
import 'package:shop_app/presentation/screens/home/widgets/favorites/favorites_widget.dart';
import 'package:shop_app/presentation/screens/home/widgets/product/product_widget.dart';
import 'package:shop_app/presentation/screens/home/widgets/settings/settings_widget.dart';

import 'appstates.dart';


class AppCubit extends Cubit<Appstates>{
  AppCubit(): super(AppInialState());
   HomeModel? homeModel;
  int currentindex=0;
  bool inFavorites=false;
  void changeFavState(){
    inFavorites=!inFavorites;
    emit(AppChangeFavState());

  }
  void changeBottomNavState(index){
    currentindex=index;
    emit(AppBottomNavState());
  }
  List<Widget>bottomScreens=[ProductScreen(),CategoriesScreen(),FavoritesScreen(),SettingsScreen()];

  void getHomeData(){
     DioHelper.getData(path: HOME,token: token).then((value){
       homeModel=HomeModel.fromJson(value.data);
       print(homeModel?.data?.products?.length);

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
  void addOrDelteToFavorite(int? id){
    DioHelper.postData(data: {
      'product_id':id
    }, path: FAVORITES,token: token).then((value){
      emit(AppFavritesDataSucessState());
    }).catchError((erorr){
      print(erorr.toString());
      emit(AppFavAddOrDeleteErorrState());
    });
  }
  

}