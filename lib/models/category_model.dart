import 'dart:developer';

class CategoryModel{

  String name;
  String? id;
  String urlimage;
  bool isFavourite;
  CategoryModel({required this.name,required this.urlimage,this.id, this.isFavourite = false});
  Map<String,dynamic> toMap(){
    return{
      "name":name,
      "urlimage":urlimage,
      "isFavourite":isFavourite,

    };

  }

   factory CategoryModel.fromeMap(Map<String,dynamic> map){
    CategoryModel categoryModel =  CategoryModel(
        name: map["name"] ,
        urlimage: map["urlimage"],
        isFavourite:map["isFavourite"]
    );
    return categoryModel;
  }

}