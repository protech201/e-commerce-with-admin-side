import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myecommerce/provider/CategoryFirestoreProvaider.dart';
import 'package:myecommerce/views/admin/category/category_list_page.dart';
import 'package:myecommerce/views/components/category_card.dart';

import 'package:myecommerce/views/navigation/router.dart';
import 'package:myecommerce/views/screens/home/category/category_list_page.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryFirestoreProvaider>(
      builder: (context,provider,x) {
        return Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
              child: SectionTitle(title: "Categories", press: () {
               AppRouter.NavigateToWidget(CategoryListPageScreen());
              }),
            ),
            SizedBox(height: getProportionateScreenWidth(20)),
           SizedBox(
             height: 230.h,
             child: (provider.categores.length == 0)
                 ?Container()
                 :(provider.categores.length == 1)
                 ? Category_Card(product: provider.categores[0])
                 : Row(
                   children: [
                     Category_Card(product: provider.categores[0]),
                     Category_Card(product: provider.categores[1]),

                   ],
                 ),

           )
           // SizedBox(
           //   height: 230.h,
           //
           //   child: ListView.builder(
           //     scrollDirection: Axis.horizontal,
           //     itemCount: provider.products.length,
           //       itemBuilder: (context,index){
           //       return ProductCard(product: provider.products[index]);
           //
           //       }
           //   ),
           // )
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //     children: [
            //       ...List.generate(
            //         demoProducts.length,
            //         (index) {
            //           if (demoProducts[index].isPopular)
            //             return ProductCard(product: demoProducts[index]);
            //
            //           return SizedBox.shrink(); // here by default width and height is 0
            //         },
            //       ),
            //       SizedBox(width: getProportionateScreenWidth(20)),
            //     ],
            //   ),
            // )
          ],
        );
      }
    );
  }
}
