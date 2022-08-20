
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myecommerce/models/category_model.dart';
import 'package:myecommerce/models/product_model.dart';
import 'package:myecommerce/provider/CategoryFirestoreProvaider.dart';
import 'package:myecommerce/provider/Product_firestore_provaider.dart';
import 'package:myecommerce/views/admin/category_list/edit_category.dart';
import 'package:myecommerce/views/admin/product_list/dit_product.dart';
import 'package:myecommerce/views/constants.dart';
import 'package:myecommerce/views/navigation/router.dart';
import 'package:provider/provider.dart';

class CategoryModelCard extends StatelessWidget {

  CategoryModel category;

  CategoryModelCard(this.category);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        new Container(
          width: double.infinity,
          height:250.h,
          decoration: BoxDecoration(
              color: kPrimaryLightColor.withOpacity(.5),
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Colors.grey.withOpacity(.3), width: .2)),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 8.0,
              ),
              InkWell(
                  onTap: (){
                    AppRouter.NavigateToWidget(EditCategoryScreen(category));
                  },
                  child: Image.network(category.urlimage,  height: 120.h)),
              Text(category.name, style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.favorite),
                      onPressed: () {},
                    ),
                    Column(
                      children: <Widget>[
                        // Text(product.price,
                        //     style: TextStyle(
                        //         color: Color(0xFFfeb0ba),
                        //         fontSize: 16.0,
                        //         fontFamily: "Helvetica")),
                        SizedBox(
                          height: 12.0,
                        ),
                        // Text(category.price,
                        //     style:
                        //     TextStyle(fontSize: 28.0, fontFamily: "Helvetica")),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        Provider.of<CategoryFirestoreProvaider>(context,listen: false).deletCategory(category);
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h,)
      ],
    );
  }
}