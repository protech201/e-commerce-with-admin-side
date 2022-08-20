import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myecommerce/data/product_firestore_helper.dart';
import 'package:myecommerce/provider/Product_firestore_provaider.dart';
import 'package:myecommerce/views/navigation/router.dart';
import 'package:provider/provider.dart';


import '../data/category_firestore_helper.dart';
import '../data/storge_helper.dart';
import '../models/category_model.dart';


class CategoryFirestoreProvaider extends ChangeNotifier{
  GlobalKey<FormState> cateKey = GlobalKey();
  CategoryFirestoreProvaider(){
    getAllCategories();
  }


  File? selectedImage;
  TextEditingController categoryNameController = TextEditingController();
  List<CategoryModel> categores = [];
  List<CategoryModel> categoresLike = [];



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


  addNewCategory()async{
    if(selectedImage != null && cateKey.currentState!.validate()){
      String imageUrl = await StorgeHelper.storgeHelper.uplodImage(selectedImage!);
      CategoryModel  categoryModel = CategoryModel(name: categoryNameController.text, urlimage: imageUrl);
      CategoryModel newCategory = await CategoryFirestoreHelper.categoryFirestoreHelper.addNewCategory(categoryModel);
      categores.add(newCategory);
      categoryNameController.clear();
      selectedImage = null;
      notifyListeners();
    }
  }

  Future<List<CategoryModel>> getAllCategories()async{
    categores = await CategoryFirestoreHelper.categoryFirestoreHelper.getAllCategories();
    categoresLike = categores.where((element) => element.isFavourite).toList();

    notifyListeners();

    return categores;
  }

  deletCategory(CategoryModel categoryModel){
    CategoryFirestoreHelper.categoryFirestoreHelper.deletCategory(categoryModel);
    categores.remove(categoryModel);
    notifyListeners();
  }


  upDateCategory(CategoryModel categoryModel) async {
    String? url;
    if(selectedImage != null){
      url = await StorgeHelper.storgeHelper.uplodImage(selectedImage!);
    }
    CategoryModel newcategory = CategoryModel(
        name: categoryNameController.text,
        urlimage: url??categoryModel.urlimage,
        id: categoryModel.id,
    );
    CategoryFirestoreHelper.categoryFirestoreHelper.upDateCategory(newcategory);
    getAllCategories();
    notifyListeners();
  }

  upDateCategoryLike(CategoryModel categoryModel) async {
    categoryModel.isFavourite = !categoryModel.isFavourite;
    await CategoryFirestoreHelper.categoryFirestoreHelper.upDateCategory(categoryModel);
    categoresLike = categores.where((element) => element.isFavourite).toList();

    notifyListeners();
  }
  
  





}