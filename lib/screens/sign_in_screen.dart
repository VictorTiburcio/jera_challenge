import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/account_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  static const String route = '/sign_in';
  final TapGestureRecognizer _signUpGestureDetector = TapGestureRecognizer();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    void _navigateToSignUpScreen() {
      Navigator.pushNamed(context, SignUpScreen.route);
    }

    _signUpGestureDetector.onTap = _navigateToSignUpScreen;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFormField(
                ctrl: _emailCtrl,
                label: 'E-mail',
                inputType: TextInputType.emailAddress,
                capitalization: TextCapitalization.none,
              ),
              SizedBox(height: 15.0),
              CustomTextFormField(
                ctrl: _passwordCtrl,
                label: 'Password',
                password: true,
              ),
              SizedBox(height: 15.0),
              Text.rich(
                TextSpan(
                  text: 'Do not have an account yet?\t',
                  style: textTheme.subtitle1,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Sign Up',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: _signUpGestureDetector,
                    )
                  ],
                ),
              ),
              SizedBox(height: 15),
              CustomButton(
                child: Text('Sign In'),
                onPressed: () {
                  Provider.of<AccountController>(context, listen: false).signIn(
                    email: _emailCtrl.text.trim(),
                    password: _passwordCtrl.text.trim(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
