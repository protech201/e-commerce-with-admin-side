
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myecommerce/models/category_model.dart';
import 'package:myecommerce/provider/CategoryFirestoreProvaider.dart';
import 'package:myecommerce/views/components/coustom_bottom_nav_bar.dart';
import 'package:myecommerce/views/enums.dart';
import 'package:provider/provider.dart';

import 'components/staggered_category_card.dart';

class CategoryListPage extends StatefulWidget {
  static String routeName = "/category";
  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  // List<CategoryModel> categories = [
  //   Category(
  //     Color(0xffFCE183),
  //     Color(0xffF68D7F),
  //     'Gadgets',
  //     'assets/jeans_5.png',
  //   ),
  //   Category(
  //     Color(0xffF749A2),
  //     Color(0xffFF7375),
  //     'Clothes',
  //     'assets/jeans_5.png',
  //   ),
  //   Category(
  //     Color(0xff00E9DA),
  //     Color(0xff5189EA),
  //     'Fashion',
  //     'assets/jeans_5.png',
  //   ),
  //   Category(
  //     Color(0xffAF2D68),
  //     Color(0xff632376),
  //     'Home',
  //     'assets/jeans_5.png',
  //   ),
  //   Category(
  //     Color(0xff36E892),
  //     Color(0xff33B2B9),
  //     'Beauty',
  //     'assets/jeans_5.png',
  //   ),
  //   Category(
  //     Color(0xffF123C4),
  //     Color(0xff668CEA),
  //     'Appliances',
  //     'assets/jeans_5.png',
  //   ),
  // ];

  // List<Category> searchResults = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // searchResults = categories;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryFirestoreProvaider>(
      builder: (context,provider,x) {
        return Scaffold(
          body: Material(
            color: Color(0xffF9F9F9),
            child: Container(
              margin: const EdgeInsets.only(top: kToolbarHeight),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Align(
                    alignment: Alignment(-1, 0),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        'Category List',
                        style: TextStyle(
                          // color: darkGrey,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.only(left: 16.0),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.all(Radius.circular(5)),
                  //     color: Colors.white,
                  //   ),
                  //   child: TextField(
                  //     controller: searchController,
                  //     decoration: InputDecoration(
                  //         border: InputBorder.none,
                  //         hintText: 'Search',
                  //         prefixIcon: SvgPicture.asset(
                  //           'assets/icons/search_icon.svg',
                  //           fit: BoxFit.scaleDown,
                  //         )),
                  //     onChanged: (value) {
                  //       if (value.isNotEmpty) {
                  //         List<Category> tempList = [];
                  //         categories.forEach((category) {
                  //           if (category.category.toLowerCase().contains(value)) {
                  //             tempList.add(category);
                  //           }
                  //         });
                  //         setState(() {
                  //           searchResults.clear();
                  //           searchResults.addAll(tempList);
                  //         });
                  //         return;
                  //       } else {
                  //         setState(() {
                  //           searchResults.clear();
                  //           searchResults.addAll(categories);
                  //         });
                  //       }
                  //     },
                  //   ),
                  // ),
                  Flexible(
                    child: ListView.builder(
                      itemCount: provider.categores.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 16.0,
                        ),
                        child: StaggeredCardCard(provider.categores[index]),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.category),
        );
      }
    );
  }
}
