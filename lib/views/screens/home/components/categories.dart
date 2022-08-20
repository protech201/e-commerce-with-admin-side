import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myecommerce/models/category_model.dart';
import 'package:myecommerce/provider/CategoryFirestoreProvaider.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // List<Map<String, dynamic>> categories = [
    //   {"icon": "assets/icons/Flash Icon.svg", "text": "Flash Deal"},
    //   {"icon": "assets/icons/Bill Icon.svg", "text": "Bill"},
    //   {"icon": "assets/icons/Game Icon.svg", "text": "Game"},
    //   {"icon": "assets/icons/Gift Icon.svg", "text": "Daily Gift"},
    //   {"icon": "assets/icons/Discover.svg", "text": "More"},
    // ];
    return Consumer<CategoryFirestoreProvaider>(
      builder: (context,provider,x) {
        return Padding(
          padding: EdgeInsets.all(getProportionateScreenWidth(20)),
          child: SizedBox(
            height: 85.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:provider.categores.length ,
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: CategoryCard(provider. categores[index]),
                );
              },

            ),
          ),
          // child: Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: List.generate(
          //     categories.length,
          //     (index) => CategoryCard(
          //       icon: categories[index]["icon"],
          //       text: categories[index]["text"],
          //       press: () {},
          //     ),
          //   ),
          // ),
        );
      }
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard(

     this.categoryModel,
    // required this.press,
  );

  final CategoryModel categoryModel;
  // final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: press,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(15)),
            height: getProportionateScreenWidth(55),
            width: getProportionateScreenWidth(55),
            decoration: BoxDecoration(
              color: Color(0xFFFFECDF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.network(categoryModel.urlimage),
          ),
          SizedBox(height: 5),
          Text(categoryModel.name, textAlign: TextAlign.center)
        ],
      ),
    );
  }
}
