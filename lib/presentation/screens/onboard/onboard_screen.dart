import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data/local/cache_helper.dart';
import 'package:shop_app/presentation/screens/login/login_screen.dart';
import 'package:shop_app/presentation/screens/onboard/widgets/pageview_builder.dart';
import 'package:shop_app/presentation/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../data/models/onboard_model.dart';

class OnBoardScreen extends StatefulWidget{

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  PageController controller=PageController();
  int currentindex=0;
  List<OnBoardModel>list=[
    OnBoardModel(imagepath: 'assets/images/shop.png', body: 'on board 1 body', tittle: 'On Board 1 tittle'),
    OnBoardModel(imagepath: 'assets/images/shop2.png', body: 'on board 2 body', tittle: 'On Board 2 tittle'),
    OnBoardModel(imagepath: 'assets/images/shop3.png', body: 'on board 3 body', tittle: 'On Board 3 tittle'),
  ];

  @override
  Widget build(BuildContext context) {
   return
      Scaffold(appBar: AppBar(actions: [
       TextButton(onPressed: (){
         CacheHelper.putData(key: 'onboard', value: true).then((value){
           Navigator.pushReplacementNamed(context, LoginScreen.ROUTE_NAME);
         }).catchError((error){
           print(error.toString());
         });

       }, child: Text('Skip',style: TextStyle(color: AppColors.primary,fontSize: 18),))
     ],backgroundColor: Colors.transparent,systemOverlayStyle: SystemUiOverlayStyle.dark,),
       body: Column(

         children: [


           Expanded(
             child: PageView.builder(physics: BouncingScrollPhysics(),
               onPageChanged: (index){
                     currentindex=index;
             },
               controller:controller ,
               itemBuilder: (context,index)=>
               PageViewDesign(page: list[index]),itemCount: 3,
             ),
           ),
           SizedBox(height: 30,),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
             child: Row(
               children: [
                 SmoothPageIndicator(
                     controller: controller,  // PageController
                     count:  list.length,
                     effect:  WormEffect(
                       activeDotColor:AppColors.primary,

                     ),  // your preferred effect
                     onDotClicked: (index){

                     }
                 ),Spacer(),
                 FloatingActionButton(onPressed:(){
if(currentindex==list.length-1){
  CacheHelper.putData(key: 'onboard', value: true).then((value){
    Navigator.pushReplacementNamed(context, LoginScreen.ROUTE_NAME);
  }).catchError((error){
    print(error.toString());
  });
}
                     controller.nextPage(duration: Duration(milliseconds:750), curve: Curves.linearToEaseOut);


                 },child: Icon(Icons.arrow_forward_ios),backgroundColor:AppColors.primary,)
               ],
             ),
           )
         ],
       ),


   );
  }
}