import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField(
      {this.ctrl,
      this.label,
      this.hint,
      this.readOnly = false,
      this.password = false,
      this.autovalidate = false,
      this.validator,
      this.onChanged,
      this.masks,
      this.inputType = TextInputType.text,
      this.capitalization = TextCapitalization.words,
      this.prefixIcon});
  final TextEditingController ctrl;
  final String label;
  final String hint;
  final bool readOnly;
  final bool password;
  final bool autovalidate;
  final Function validator;
  final Function onChanged;
  final List<TextInputFormatter> masks;
  final TextInputType inputType;
  final TextCapitalization capitalization;
  final Icon prefixIcon;

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  Widget _suffixIcon;
  TextCapitalization _capitalization;
  Function _validator;
  Function _onChanged;
  bool _password;

  void _changeTextVisibility() {
    setState(() {
      _password = !_password;
      if (_password) {
        _suffixIcon = FlatButton(
          textColor: Colors.black,
          child: Icon(Icons.visibility, color: Colors.green),
          onPressed: _changeTextVisibility,
        );
      } else {
        _suffixIcon = FlatButton(
          child: Icon(Icons.visibility_off, color: Colors.green),
          onPressed: _changeTextVisibility,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _password = widget.password;
    _capitalization = widget.capitalization;
    _validator = widget.validator;
    _onChanged = widget.onChanged;

    if (_validator == null) {
      _validator = (String text) => null;
    }

    if (_onChanged == null) {
      _onChanged = (String text) => null;
    }

    if (_password) {
      _capitalization = TextCapitalization.none;
      _suffixIcon = FlatButton(
        child: Icon(Icons.visibility, color: Colors.green),
        onPressed: _changeTextVisibility,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder _borderStyle = OutlineInputBorder(
      gapPadding: 2.5,
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(
        color: Theme.of(context).primaryColor,
      ),
    );

    return AbsorbPointer(
      absorbing: widget.readOnly,
      child: TextFormField(
        cursorColor: Theme.of(context).primaryColor,
        autovalidateMode: widget.autovalidate
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        readOnly: widget.readOnly,
        inputFormatters: widget.masks,
        textCapitalization: _capitalization,
        controller: widget.ctrl,
        obscureText: _password,
        keyboardType: widget.inputType,
        validator: _validator,
        onChanged: _onChanged,
        style: TextStyle(color: Theme.of(context).primaryColor),
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          labelStyle: TextStyle(color: Theme.of(context).primaryColor),
          hintStyle: TextStyle(color: Colors.green.shade800),
          labelText: widget.label,
          suffixIcon: _suffixIcon,
          hintText: widget.hint,
          contentPadding: EdgeInsets.only(top: 6.0, bottom: 6.0, left: 12.0),
          enabledBorder: _borderStyle,
          border: _borderStyle,
        ),
      ),
    );
  }
}
