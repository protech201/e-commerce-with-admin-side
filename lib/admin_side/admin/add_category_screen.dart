import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myecommerce/provider/CategoryFirestoreProvaider.dart';
import 'package:myecommerce/provider/Product_firestore_provaider.dart';
import 'package:myecommerce/views/components/custom_dialog.dart';
import 'package:myecommerce/views/constants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:myecommerce/views/navigation/router.dart';

import 'package:provider/provider.dart';


import 'TextFieldAuth.dart';
class AddCategoryScreen extends StatefulWidget {
  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  // clearTextField(){
  String selectedCategory = "Select category";



  @override
  Widget build(BuildContext context) {
    // clearTextField();
    return Consumer<CategoryFirestoreProvaider>(
        builder: (context,provider,x) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Add Category',style: TextStyle(
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
              },),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Form(
                    key: provider.cateKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20,top: 20),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Text('Add Image',style: TextStyle(
                              fontSize: 25.sp,
                              // color:kPrimaryColor,

                            ),textAlign: TextAlign.start,),
                          ),
                        ),
                        // SizedBox(height: .h,),
                        GestureDetector(
                          onTap: (){
                            provider.selecteImageFun();
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
                              child: provider.selectedImage == null?
                              Icon(Icons.add_a_photo_outlined,size: 25.sp,)
                                  :Image.file(provider.selectedImage!)
                              ,
                            ),
                          ),
                        ),
                        SizedBox(height: 40.h,),

                        TextFieldAuthWidget(
                          hintText: 'Category name',
                          suffix: Icon(Icons.drive_file_rename_outline),
                          controller: provider.categoryNameController,
                          validator: provider.nullvaliation,
                        ),
                        SizedBox(height: 20.h,),

                        // TextFieldAuthWidget(
                        //   hintText: 'Price',
                        //   suffix: Icon(Icons.attach_money),
                        //   controller: provider.productPriceController,
                        //   validator: provider.nullvaliation,
                        // ),
                        SizedBox(height: 40.h,),

                        SizedBox(height: 20.h,),
                        SizedBox(height: 30.h,),

                        InkWell(
                          onTap: () async {
                            await provider.addNewCategory();
                            await Diloge.show("Category added");
                            provider.categoryNameController.clear();
                            provider.selectedImage = null;

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
                            child: Text('Add Category',style: TextStyle(fontSize: 25.sp,color: Colors.white),),
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



