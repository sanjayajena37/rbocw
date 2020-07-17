import 'package:flutter/material.dart';
import 'package:rbocw/providers/app_data.dart';
import 'package:rbocw/widgets/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final textField;
  final textAction;
  final TextEditingController controller;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.onSubmitted,
    this.textField = true,
    this.textAction = false,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        maxLength: 10,
        onSubmitted: onSubmitted,
        cursorColor: AppData.kPrimaryColor,
        textInputAction:
            textAction ? TextInputAction.done : TextInputAction.next,
        keyboardType: textField ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: AppData.kPrimaryColor,
          ),
          hintText: hintText,
          counterText: "",
          border: InputBorder.none,
        ),
      ),
    );
  }
}
