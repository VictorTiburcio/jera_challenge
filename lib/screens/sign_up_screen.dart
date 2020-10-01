import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/account_controller.dart';
import '../utils/date_formatter.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  static const String route = '/sign_up';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _birthdayCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _passwordConfirmationCtrl =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  ctrl: _nameCtrl,
                  label: 'Name',
                  hint: 'Pedro',
                ),
                SizedBox(height: 15.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        readOnly: true,
                        ctrl: _birthdayCtrl,
                        label: 'Birthday',
                        hint: 'DD/MM/YYYY',
                      ),
                    ),
                    SizedBox(width: 15.0),
                    Padding(
                      padding: const EdgeInsets.only(top: 1.0),
                      child: SizedBox(
                        height: 46.5,
                        width: 60,
                        child: CustomButton(
                          child: Icon(Icons.today),
                          onPressed: () {
                            showDatePicker(
                              helpText: 'Select Date',
                              context: context,
                              initialDate: DateTime(2000, 1, 15),
                              firstDate: DateTime.now()
                                  .subtract(Duration(days: 36500)),
                              lastDate: DateTime.now(),
                            ).then((date) {
                              if (date != null) {
                                setState(() {
                                  _birthdayCtrl.text =
                                      DateFormatter.dateToString(
                                    date,
                                    'dd/MM/yyyy',
                                  );
                                });
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.0),
                CustomTextFormField(
                  ctrl: _emailCtrl,
                  label: 'Email',
                  hint: 'example@example.com',
                  capitalization: TextCapitalization.none,
                ),
                SizedBox(height: 15.0),
                CustomTextFormField(
                  ctrl: _passwordCtrl,
                  label: 'Password',
                  capitalization: TextCapitalization.none,
                  password: true,
                ),
                SizedBox(height: 15.0),
                CustomTextFormField(
                  ctrl: _passwordConfirmationCtrl,
                  label: 'Password confirmation',
                  capitalization: TextCapitalization.none,
                  password: true,
                ),
                SizedBox(height: 15.0),
                CustomButton(
                  child: Text('Sign Up'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Map<String, dynamic> data = {
                        'name': _nameCtrl.text,
                        'email': _emailCtrl.text,
                        'birthday': _birthdayCtrl.text,
                        'password': _passwordCtrl.text.trim(),
                      };

                      Provider.of<AccountController>(
                        context,
                        listen: false,
                      ).signUp(data: data);
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
