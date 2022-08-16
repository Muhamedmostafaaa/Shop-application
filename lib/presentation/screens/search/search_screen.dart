import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/business_logic/appcubit/appcubit.dart';
import 'package:shop_app/business_logic/appcubit/appstates.dart';
import 'package:shop_app/business_logic/search_cubit/searchcubit.dart';
import 'package:shop_app/business_logic/search_cubit/searchstates.dart';
import 'package:shop_app/presentation/shared_widgets/textform_design.dart';

import '../../styles/colors.dart';

class SearchScreen extends StatelessWidget {
  static const String ROUTE_NAME = 'searchscreen';
  TextEditingController searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BlocProvider.of<SearchCubit>(context);
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,

                  children: [
                    Align(alignment: Alignment.topLeft,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back,)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormDesign(
                        sufffixicon: InkWell(onTap: (){
                            cubit.searchProducts(text: searchcontroller.text);

                        },
                            child: Icon(Icons.search)),
                        validate: (value) {},
                        controller: searchcontroller,
                        labeltext: 'Search',
                        type: TextInputType.text),
                    SizedBox(height: 10,),
                    if(state is SearchLoadState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                     if(state is SearchSucessState)
                     Expanded(
                          child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    height: 120,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Container(height: 120,

                                            child: Image(fit: BoxFit.contain,
                                              image: NetworkImage(
                                                cubit.searchModel?.data?.data[index]
                                                        .image
                                                        .toString() ??
                                                    '',
                                              ),
                                              height: 120,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                cubit.searchModel?.data?.data[index]
                                                        .name
                                                        .toString() ??
                                                    '',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    '${cubit.searchModel?.data?.data[index].price}',
                                                    style: TextStyle(
                                                        color: AppColors.primary),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),

                                                  Spacer(),
                                                  IconButton(
                                                      onPressed: () {
                                                        // cubit.addOrDelteToFavorite(
                                                        //     cubit.searchModel?.data
                                                        //         ?.data[index].id);
                                                        // //cubit.getFavoritesData();
                                                      },
                                                      icon: CircleAvatar(
                                                          radius: 50,
                                                          backgroundColor:
                                                              Colors.grey,
                                                          child: Icon(
                                                            Icons.favorite_border,
                                                            size: 20,
                                                            color: Colors.white,
                                                          )))
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider(
                                  color: Colors.grey,
                                );
                              },
                              itemCount: cubit.searchModel?.data?.data.length ?? 0,
                            ),
                        )

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
