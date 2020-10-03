import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({this.disabled = false, this.child, this.onPressed});
  final Widget child;
  final Function onPressed;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      textColor: Theme.of(context).primaryColor,
      disabledBorderColor: Colors.black45,
      borderSide: BorderSide(color: Theme.of(context).primaryColor),
      child: child,
      onPressed: disabled ? null : onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }
}
