import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myecommerce/models/category_model.dart';
import 'package:myecommerce/models/product_model.dart';

class CategoryFirestoreHelper{
  static CategoryFirestoreHelper categoryFirestoreHelper = CategoryFirestoreHelper();

  CollectionReference<Map<String, dynamic>> categoriesCollection = FirebaseFirestore.instance.collection("categories");


  Future<CategoryModel> addNewCategory(CategoryModel categoryModel) async {
    DocumentReference<Map<String, dynamic>> referense =await  categoriesCollection.add(categoryModel.toMap());
    categoryModel.id = referense.id;
    return categoryModel;
  }


  Future<List<CategoryModel>> getAllCategories()async{
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await categoriesCollection.get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> documints = querySnapshot.docs;
   List<CategoryModel> categoris = documints.map((e) {

     CategoryModel categoryModel = CategoryModel.fromeMap(e.data());
     categoryModel.id = e.id;
     log(e.data().toString());
     return categoryModel;
   } ).toList();

    return categoris;

  }
  
  deletCategory(CategoryModel categoryModel){
    categoriesCollection.doc(categoryModel.id).delete();
  }

  

  upDateCategory(CategoryModel categoryModel){
    categoriesCollection.
    doc(categoryModel.id).
    update(categoryModel.toMap());
  }



}