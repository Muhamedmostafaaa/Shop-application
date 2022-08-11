import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/business_logic/appcubit/appcubit.dart';
import 'package:shop_app/business_logic/appcubit/appstates.dart';
import 'package:shop_app/presentation/styles/colors.dart';

class FavoritesScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,Appstates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=BlocProvider.of<AppCubit>(context);
        return ConditionalBuilder(
          condition: cubit.favoritesModel!=null,
          builder:(context)=> ListView.separated(physics: BouncingScrollPhysics(),
              itemBuilder:(context,index){
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(height: 120,
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Stack(alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Image(
                          image: NetworkImage(cubit.favoritesModel?.data?.data[index].product?.image.toString()??'',),
                          height: 120,

                        ),
                        cubit.favoritesModel?.data?.data[index].product?.discount!=0?Container(padding: EdgeInsets.all(5),
                          color: Colors.red,child: Text('Discount',style: TextStyle(color: Colors.white,fontSize: 10),),):Container()
                      ],
                    ),SizedBox(width: 20,),
                        Expanded(
                          child: Column(mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(cubit.favoritesModel?.data?.data[index].product?.name.toString()??'',maxLines: 2,overflow: TextOverflow.ellipsis,),
                              SizedBox(height: 20,),
                              Row(
                                children: [
                                  Text('${cubit.favoritesModel?.data?.data[index].product?.price}',style: TextStyle(color:AppColors.primary),),
                                 SizedBox(width: 20,),
                                  Text('${cubit.favoritesModel?.data?.data[index].product?.oldprice}',style: TextStyle(color: Colors.grey,decoration: TextDecoration.lineThrough)),
                                  Spacer(),
                                  IconButton(onPressed: (){
                                    cubit.addOrDelteToFavorite(cubit.favoritesModel?.data?.data[index].product?.id);
                                    cubit.getFavoritesData();
                                  }, icon:CircleAvatar(radius: 50,
                                      child: Icon(Icons.favorite_border,size: 20,)))
                                ],
                              )


                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                );

              }, separatorBuilder: (context,index){
                return Divider(
                  color: Colors.grey,
                );
              }, itemCount:cubit.favoritesModel?.data?.data.length??0,),
          fallback: (context)=>Center(child: CircularProgressIndicator(),),
        );
      },
     
    );
  }



}