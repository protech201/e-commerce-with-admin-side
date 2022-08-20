import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myecommerce/provider/auth_provaider.dart';
import 'package:myecommerce/views/components/custom_surfix_icon.dart';
import 'package:myecommerce/views/components/default_button.dart';
import 'package:myecommerce/views/components/form_error.dart';
import 'package:myecommerce/views/components/no_account_text.dart';
import 'package:myecommerce/views/size_config.dart';

import '../../../constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Please enter your email and we will send \nyou a link to return to your account",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvaider>(
      builder: (context,provider,x) {
        return Form(
          key: provider.passKey,
          child: Column(
            children: [
            TextFormField(
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
          ),
              SizedBox(height: getProportionateScreenHeight(30)),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              DefaultButton(
                text: "Continue",
                press: () {
                 provider.forgetPassurd();
                },
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              NoAccountText(),
            ],
          ),
        );
      }
    );
  }
}
