import 'package:shop_app/data/models/categories_model.dart';

class FavoritesModel{
bool? status;
FavoritesData? data;
FavoritesModel.fromJson(Map<String,dynamic>json){
  status=json['status'];
  data= FavoritesData.fromJson(json['data']);
}
}
class FavoritesData{
List<FavoriteProductData>data=[];
FavoritesData.fromJson(Map<String,dynamic>json){
  json['data'].forEach((elemnt){
    data.add(FavoriteProductData.fromJson(elemnt));
  });
}
}
class FavoriteProductData{
  int? id;
  SingleFvaoriteProductData? product;
  FavoriteProductData.fromJson(Map<String,dynamic>json){
    id=json['id'];
    product= SingleFvaoriteProductData.fromJson(json['product']);

  }

}
class SingleFvaoriteProductData{
  int?id;
  dynamic price;
  dynamic oldprice;
  dynamic discount;
  String? image;
  String? name;
  SingleFvaoriteProductData.fromJson(Map<String,dynamic>json){
    id=json['id'];
    oldprice=json['old_price'];
    price=json['price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];

  }

}