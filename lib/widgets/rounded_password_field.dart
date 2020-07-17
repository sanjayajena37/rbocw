import 'package:flutter/material.dart';
import 'package:rbocw/providers/app_data.dart';
import 'package:rbocw/widgets/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: AppData.kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: AppData.kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: AppData.kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
