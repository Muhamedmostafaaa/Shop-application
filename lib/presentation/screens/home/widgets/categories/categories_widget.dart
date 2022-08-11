import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/business_logic/appcubit/appcubit.dart';
import 'package:shop_app/business_logic/appcubit/appstates.dart';

class CategoriesScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return

       BlocConsumer<AppCubit,Appstates>(
         listener: (context,state){},
         builder: (context,state){
           var cubit=BlocProvider.of<AppCubit>(context);
           return ConditionalBuilder(
             condition: cubit.categoriesModel!=null,
             builder:(context)=> ListView.separated(physics: BouncingScrollPhysics(),
                 itemBuilder:(context,index){
               return Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: Row(
                   children: [
                     Image(height: 120,width: 120,
                       image: NetworkImage(cubit.categoriesModel?.data?.data[index].image.toString()??''),

                     ),SizedBox(width: 20,),
                     Text(cubit.categoriesModel?.data?.data[index].name.toString()??''),
                     Spacer(),
                     Icon(Icons.arrow_forward_ios)
                   ],
                 ),
               );

             }, separatorBuilder: (context,index){
               return Divider(
                 color: Colors.grey,
               );
             }, itemCount:cubit.categoriesModel?.data?.data.length??0,),
             fallback: (context)=>Center(child: CircularProgressIndicator(),),
           );
         },

       );

  }



}