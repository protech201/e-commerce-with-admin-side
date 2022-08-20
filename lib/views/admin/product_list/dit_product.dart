import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myecommerce/models/product_model.dart';
import 'package:myecommerce/provider/Product_firestore_provaider.dart';
import 'package:myecommerce/views/admin/TextFieldAuth.dart';
import 'package:myecommerce/views/components/custom_dialog.dart';
import 'package:myecommerce/views/constants.dart';
import 'package:myecommerce/views/navigation/router.dart';

import 'package:provider/provider.dart';



class EditProductScreen extends StatelessWidget {
   late ProductModel productModel;
   EditProductScreen(ProductModel productModel){
     this.productModel = productModel;
     clearTextField();

   }
  clearTextField(){

    Provider.of<ProductFirestoreProvaider>(AppRouter.navKey.currentContext!,listen: false).productTitleController.text = productModel.title;
    Provider.of<ProductFirestoreProvaider>(AppRouter.navKey.currentContext!,listen: false).productPriceController.text = productModel.price;
    Provider.of<ProductFirestoreProvaider>(AppRouter.navKey.currentContext!,listen: false).productDescriptionController.text = productModel.description;
    // Provider.of<ProductFirestoreProvaider>(AppRouter.navKey.currentContext!,listen: false)..text = productModel.title;

    // Provider.of<ProductFirestoreProvaider>(AppRouter.navKey.currentContext!,listen:  false).selectedImage=null;
  }

  @override
  Widget build(BuildContext context) {
    // clearTextField();
    return Consumer<ProductFirestoreProvaider>(
        builder: (context,provider,x) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Edit Product',style: TextStyle(
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
                provider.productDescriptionController.clear();
                provider.productPriceController.clear();
                provider.productTitleController.clear();
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
                            child: Text('Edit  Image',style: TextStyle(
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
                              child: (provider.selectedImage == null)
                                  ?Image.network(productModel.image)
                                  :Image.file(provider.selectedImage!),

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
                        // SizedBox(height: 10.h,),
                        // TextFieldAuthWidget(
                        //   hintText: 'Price',
                        //   suffix: Icon(Icons.perm_identity),
                        //   controller: provider.productPriceController,
                        //   validator: provider.nullvaliation,
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
                            await provider.upDateProduct(productModel);
                            await Diloge.show("Product Saved");

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
                            child: Text('Edit Product',style: TextStyle(fontSize: 25.sp,color: Colors.white),),
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



