import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myecommerce/models/category_model.dart';
import 'package:myecommerce/models/product_model.dart';
import 'package:myecommerce/provider/CategoryFirestoreProvaider.dart';
import 'package:myecommerce/provider/Product_firestore_provaider.dart';
import 'package:myecommerce/views/admin/TextFieldAuth.dart';
import 'package:myecommerce/views/admin/category_list/add_product_cat_screen.dart';
import 'package:myecommerce/views/admin/category_list/product_cat_list.dart';
import 'package:myecommerce/views/components/custom_dialog.dart';
import 'package:myecommerce/views/constants.dart';
import 'package:myecommerce/views/navigation/router.dart';

import 'package:provider/provider.dart';



class EditCategoryScreen extends StatelessWidget {
   late CategoryModel categoryModel;
   EditCategoryScreen(CategoryModel categoryModel){
     this.categoryModel = categoryModel;
     clearTextField();
   }
  clearTextField(){

    Provider.of<CategoryFirestoreProvaider>(AppRouter.navKey.currentContext!,listen: false).categoryNameController.text = categoryModel.name;

  }

  @override
  Widget build(BuildContext context) {
    // clearTextField();
    return Consumer2<CategoryFirestoreProvaider,ProductFirestoreProvaider>(
        builder: (context,providercat,providerPro,x) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Edit Category',style: TextStyle(
                  color: Colors.grey
              ),),
              centerTitle: true,
              // backgroundColor: kPrimaryColor,
              // actions: [IconButton(onPressed: (){
              //   // if(context.locale.toString()=='ar')
              //   //   context.setLocale(Locale('en'));
              //   // else
              //   //   context.setLocale(Locale('ar'));
              // },
              //   icon: Icon(Icons.language),),],
              leading: IconButton(

                icon: Icon(Icons.arrow_back),color: Colors.grey, onPressed: () {
                AppRouter.popraoter();

                providercat.categoryNameController.clear();
              },),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Form(
                    key: providercat.cateKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20,top: 20),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Text('Edit  Image',style: TextStyle(
                              fontSize: 25.sp,
                              // color:kPrimaryColor,

                            ),textAlign: TextAlign.start,),
                          ),
                        ),
                        // SizedBox(height: .h,),
                        GestureDetector(
                          onTap: (){
                            providercat.selecteImageFun();
                          } ,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 150.h,
                              width: 360.w,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(7)),
                                color: Colors.grey,


                              ),
                              child: (providercat.selectedImage == null)
                                  ?Image.network(categoryModel.urlimage)
                                  :Image.file(providercat.selectedImage!),

                            ),
                          ),
                        ),
                        SizedBox(height: 40.h,),

                        TextFieldAuthWidget(
                          hintText: 'Category name',
                          suffix: Icon(Icons.drive_file_rename_outline),
                          controller: providercat.categoryNameController,
                          validator: providercat.nullvaliation,
                        ),

                        SizedBox(height: 20.h,),
                        InkWell(
                          onTap: () async {
                            await providerPro.getAllProduct(categoryModel.id!);
                            AppRouter.NavigateToWidget(ProductCatList(categoryModel.id!));

                          },
                          child: Container(
                            height: 55.h,
                            width: 360.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(7.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x26000000),
                                  offset: Offset(0, 3),
                                  blurRadius: 15,
                                ),
                              ],
                            ),
                            child: Text('Products',style: TextStyle(fontSize: 25.sp,color: Colors.white),),
                          ),
                        ),

                        SizedBox(height: 50.h,),

                        InkWell(
                          onTap: () async {
                            await providercat.upDateCategory(categoryModel);
                            await Diloge.show("Category Saved");

                            providercat.selectedImage = null;

                          },
                          child: Container(
                            height: 50.h,
                            width: 250.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(7.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x26000000),
                                  offset: Offset(0, 3),
                                  blurRadius: 15,
                                ),
                              ],
                            ),
                            child: Text('Edit Category',style: TextStyle(fontSize: 25.sp,color: Colors.white),),
                          ),
                        ),
                        SizedBox(height: 10.h,),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}



