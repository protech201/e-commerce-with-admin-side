class ProductModel{

   String? id;
   String title, description;
   String image;
   String  price;
   bool isFavourite;
   String? catId;
  ProductModel({
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    this.isFavourite = false,
    this.id,
    this.catId
  });

  Map<String,dynamic> toMap(){
    return {
      "title":title,
      "description":description,
      "image":image,
      "price":price,
      "catId":catId
    };
  }

  factory ProductModel.fromeMap(Map<String , dynamic> map){
    ProductModel productModel =  ProductModel(
      title: map["title"] ,
      description: map["description"] ,
      image: map["image"] ,
      price: map["price"] ,
        catId:map["catId"]
    );
    return productModel;
  }

}