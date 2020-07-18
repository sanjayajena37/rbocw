import 'package:flutter/material.dart';
import 'package:rbocw/providers/app_data.dart';

class PhoneNumberField extends StatefulWidget {
  final bool textAction;
  final ValueChanged<String> onSubmitted;
  final String hintText;
  const PhoneNumberField(
      {Key key, this.textAction = true, this.onSubmitted, this.hintText})
      : super(key: key);
  @override
  _PhoneNumberFieldState createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppData.kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: Colors.grey.withOpacity(0.5),
      //     width: 1.0,
      //   ),
      //   borderRadius: BorderRadius.circular(20.0),
      // ),
      // margin: const EdgeInsets.symmetric(
      //     vertical: 10.0, horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                // hint: Text("Select Device"),
                value: AppData.currentSelectedValue,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    AppData.currentSelectedValue = newValue;
                  });
                  print(AppData.currentSelectedValue);
                },
                items: AppData.phoneFormat.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          Container(
            height: 35.0,
            width: 1.0,
            color: Colors.grey.withOpacity(0.5),
            margin: const EdgeInsets.only(left: 00.0, right: 10.0),
          ),
          new Expanded(
            child: TextField(
              cursorColor: AppData.kPrimaryColor,
              textInputAction: widget.textAction
                  ? TextInputAction.done
                  : TextInputAction.next,
              maxLength: 10,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: InputBorder.none,
                counterText: "",
                hintText: widget.hintText,
                hintStyle: TextStyle(color: Colors.grey),
              ),
              onSubmitted: widget.onSubmitted,
            ),
          )
        ],
      ),
    );
  }
}
