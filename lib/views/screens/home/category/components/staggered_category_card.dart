import 'package:flutter/material.dart';
import 'package:myecommerce/models/category_model.dart';
import 'package:myecommerce/provider/Product_firestore_provaider.dart';
import 'package:myecommerce/views/navigation/router.dart';
import 'package:myecommerce/views/screens/listProduct/ListProduct.dart';
import 'package:provider/provider.dart';

class CategoryCard extends StatelessWidget {
  final Color begin = Color(0xff00E9DA);
  final Color end = Color(0xff5189EA);
  final CategoryModel categoryModel;

  CategoryCard({
    required this.controller,
    required this.categoryModel
  })  : height = Tween<double>(begin: 150, end: 250.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.300,
              curve: Curves.ease,
            ),
          ),
        ),
        itemHeight = Tween<double>(begin: 0, end: 150.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.300,
              curve: Curves.ease,
            ),
          ),
        );

  final Animation<double> controller;
  final Animation<double> height;
  final Animation<double> itemHeight;

  // This function is called each time the controller "ticks" a new frame.
  // When it runs, all of the animation's values will have been
  // updated to reflect the controller's current value.
  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Container(
      height: height.value,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [begin, end],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Align(
              alignment: Alignment(-1, 0),
              child: Text(
                categoryModel.name,
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
//        mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 16.0),
                height: itemHeight.value,
                child: Image.network(
                  categoryModel.urlimage,
                ),
              ),
              InkWell(
                onTap: ()async{
                 await Provider.of<ProductFirestoreProvaider>(context,listen: false).getAllProduct(categoryModel.id!);
                  AppRouter.NavigateToWidget(ListProduct());
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(24))),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    'View more',
                    style: TextStyle(color: end, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}

class StaggeredCardCard extends StatefulWidget {
  final Color begin = Color(0xff00E9DA);
  final Color end = Color(0xff5189EA);
  final CategoryModel categoryModel;


   StaggeredCardCard(this.categoryModel);

  @override
  _StaggeredCardCardState createState() => _StaggeredCardCardState();
}

class _StaggeredCardCardState extends State<StaggeredCardCard>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  bool isActive = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
  }

  Future<void> _playAnimation() async {
    try {
      await _controller.forward().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

  Future<void> _reverseAnimation() async {
    try {
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

  @override
  Widget build(BuildContext context) {
    var timeDilation = 10.0; // 1.0 is normal animation speed.
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (isActive) {
          isActive = !isActive;
          _reverseAnimation();
        } else {
          isActive = !isActive;
          _playAnimation();
        }
      },
      child: CategoryCard(
        controller: _controller.view,
        categoryModel: widget.categoryModel,
      ),
    );
  }
}
