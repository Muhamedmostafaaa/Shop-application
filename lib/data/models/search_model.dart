

class SearchModel {
bool? status;
SearchData? data;
SearchModel.fromJson(Map<String,dynamic>json){
  status=json['status'];
  data=SearchData.fromJson(json['data']);
}
}
class SearchData{
List<SearchProductData>data=[];
SearchData.fromJson(Map<String,dynamic>json){
  json['data'].forEach((elment){
    data.add(SearchProductData.fromJson(elment));
  }

  );
}
}
class SearchProductData{
int? id;
dynamic price;
String? image;
String? name;
dynamic oldprice;
dynamic discount;
SearchProductData.fromJson(Map<String,dynamic>json){
  id=json['id'];
  price=json['price'];
  image=json['image'];
  name=json['name'];
  discount=json['discount'];
  oldprice=json['old_price'];
}
}