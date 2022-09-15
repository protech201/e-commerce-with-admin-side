import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myecommerce/provider/Product_firestore_provaider.dart';
import 'package:myecommerce/admin_side/admin/TextFieldAuth.dart';
import 'package:myecommerce/views/components/custom_dialog.dart';
import 'package:myecommerce/views/constants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:myecommerce/views/navigation/router.dart';

import 'package:provider/provider.dart';



class AddProductCatScreen extends StatefulWidget {
  String catId;
  AddProductCatScreen(this.catId);
  @override
  State<AddProductCatScreen> createState() => _AddProductCatScreenState();
}

class _AddProductCatScreenState extends State<AddProductCatScreen> {
  // clearTextField(){
  String selectedCategory = "Select category";



  @override
  Widget build(BuildContext context) {
    // clearTextField();
    return Consumer<ProductFirestoreProvaider>(
        builder: (context,provider,x) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Add Product',style: TextStyle(
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
                    key: provider.prodKey,
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
                          hintText: 'product name',
                          suffix: Icon(Icons.drive_file_rename_outline),
                          controller: provider.productTitleController,
                          validator: provider.nullvaliation,
                        ),
                        SizedBox(height: 20.h,),
                        TextFieldAuthWidget(
                          hintText: 'Price',
                          suffix: Icon(Icons.attach_money),
                          controller: provider.productPriceController,
                          validator: provider.nullvaliation,
                        ),
                        // SizedBox(height: 20.h,),
                        // SizedBox(
                        //   width: 360.w,
                        //   child: DropdownButtonFormField2(
                        //     decoration: InputDecoration(
                        //       border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10),
                        //         borderSide: BorderSide(color: kPrimaryColor, width: 1),
                        //       ),
                        //       enabledBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10),
                        //         borderSide: BorderSide(color: kPrimaryColor, width: 1),
                        //       ),
                        //       focusedBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10),
                        //         borderSide: BorderSide(color: kPrimaryColor, width: 1),
                        //       ),
                        //
                        //       hintStyle: TextStyle(fontSize: 15.sp,color: Colors.grey),
                        //     ),
                        //     isExpanded: true,
                        //     hint: const Text(
                        //       'Select Your Category',
                        //       style: TextStyle(fontSize: 14),
                        //     ),
                        //     icon: const Icon(
                        //       Icons.arrow_drop_down,
                        //       color: Colors.black45,
                        //     ),
                        //     iconSize: 30.h,
                        //     buttonHeight: 20.h,
                        //     buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                        //     dropdownDecoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(15),
                        //     ),
                        //     items: provider.products.map((item) =>
                        //         DropdownMenuItem<String>(
                        //           value: item.title,
                        //           child: Text(
                        //             item.title,
                        //             style: const TextStyle(
                        //               fontSize: 14,
                        //             ),
                        //           ),
                        //         ))
                        //         .toList(),
                        //     validator: (value) {
                        //       if (value == null) {
                        //         return 'Please select gender.';
                        //       }
                        //     },
                        //     onChanged: (value) {
                        //       //Do something when changing the item if you want.
                        //     },
                        //     onSaved: (value) {
                        //       selectedCategory = value.toString();
                        //     },
                        //   ),
                        // ),






                        SizedBox(height: 40.h,),

                        TextFieldAuthWidget(
                          hintText: 'Description',
                          controller: provider.productDescriptionController,
                          validator: provider.nullvaliation,
                          maxLine: 3,
                        ),
                        SizedBox(height: 20.h,),
                        // TextFieldAuthWidget(
                        //   textInputType: TextInputType.number,
                        //   hintText: 'Number of stars',
                        //   suffix: Icon(Icons.star_rounded),
                        //   controller: provider.starsController,
                        //   validator: provider.nullValidation,
                        // ),
                        // SizedBox(
                        //   width: 320.w,
                        //   child: Row(
                        //     children: [
                        //       Text('This course is Online?'.tr(),style: TextStyle(fontSize: 15.sp,color: kPrimaryColor),),
                        //       Checkbox(
                        //         activeColor: Colors_Ui.main2Color,
                        //         value: provider.isOnline,
                        //         onChanged: (value){
                        //           provider.isOnlineFun(value!);
                        //         },
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(height: 30.h,),

                        InkWell(
                          onTap: () async {
                              await provider.addNewProduct(widget.catId);
                              // await Diloge.show("Product added");
                              provider.productDescriptionController.clear();
                              provider.productPriceController.clear();
                              provider.productTitleController.clear();
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
                            child: Text('Add Product',style: TextStyle(fontSize: 25.sp,color: Colors.white),),
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



