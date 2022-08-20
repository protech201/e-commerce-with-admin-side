
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myecommerce/models/product_model.dart';


import '../data/product_firestore_helper.dart';
import '../data/storge_helper.dart';
import '../models/category_model.dart';


class ProductFirestoreProvaider extends ChangeNotifier{
  GlobalKey<FormState> prodKey = GlobalKey();

  File? selectedImage;
  TextEditingController productTitleController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  // TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();

  List<ProductModel> products = [];
  List<ProductModel> faverot = [];


  nullvaliation(String? v){
    if(v == null || v.isEmpty){
      return"This field is required";
    }
  }

  selecteImageFun()async {
   XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
   selectedImage= File(xfile!.path);
   notifyListeners();
  }

  addNewProduct(String catId)async{
    if(selectedImage != null && prodKey.currentState!.validate()){
      String imageUrl = await StorgeHelper.storgeHelper.uplodImage(selectedImage!);
      ProductModel  productModel = ProductModel(
        price:productPriceController.text,
        image: imageUrl,
        title: productTitleController.text,
        description: productDescriptionController.text,
        catId: catId,
      );
      ProductModel newProduct = await ProductFirestoreHelper.productFirestoreHelper.addNewProduct(productModel);


      products.add(newProduct);
      // productTitleController.clear();
      selectedImage = null;
      notifyListeners();
    }
  }



  getAllProduct(String catId)async{
    products = await ProductFirestoreHelper.productFirestoreHelper.getAllProducts(catId);

    notifyListeners();
  }

  deletProduct(ProductModel productModel)async{
    await ProductFirestoreHelper.productFirestoreHelper.deletProduct(productModel);
    products.remove(productModel);
    notifyListeners();
  }

  upDateProduct(ProductModel productModel) async {
    String? url;
    if(selectedImage != null){
      url = await StorgeHelper.storgeHelper.uplodImage(selectedImage!);
    }
    ProductModel newProduct = ProductModel(
        id: productModel.id,
        title: productTitleController.text,
        description: productDescriptionController.text,
        image: url??productModel.image,
        price: productPriceController.text,
        catId: productModel.catId,
    );
    getAllProduct(productModel.catId!);
    ProductFirestoreHelper.productFirestoreHelper.updateProduct(newProduct);
    notifyListeners();
  }



















  //للفردي يعم
  //
  //
  // addNewProduct1()async{
  //   if(selectedImage != null && prodKey.currentState!.validate()){
  //     String imageUrl = await StorgeHelper.storgeHelper.uplodImage(selectedImage!);
  //     ProductModel  productModel = ProductModel(
  //       price:productPriceController.text,
  //       image: imageUrl,
  //       title: productTitleController.text,
  //       description: productDescriptionController.text,
  //
  //     );
  //     ProductModel newProduct = await ProductFirestoreHelper.productFirestoreHelper.addNewProduct1(productModel);
  //     products.add(newProduct);
  //     // productTitleController.clear();
  //     selectedImage = null;
  //     notifyListeners();
  //   }
  // }
  //
  //  getAllProduct1()async{
  //    products = await ProductFirestoreHelper.productFirestoreHelper.getAllProducts1();
  //
  //   notifyListeners();
  // }
  //
  // deletProduct1(ProductModel productModel){
  //   ProductFirestoreHelper.productFirestoreHelper.deletProduct1(productModel);
  //   products.remove(productModel);
  //   notifyListeners();
  // }
  //
  // upDateProduct1(ProductModel productModel) async {
  //   String? url;
  //   if(selectedImage != null){
  //      url = await StorgeHelper.storgeHelper.uplodImage(selectedImage!);
  //   }
  //   ProductModel newProduct = ProductModel(
  //       id: productModel.id,
  //       title: productTitleController.text,
  //       description: productDescriptionController.text,
  //       image: url??productModel.image,
  //       price: productPriceController.text
  //   );
  //   ;
  //   products[products.indexOf(productModel)] = newProduct;
  //
  //   ProductFirestoreHelper.productFirestoreHelper.upDateProduct1(newProduct);
  //   notifyListeners();
  // }
  //
  //
  //
  //
  //
}