import 'package:flutter/material.dart';
import 'package:myecommerce/views/screens/listProduct/popular_product.dart';

class ListProduct extends StatelessWidget {
  const ListProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products",style: TextStyle(color: Colors.grey),),

      ),
      body: PopularProducts(),
    );
  }
}
