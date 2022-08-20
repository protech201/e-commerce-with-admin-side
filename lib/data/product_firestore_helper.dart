
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class ProductFirestoreHelper{
  static ProductFirestoreHelper productFirestoreHelper = ProductFirestoreHelper();


  CollectionReference<Map<String, dynamic>> categoriesCollection = FirebaseFirestore.instance.collection("categories");


  Future<ProductModel> addNewProduct(ProductModel productModel)async{
     DocumentReference<Map<String, dynamic>> documentReference = await categoriesCollection
        .doc(productModel.catId)
        .collection("products")
        .add(productModel.toMap());
     productModel.id = documentReference.id;

     return productModel;
   }

   Future<List<ProductModel>>getAllProducts(String catId)async{
     QuerySnapshot<Map<String, dynamic>> querySnapshot = await categoriesCollection
         .doc(catId)
         .collection("products")
         .get();
     List<QueryDocumentSnapshot<Map<String, dynamic>>> queryDocumentSnapshot=querySnapshot.docs;
     List<ProductModel> products = queryDocumentSnapshot.map((e) {
       ProductModel productModel = ProductModel.fromeMap(e.data());
       productModel.id = e.id;
       return productModel;
     } ).toList();
     return products;
   }

   updateProduct(ProductModel productModel)async{
     categoriesCollection
         .doc(productModel.catId)
         .collection("products")
         .doc(productModel.id)
         .update(productModel.toMap());
  }

   deletProduct(ProductModel productModel)async{
     await categoriesCollection
         .doc(productModel.catId)
         .collection("products")
         .doc(productModel.id)
         .delete();
     // await deletProduct1(productModel);
   }




  //للفردي يعم
  //
  // CollectionReference<Map<String, dynamic>> productsCollection = FirebaseFirestore.instance.collection("products");
  //
  //
  // Future<ProductModel> addNewProduct1(ProductModel productModel) async {
  //   DocumentReference<Map<String, dynamic>> referense =await  productsCollection.add(productModel.toMap());
  //   productModel.id = referense.id;
  //   log(productModel.id!);
  //
  //   return productModel;
  // }
  //
  // Future<List<ProductModel>> getAllProducts1()async{
  //   QuerySnapshot<Map<String, dynamic>> querySnapshot = await productsCollection.get();
  //   List<QueryDocumentSnapshot<Map<String, dynamic>>> documints = querySnapshot.docs;
  //  List<ProductModel> products = documints.map((e) {
  //    ProductModel productModel = ProductModel.fromeMap(e.data());
  //    productModel.id = e.id;
  //    log( productModel.id!);
  //    return productModel;
  //  } ).toList();
  //
  //   return products;
  // }
  //
  // deletProduct1(ProductModel productModel){
  //   productsCollection.doc(productModel.id).delete();
  // }
  //
  // upDateProduct1(ProductModel productModel){
  //   log(productModel.id??"asd");
  //   productsCollection.
  //   doc(productModel.id).
  //   update(productModel.toMap());
  // }


}