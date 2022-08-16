import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/business_logic/search_cubit/searchstates.dart';

import '../../constants/constants.dart';
import '../../constants/end_points.dart';
import '../../data/models/search_model.dart';
import '../../data/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{
SearchCubit(): super(SearchInitialState());
SearchModel? searchModel;
void searchProducts({required String text}){
  emit(SearchLoadState());
  DioHelper.postData(data: {
    'text':text
  }, path: Search,token: token).then((value){
    searchModel=SearchModel.fromJson(value.data);
    emit(SearchSucessState());
  }).catchError((error){
    emit(SearchErrorState());
  });
}
}