import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myecommerce/models/Product.dart';
import 'package:myecommerce/models/product_model.dart';
import 'package:myecommerce/provider/Product_firestore_provaider.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductDescription extends StatefulWidget {
   ProductDescription({
    Key? key,
    required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  final ProductModel product;
  final GestureTapCallback? pressOnSeeMore;

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  Color color = Color(0xFFDBDEE4);

  Color colors = Color(0xFFF5F6F9);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
            widget.product.title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: (){
              if (color == Color(0xFFDBDEE4)){
                color = Color(0xFFFF4848);
                colors = Color(0xFFFFE6E6);
              }else{color = Color(0xFFDBDEE4);
              colors = Color(0xFFF5F6F9);}

              setState(() {

              });
            },
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              width: getProportionateScreenWidth(64),
              decoration: BoxDecoration(
                color:colors
                    // product.isFavourite ? Color(0xFFFFE6E6) : Color(0xFFF5F6F9)
    ,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: SvgPicture.asset(
                "assets/icons/Heart Icon_2.svg",
                color:color,
                    // product.isFavourite ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
                height: getProportionateScreenWidth(16),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: Text(
            widget.product.description,
            maxLines: 3,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: 10,
          ),
          child: Row(
            children: [
              Text(
                widget.product.price,
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor,
                fontSize: 20.sp),
              ),
              SizedBox(width: 3),
              Icon(
                Icons.attach_money,
                size: 18.h,
                color: kPrimaryColor,
              ),
            ],
          ),
        )
      ],
    );
  }
}
