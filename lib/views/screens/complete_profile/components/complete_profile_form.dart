import 'package:flutter/material.dart';
import 'package:myecommerce/views/navigation/router.dart';
import 'package:myecommerce/views/screens/login_success/login_success_screen.dart';
import 'package:provider/provider.dart';
import 'package:myecommerce/provider/auth_provaider.dart';
import 'package:myecommerce/views/components/custom_surfix_icon.dart';
import 'package:myecommerce/views/components/default_button.dart';
import 'package:myecommerce/views/components/form_error.dart';
import 'package:myecommerce/views/screens/otp/otp_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CompleteProfileForm extends StatefulWidget {
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? address;

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvaider>(
      builder: (context,provider,x) {
        return Form(
          key: provider.completKey,
          child: Column(
            children: [

              buildUserNameFormField(),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildPhoneNumberFormField(),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildAddressFormField(),
              FormError(errors: errors),
              SizedBox(height: getProportionateScreenHeight(40)),
              DefaultButton(
                text: "continue",
                press: () {
                  provider.savingData();
                  AppRouter.NavigateWithReplacemtnToWidget(LoginSuccessScreen());
                  }

              ),
            ],
          ),
        );
      }
    );
  }

  TextFormField buildAddressFormField() {
    return   TextFormField(
      keyboardType: TextInputType.text,
      validator: (x) => Provider.of<AuthProvaider>(context,listen: false).nullvaliation(x!),
      controller: Provider.of<AuthProvaider>(context,listen: false).cityController,
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Enter your phone address",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
        CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }




  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      validator: (x) => Provider.of<AuthProvaider>(context,listen: false).nullvaliation(x!),
      controller: Provider.of<AuthProvaider>(context,listen: false).phoneController,
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildUserNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      validator: (x) => Provider.of<AuthProvaider>(context,listen: false).nullvaliation(x!),
      controller: Provider.of<AuthProvaider>(context,listen: false).userNameController,
      decoration: InputDecoration(
        labelText: "User Name",
        hintText: "Enter your User name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }








}
