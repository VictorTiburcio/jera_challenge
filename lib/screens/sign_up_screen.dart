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
      body: Builder(
        builder: (context) {
          return Center(
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
                      validator: (String text) {
                        if (text.trim().isEmpty) {
                          return 'The name can\'t be blank!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15.0),
                    InkWell(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              readOnly: true,
                              ctrl: _birthdayCtrl,
                              label: 'Birthday',
                              hint: 'DD/MM/YYYY',
                              validator: (String text) {
                                if (text.isEmpty) {
                                  return 'The birthday can\'t be blank!';
                                }
                                return null;
                              },
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
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: calendar,
                    ),
                    SizedBox(height: 15.0),
                    CustomTextFormField(
                      ctrl: _emailCtrl,
                      label: 'Email',
                      hint: 'example@example.com',
                      capitalization: TextCapitalization.none,
                      validator: (String text) {
                        if (text.trim().isEmpty) {
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
                      capitalization: TextCapitalization.none,
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
                    CustomTextFormField(
                      ctrl: _passwordConfirmationCtrl,
                      label: 'Password confirmation',
                      capitalization: TextCapitalization.none,
                      password: true,
                      validator: (String text) {
                        if (text != _passwordCtrl.text.trim()) {
                          return 'Password confirmation mismatch!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15.0),
                    CustomButton(
                      child: Text('Sign Up'),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          Map<String, dynamic> data = {
                            'name': _nameCtrl.text,
                            'email': _emailCtrl.text,
                            'birthday': _birthdayCtrl.text,
                            'password': _passwordCtrl.text.trim(),
                          };

                          bool failed = await Provider.of<AccountController>(
                            context,
                            listen: false,
                          ).signUp(data: data);

                          if (failed) {
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'E-mail already have been taken.',
                                ),
                                backgroundColor: Color(0xff1565C0),
                              ),
                            );
                          } else {
                            Navigator.pop(context);
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void calendar() {
    showDatePicker(
      helpText: 'Select Date',
      context: context,
      initialDate: DateTime(2000, 1, 15),
      firstDate: DateTime.now().subtract(Duration(days: 36500)),
      lastDate: DateTime.now(),
    ).then((date) {
      if (date != null) {
        setState(() {
          _birthdayCtrl.text = DateFormatter.dateToString(
            date,
            'dd/MM/yyyy',
          );
        });
      }
    });
  }
}
