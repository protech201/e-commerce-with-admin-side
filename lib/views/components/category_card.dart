import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myecommerce/models/Product.dart';
import 'package:myecommerce/models/category_model.dart';
import 'package:myecommerce/models/product_model.dart';
import 'package:myecommerce/provider/CategoryFirestoreProvaider.dart';
import 'package:myecommerce/provider/Product_firestore_provaider.dart';
import 'package:myecommerce/views/navigation/router.dart';
import 'package:myecommerce/views/screens/details/details_screen.dart';
import 'package:myecommerce/views/screens/listProduct/ListProduct.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../size_config.dart';

class Category_Card extends StatelessWidget {
   Category_Card({
    Key? key,

    required this.product,
  }) : super(key: key);

   CategoryModel product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: 170.w,
        // height: 500.h,
        child: GestureDetector(
          onTap: () async{
            await Provider.of<ProductFirestoreProvaider>(context,listen: false).getAllProduct(product.id!);
            AppRouter.NavigateToWidget(ListProduct());
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.02,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Hero(
                    tag: product.id.toString(),
                    child: Image.network(product.urlimage),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                product.name,
                style: TextStyle(color: Colors.black),
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text(
                  //   "\$${product.price}",
                  //   style: TextStyle(
                  //     fontSize: getProportionateScreenWidth(18),
                  //     fontWeight: FontWeight.w600,
                  //     color: kPrimaryColor,
                  //   ),
                  // ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      Provider.of<CategoryFirestoreProvaider>(context,listen: false).upDateCategoryLike(product);

                    },
                    child: Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                      height: getProportionateScreenWidth(28),
                      width: getProportionateScreenWidth(28),
                      decoration: BoxDecoration(
                        color: product.isFavourite
                            ? kPrimaryColor.withOpacity(0.15)
                            : kSecondaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/Heart Icon_2.svg",
                        color: product.isFavourite
                            ? Color(0xFFFF4848)
                            : Color(0xFFDBDEE4),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
