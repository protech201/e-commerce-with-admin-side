import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myecommerce/data/keyboard.dart';
import 'package:myecommerce/views/components/custom_surfix_icon.dart';
import 'package:myecommerce/views/components/form_error.dart';
import 'package:myecommerce/views/screens/forgot_password/forgot_password_screen.dart';
import 'package:myecommerce/views/screens/login_success/login_success_screen.dart';

import '../../../../provider/auth_provaider.dart';
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  // final _formKey = GlobalKey<FormState>();
  // String? email;
  // String? password;
  bool? remember = false;
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
          key: provider.loginKey,
          child: Column(
            children: [
              buildEmailFormField(),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildPasswordFormField(),
              SizedBox(height: getProportionateScreenHeight(30)),
              Row(
                children: [
                  // Checkbox(
                  //   value: remember,
                  //   activeColor: kPrimaryColor,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       remember = value;
                  //     });
                  //   },
                  // ),
                  // Text("Remember me"),
                  // Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(
                          context, ForgotPasswordScreen.routeName),
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                  )
                ],
              ),
              // FormError(errors: errors),
              SizedBox(height: getProportionateScreenHeight(20)),
              DefaultButton(
                text: "Continue",
                press: ()async {
                  await provider.signIn();

                  // if (_formKey.currentState!.validate()) {
                  //   _formKey.currentState!.save();
                  //   // if all are valid then go to success screen
                  //   KeyboardUtil.hideKeyboard(context);
                  //   Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                  // }
                },
              ),
            ],
          ),
        );
      }
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
}
