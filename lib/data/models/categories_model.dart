class CategoriesModel{
  bool? status;
  Categoriesdata? data;
  CategoriesModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    data=json['data']!=null?Categoriesdata.fromJson(json['data']):null;
  }

}
class Categoriesdata{
   List<SingleCategoryData> data=[];
   Categoriesdata.fromJson(Map<String,dynamic>json){
     json['data'].forEach((element){
       data.add(SingleCategoryData.fromJson(element));
     });
   }
}
class SingleCategoryData{
  int? id;
  String? name;
  String? image;
  SingleCategoryData.fromJson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}