class HomeModel{
  bool? status;
  DataModel? data;
HomeModel.fromJson(Map<String,dynamic>json){
  status=json['status'];
  data=DataModel.fromJson(json['data']);

}
}
class DataModel {
  List<BannerModel>?banners=[];
  List<ProductModel>?products=[];
DataModel.fromJson(Map<String,dynamic>json){
  json['banners'].forEach((elment){
    banners?.add(BannerModel.fromJson(elment));

  });
  json['products'].forEach((elment){
    products?.add(ProductModel.fromJson(elment));

  });




}
}
class BannerModel{
  int? id;
  String? image;
  BannerModel.fromJson(Map<String,dynamic>json){
    id=json['id'];
    image=json['image'];
  }
}
class  ProductModel{
  int? id;
  dynamic price;
  dynamic discount;
  dynamic oldprice;
  String? image;
  String? name;
  bool? inFovrites;
  bool? inCart;
  ProductModel.fromJson(Map<String,dynamic>json){
    id=json['id'];
    price=json['price'];
    discount=json['discount'];
    oldprice=json['old_price'];
    image=json['image'];
    name=json['name'];
    inFovrites=json['in_favorites'];
    inCart=json['in_cart'];

  }

}