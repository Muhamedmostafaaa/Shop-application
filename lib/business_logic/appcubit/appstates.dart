import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

abstract class Appstates{}
class AppInialState extends Appstates{}
class AppHomeDataSucessState extends Appstates{}
class AppHomeDataErorrState extends Appstates{}
class AppHomeDataLoadState extends Appstates{}
class AppBottomNavState extends Appstates{}
class AppCategoriesDataSucessState extends Appstates{}
class AppCategoriesDataErorrState extends Appstates{}
class AppCategoriesDataLoadState extends Appstates{}
class AppFavritesDataSucessState extends Appstates{}
class AppFavoritesDataLoadState extends Appstates{}
class AppFavoritesDataErorrState extends Appstates{}
class AppFavAddOrDeleteSucessStata extends Appstates{}
class AppFavAddOrDeleteErorrState extends Appstates{}
class AppChangeFavState extends Appstates{}
