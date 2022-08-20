import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myecommerce/provider/Product_firestore_provaider.dart';
import 'package:myecommerce/views/components/product_card.dart';
import 'package:myecommerce/models/Product.dart';
import 'package:myecommerce/views/screens/home/components/section_title.dart';
import 'package:myecommerce/views/size_config.dart';
import 'package:provider/provider.dart';



class PopularProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductFirestoreProvaider>(
      builder: (context,provider,x) {
        return Column(
          children: [
            // Padding(
            //   padding:
            //       EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            //   child: SectionTitle(title: "Popular Products", press: () {}),
            // ),
            SizedBox(height: getProportionateScreenWidth(20)),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SizedBox(
                height: 700.h,

                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: provider.products.length,
                    itemBuilder: (context,index){
                      return SizedBox(
                        // width: 100,
                        height: 450.h,
                        child: ProductCard(product: provider.products[index]),
                      );

                    }
                ),
              ),
            )


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
