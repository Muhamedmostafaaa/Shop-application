import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/business_logic/appcubit/appcubit.dart';
import 'package:shop_app/business_logic/appcubit/appstates.dart';
import 'package:shop_app/data/models/categories_model.dart';
import 'package:shop_app/data/models/home_model.dart';
import 'package:shop_app/presentation/styles/colors.dart';

class ProductScreen extends StatefulWidget {
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, Appstates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<AppCubit>(context);
        final model = cubit.homeModel;
        return ConditionalBuilder(
          condition: cubit.homeModel != null&&cubit.categoriesModel!=null,
          builder: (context) => PageView(model!,cubit.categoriesModel,cubit),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget PageView(HomeModel? model,CategoriesModel? categoriesModel,AppCubit cuibt) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          CarouselSlider(
              items: model?.data?.banners
                  ?.map((e) => Image(
                        image: NetworkImage(e.image.toString()),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 200,
                aspectRatio: 16 / 9,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              )),
          SizedBox(
            height: 5,
          ),
          Container(height: 100,
              child: ListView.separated(scrollDirection:Axis.horizontal,
                  itemBuilder: (context,index){
                return Container(height: 100,width: 100,
                  child: Stack(alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Image(
                        image: NetworkImage(categoriesModel?.data?.data[index].image.toString()??''),
                        height: 80,

                      ),
                      true?Container(width:100,
                        decoration: BoxDecoration(color: Colors.black87,borderRadius: BorderRadius.circular(6)),

                        height: 20,
                        padding: EdgeInsets.all(5),
                        child: Text(categoriesModel?.data?.data[index].name.toString()??'',style: TextStyle(color: Colors.white,fontSize: 10,),textAlign: TextAlign.center,),):Container()
                    ],
                  ),
                );
              },itemCount: categoriesModel?.data?.data.length??0,separatorBuilder: (context,index){
                return SizedBox(width: 5,);
                },)),
          Container(color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio:1/1.58,
              children: List.generate(model?.data?.products!.length??0,
                  (index) => ItemBuilder(model?.data?.products?[index],cuibt)),
            ),
          )
        ],
      ),
    );
  }

  Widget ItemBuilder(ProductModel? model,AppCubit cubit) {
    bool favorite=false;
    return Container(color: Colors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model?.image.toString()??'',),
                height: 200,width:double.infinity,

              ),
              model?.discount!=0?Container(padding: EdgeInsets.all(5),
                color: Colors.red,child: Text('Discount',style: TextStyle(color: Colors.white,fontSize: 10),),):Container()
            ],
          ),
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model?.name??'',maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.w500),),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Text('${model?.price.round()}',style: TextStyle(color:AppColors.primary),),
                    SizedBox(width: 10,),
                    model?.discount!=0?Text('${model?.oldprice.round()}',style: TextStyle(color: Colors.grey,decoration: TextDecoration.lineThrough),):Container(),
                    Spacer(),
                    IconButton(onPressed: (){

                      cubit.addOrDelteToFavorite(model?.id??0);

                    }, icon:CircleAvatar(radius: 50,backgroundColor:favorite?AppColors.primary:Colors.grey,
                        child: Icon(Icons.favorite_border,size: 20,color: Colors.white,)))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
