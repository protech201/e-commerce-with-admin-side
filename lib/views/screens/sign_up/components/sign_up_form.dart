import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myecommerce/provider/auth_provaider.dart';
import 'package:myecommerce/views/components/custom_surfix_icon.dart';
import 'package:myecommerce/views/components/default_button.dart';
import 'package:myecommerce/views/components/form_error.dart';
import 'package:myecommerce/views/screens/complete_profile/complete_profile_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';


class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  // final _formKey = GlobalKey<FormState>();
  // String? email;
  // String? password;
  // String? conform_password;
  // bool remember = false;
  // final List<String?> errors = [];
  //
  // void addError({String? error}) {
  //   if (!errors.contains(error))
  //     setState(() {
  //       errors.add(error);
  //     });
  // }
  //
  // void removeError({String? error}) {
  //   if (errors.contains(error))
  //     setState(() {
  //       errors.remove(error);
  //     });
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvaider>(
      builder: (context,provider,x) {
        return Form(
          key: provider.registerKey,
          child: Column(
            children: [
              buildEmailFormField(),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildPasswordFormField(),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildConformPassFormField(),
              // FormError(errors: errors),
              // SizedBox(height: getProportionateScreenHeight(40)),
              // buildUserNameFormField(),
              // SizedBox(height: getProportionateScreenHeight(30)),
              // buildPhoneNumberFormField(),
              // SizedBox(height: getProportionateScreenHeight(30)),
              // buildAddressFormField(),
              SizedBox(height: getProportionateScreenHeight(40)),
              DefaultButton(
                text: "Continue",
                press: () {
                  // if (provider.registerKey.currentState!.validate()) {
                  //   provider.registerKey.currentState!.save();
                  //   // if all are valid then go to success screen
                  //   Navigator.pushNamed(context, CompleteProfileScreen.routeName);
                  // }
                  provider.register();
                },
              ),
            ],
          ),
        );
      }
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      validator: (x) => Provider.of<AuthProvaider>(context,listen: false).conformPassvaliation(x!),
      controller: Provider.of<AuthProvaider>(context,listen: false).conformPassController,
      // onSaved: (newValue) => conform_password = newValue,
      // onChanged: (value) {
      //   if (value.isNotEmpty) {
      //     removeError(error: kPassNullError);
      //   } else if (value.isNotEmpty && password == conform_password) {
      //     removeError(error: kMatchPassError);
      //   }
      //   conform_password = value;
      // },
      // validator: (value) {
      //   if (value!.isEmpty) {
      //     addError(error: kPassNullError);
      //     return "";
      //   } else if ((password != value)) {
      //     addError(error: kMatchPassError);
      //     return "";
      //   }
      //   return null;
      // },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      // onSaved: (newValue) => email = newValue,
      // onChanged: (value) {
      //   if (value.isNotEmpty) {
      //     removeError(error: kEmailNullError);
      //   } else if (emailValidatorRegExp.hasMatch(value)) {
      //     removeError(error: kInvalidEmailError);
      //   }
      //   return null;
      // },
      validator: (x) => Provider.of<AuthProvaider>(context,listen: false).emailvaliation(x!),
      controller: Provider.of<AuthProvaider>(context,listen: false).emailController,
      //     (value) {
      //   if (value!.isEmpty) {
      //     addError(error: kEmailNullError);
      //     return "";
      //   } else if (!emailValidatorRegExp.hasMatch(value)) {
      //     addError(error: kInvalidEmailError);
      //     return "";
      //   }
      //   return null;
      // },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      // onSaved: (newValue) => password = newValue,
      // onChanged: (value) {
      //   if (value.isNotEmpty) {
      //     removeError(error: kPassNullError);
      //   } else if (value.length >= 8) {
      //     removeError(error: kShortPassError);
      //   }
      //   password = value;
      // },
      // validator: (value) {
      //   if (value!.isEmpty) {
      //     addError(error: kPassNullError);
      //     return "";
      //   } else if (value.length < 8) {
      //     addError(error: kShortPassError);
      //     return "";
      //   }
      //   return null;
      // },
      validator: (x) => Provider.of<AuthProvaider>(context,listen: false).passwrdvaliation(x!),
      controller: Provider.of<AuthProvaider>(context,listen: false).passwordController,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
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
