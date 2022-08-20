// import 'package:flutter/material.dart';
// import 'package:myecommerce/models/product_model.dart';
//
// class ProductModelCard extends StatelessWidget {
//   final ProductModel product;
//
//   ProductModelCard(this.product);
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//         onTap: null,
//         child: Container(
//             height: 250,
//             width: MediaQuery.of(context).size.width / 2 - 29,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(10)),
//                 color: Color(0xfffbd085).withOpacity(0.46)),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: <Widget>[
//                 Align(
//                   alignment: Alignment.topCenter,
//                   child: Container(
//                     padding: EdgeInsets.all(16.0),
//                     width: MediaQuery.of(context).size.width / 2 - 64,
//                     height: MediaQuery.of(context).size.width / 2 - 64,
//                     child: Image.asset(
//                       product.image,
//                     ),
//                   ),
//                 ),
//                 Flexible(
//                   child: Align(
//                     alignment: Alignment(1, 0.5),
//                     child: Container(
//                         margin: const EdgeInsets.only(left: 16.0),
//                         padding: const EdgeInsets.all(8.0),
//                         decoration: BoxDecoration(
//                             color: Color(0xffe0450a).withOpacity(0.51),
//                             borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(10),
//                                 bottomLeft: Radius.circular(10))),
//                         child: Text(
//                           product.title,
//                           textAlign: TextAlign.right,
//                           style: TextStyle(
//                             fontSize: 12.0,
//                             color: Colors.white,
//                           ),
//                         )),
//                   ),
//                 )
//               ],
//             )));
//   }
// }
// import 'package:flutter/material.dart';
//
// import 'package:myecommerce/models/product_model.dart';
// import 'package:myecommerce/views/constants.dart';
// import 'package:myecommerce/views/screens/product_list/product_desc.dart';
//
// class ProductModelCard extends StatefulWidget {
//    ProductModel product;
//    ProductModelCard(this.product);
//   @override
//   _ProductModelCardState createState() => new _ProductModelCardState();
// }
//
// class _ProductModelCardState extends State<ProductModelCard>
//     with SingleTickerProviderStateMixin {
//   var deviceSize;
//   late AnimationController controller;
//   late Animation<double> animation;
//
//   Widget productCard() {
//     var cardHeight = deviceSize.height * 0.8;
//     var cardWidth = deviceSize.width * 0.85;
//     return Card(
//       clipBehavior: Clip.antiAlias,
//       elevation: 1.0,
//       shape: new RoundedRectangleBorder(
//           borderRadius: new BorderRadius.circular(15.0)),
//       color: Colors.white,
//       child: Ink(
//         height: cardHeight,
//         width: cardWidth,
//         child: new Stack(
//           children: <Widget>[
//             Container(
//               height: cardHeight - cardHeight / 2 * 1.1,
//               width: double.infinity,
//               child: new Image.network(
//                 widget.product.image,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: new Container(
//                 width: double.infinity,
//                 height: cardHeight / 2 * 1.2,
//                 decoration: new BoxDecoration(
//                   gradient: new LinearGradient(colors: [kPrimaryColor]),
//                   borderRadius: new BorderRadius.only(
//                       topLeft: const Radius.circular(30.0),
//                       topRight: const Radius.circular(30.0)),
//                   color: Colors.white,
//                 ),
//                 child: new ProductDesc( widget.product),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   initState() {
//     super.initState();
//     controller = new AnimationController(
//         vsync: this, duration: new Duration(milliseconds: 1500));
//     animation = new Tween(begin: 0.0, end: 1.0).animate(
//         new CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
//     animation.addListener(() => this.setState(() {}));
//     controller.forward();
//   }
//
//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     deviceSize = MediaQuery.of(context).size;
//     return productCard();
//   }
// }

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myecommerce/models/product_model.dart';
import 'package:myecommerce/provider/Product_firestore_provaider.dart';
import 'package:myecommerce/views/admin/product_list/dit_product.dart';
import 'package:myecommerce/views/constants.dart';
import 'package:myecommerce/views/navigation/router.dart';
import 'package:provider/provider.dart';

import '../../../data/product_firestore_helper.dart';

class ProductModelCard extends StatelessWidget {

  ProductModel product;

  ProductModelCard(this.product);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductFirestoreProvaider>(
      builder: (context,provider,x) {
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
                        AppRouter.NavigateToWidget(EditProductScreen(product));
                      },
                      child: Image.network(product.image,  height: 120.h)),
                  Text(product.title, style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
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
                            Text(product.price,
                                style:
                                TextStyle(fontSize: 28.0, fontFamily: "Helvetica")),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async{
                            log(product.id.toString());
                            log(product.catId.toString());
                            ProductFirestoreHelper.productFirestoreHelper.deletProduct(product);
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
    );
  }
}