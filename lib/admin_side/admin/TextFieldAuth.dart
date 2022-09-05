import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myecommerce/views/constants.dart';

class TextFieldAuthWidget extends StatelessWidget {
  final String hintText;
  TextEditingController controller;
  Widget? suffix;
  final Function? validator;
  int? maxLine;
  TextInputType? textInputType;
  TextFieldAuthWidget({
    required this.hintText,
    required this.controller,
     this.suffix,
    this.validator,
    this.maxLine,
    this.textInputType

});
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: 360.w,
      child: TextFormField(
        keyboardType: textInputType,

        maxLines: maxLine??1,
          validator: (x)=>validator!(x),
          textAlignVertical: TextAlignVertical.center,
          controller: controller,
          style: TextStyle(fontSize: 15.sp,color: kPrimaryColor), //#AEBAF8
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: kPrimaryColor, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: kPrimaryColor, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: kPrimaryColor, width: 1),
            ),
            prefixIcon: suffix,

            hintText: hintText,
            hintStyle: TextStyle(fontSize: 15.sp,color: Colors.grey),
          ),

        ),
    );
  }
}
