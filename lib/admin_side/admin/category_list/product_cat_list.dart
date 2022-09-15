import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myecommerce/provider/Product_firestore_provaider.dart';
import 'package:myecommerce/admin_side/admin/product_list/add_product_cat_screen.dart';
import 'package:myecommerce/admin_side/admin/product_list/product_model_card.dart';
import 'package:myecommerce/views/constants.dart';
import 'package:myecommerce/views/navigation/router.dart';
import 'package:provider/provider.dart';

class ProductCatList extends StatefulWidget {
  String id;
  ProductCatList(this.id);

  @override
  _ProductCatListState createState() => _ProductCatListState();
}

class _ProductCatListState extends State<ProductCatList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products",style: TextStyle(
            color: Colors.grey
        ),),
      ),
      floatingActionButton:FloatingActionButton(
        onPressed:(){
          AppRouter.NavigateToWidget(AddProductCatScreen(widget.id));
        },
        child: Icon(Icons.add),
        backgroundColor: kPrimaryColor,
      ),
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

                    // this.completeTasks = tasks.where((element) => element.isComplete!).toList();
                    itemCount: provider.products.where((element) => element.catId == widget.id).length,
                    itemBuilder: (context,index){
                      return ProductModelCard(provider.products.where((element) => element.catId == widget.id).toList()[index]);
                    })
            );
          }
      ),
    );
  }
}
