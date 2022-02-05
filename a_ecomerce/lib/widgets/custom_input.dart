import 'package:a_ecomerce/screens/constains.dart';
import 'package:flutter/material.dart';
class CustomInput extends StatelessWidget {
 final String hintText;
 final Function(String)? onChanged;
 final Function(String)? onSubmitted;
 final TextInputAction? textInputAction;
final bool isPasswordField;
 final FocusNode? focusNode;
   CustomInput({ this.onChanged , this.hintText='', this.focusNode , this.onSubmitted , this.textInputAction , this.isPasswordField = false}  );
  @override
  Widget build(BuildContext context) {
    bool _isPasswordField = isPasswordField ?? false;


    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 24.0,
      ),

      decoration: BoxDecoration(
       color: Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(12.0)

      ),
      child:  TextField(
        obscureText: _isPasswordField,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          textInputAction: textInputAction,
          decoration: InputDecoration(
          border:InputBorder.none ,
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 20.0,
        )

        ) ,
       style: Constants.regularDarkText,
      ),

    );
  }
}
