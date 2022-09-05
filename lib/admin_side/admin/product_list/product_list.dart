import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myecommerce/provider/Product_firestore_provaider.dart';
import 'package:myecommerce/admin_side/admin/product_list/product_model_card.dart';
import 'package:myecommerce/views/constants.dart';
import 'package:myecommerce/views/navigation/router.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products",style: TextStyle(
            color: Colors.grey
        ),),
      ),
      // floatingActionButton:FloatingActionButton(
      //   onPressed:(){
      //     AppRouter.NavigateToWidget(AddProductScreen());
      //   },
      //   child: Icon(Icons.add),
      //   backgroundColor: kPrimaryColor,
      // ),
      // InkWell(
      //   onTap: (){
      //     AppRouter.NavigateToWidget(AddProductScreen());
      //   },
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Icon(Icons.add),
      //
      //       Text("Add Product"),
      //     ],
      //   ),
      // )


      body: Consumer<ProductFirestoreProvaider>(
        builder: (context,provider,x) {
          return SafeArea(
            child: ListView.builder(
                itemCount: provider.products.length,
                itemBuilder: (context,index){
                  return ProductModelCard(provider.products[index]);
                })
          );
        }
      ),
    );
  }
}
