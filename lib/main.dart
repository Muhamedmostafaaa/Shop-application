import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/business_logic/appcubit/appcubit.dart';
import 'package:shop_app/business_logic/appcubit/appstates.dart';
import 'package:shop_app/business_logic/login_cubit/logincubit.dart';
import 'package:shop_app/data/local/cache_helper.dart';
import 'package:shop_app/data/remote/dio_helper.dart';
import 'package:shop_app/presentation/screens/home/home_screen.dart';
import 'package:shop_app/presentation/screens/login/login_screen.dart';
import 'package:shop_app/presentation/screens/onboard/onboard_screen.dart';

import 'business_logic/bloc_observer.dart';
import 'constants/constants.dart';

void main(){BlocOverrides.runZoned(
      () async
      {
        WidgetsFlutterBinding.ensureInitialized();
       await CacheHelper.init();
        DioHelper.init();
          bool bording=CacheHelper.getData(key:'onboard')??false;
           token=CacheHelper.getData(key: 'token')??'';
        Widget getScreenToShow(){
          if(bording==true){
            if(token.isNotEmpty){
            return HomeScreen();
            }else{
              return LoginScreen();
            }
          }else{
            return OnBoardScreen();
          }
        }

        runApp(myapp(bording,getScreenToShow));
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(

            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark// status bar color
        ));
  },
  blocObserver: MyBlocObserver(),
);

}
class myapp extends StatelessWidget{
  bool boarding;
  Widget Function() screentoshow;
  myapp(this.boarding,this.screentoshow);
  @override
  Widget build(BuildContext context) {
   return BlocProvider(create: (context)=> AppCubit()..getHomeData()..getCategoriesData()..getFavoritesData(),
     child: BlocConsumer<AppCubit,Appstates>(
       listener: (context,state){},
       builder: (context,state){
         return MaterialApp(

           theme: ThemeData(
               appBarTheme: AppBarTheme(color: Colors.transparent,elevation: 0),
               scaffoldBackgroundColor: Colors.white

           ),
           home:screentoshow()
           ,routes: {
           LoginScreen.ROUTE_NAME:(context)=>LoginScreen(),
           HomeScreen.ROUTE_NAME:(context)=>HomeScreen()
         },
         );
       },

     ),
   );
  }


}
