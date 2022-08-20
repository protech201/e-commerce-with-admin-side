import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myecommerce/provider/CategoryFirestoreProvaider.dart';
import 'package:myecommerce/provider/Product_firestore_provaider.dart';
import 'package:myecommerce/views/admin/add_category_screen.dart';
import 'package:myecommerce/views/admin/category_list/category_model_card.dart';
import 'package:myecommerce/views/admin/product_list/product_model_card.dart';
import 'package:myecommerce/views/constants.dart';
import 'package:myecommerce/views/navigation/router.dart';
import 'package:provider/provider.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories",style: TextStyle(
            color: Colors.grey
        ),),
      ),
      floatingActionButton:FloatingActionButton(
        onPressed:(){
          AppRouter.NavigateToWidget(AddCategoryScreen());
        },
        child: Icon(Icons.add),
        backgroundColor: kPrimaryColor,
      ),


      body: Consumer<CategoryFirestoreProvaider>(
        builder: (context,provider,x) {
          return SafeArea(
            child: ListView.builder(
                itemCount: provider.categores.length,
                itemBuilder: (context,index){
                  return CategoryModelCard(provider.categores[index]);
                })
          );
        }
      ),
    );
  }
}
