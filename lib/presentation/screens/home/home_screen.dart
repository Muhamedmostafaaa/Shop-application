import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/business_logic/appcubit/appcubit.dart';
import 'package:shop_app/business_logic/appcubit/appstates.dart';
import 'package:shop_app/data/local/cache_helper.dart';
import 'package:shop_app/presentation/screens/login/login_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String ROUTE_NAME = 'homescreen';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, Appstates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<AppCubit>(context);
        return Scaffold(
          appBar: AppBar(
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
            title: Text(
              'Salla',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.transparent,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 30,
                ),
              )
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentindex,
            onTap: (index) {
              cubit.changeBottomNavState(index);
            },
            type: BottomNavigationBarType.fixed,
            elevation: 100,
            backgroundColor: Color(0XFFF5F5F5),
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: 'categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'favorites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'settings'),
            ],
          ),
        body: cubit.bottomScreens[cubit.currentindex],
        );
      },
    );
  }
}
