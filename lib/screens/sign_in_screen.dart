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
    ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final AccountController accountCtrl =
        Provider.of<AccountController>(context, listen: false);

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
              accountCtrl.authState == AuthenticationState.signInFailed
                  ? Text(
                      'Incorrect email or password!',
                      style: TextStyle(color: Colors.red),
                    )
                  : Container(),
              SizedBox(height: 5.0),
              CustomTextFormField(
                ctrl: _emailCtrl,
                label: 'E-mail',
                inputType: TextInputType.emailAddress,
                capitalization: TextCapitalization.none,
                validator: (String text) {
                  if (text.trim().isEmpty || text.trim().contains(' ')) {
                    return 'The e-mail can\'t be blank!';
                  } else if (!text.contains('@') ||
                      text.trim().length < 6 ||
                      text.trim().contains(' ')) {
                    return 'Invalid e-mail!';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15.0),
              CustomTextFormField(
                ctrl: _passwordCtrl,
                label: 'Password',
                password: true,
                validator: (String text) {
                  if (text.trim().isEmpty) {
                    return 'The password can\'t be blank!';
                  } else if (text.trim().length < 6) {
                    return 'The password must have at least 6 digits!';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15.0),
              Text.rich(
                TextSpan(
                  text: 'Do not have an account yet?\t',
                  style: textTheme.subtitle1.apply(color: theme.primaryColor),
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
                  if (_formKey.currentState.validate()) {
                    Provider.of<AccountController>(
                      context,
                      listen: false,
                    ).signIn(
                      email: _emailCtrl.text.trim(),
                      password: _passwordCtrl.text.trim(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
