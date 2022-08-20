// import 'dart:developer';
// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../data/storge_helper.dart';
//
// class StorgeProvider extends ChangeNotifier{
//   File? selectedImage;
//
//
//   uploadImage(File file)async{
//    String url = await StorgeHelper.storgeHelper.uploadImage(file);
//    log(url);
//   }
//   selecteImageFun()async {
//     XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
//     selectedImage= File(xfile!.path);
//     notifyListeners();
//   }
//
//
// }