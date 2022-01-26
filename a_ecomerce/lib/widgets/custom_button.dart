import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool isLoading;
  final Color? color;
  final Color? color_text;
  CustomBtn( { required this.text,  required this.onPressed, required this.isLoading ,this.color,this.color_text  }  ) {

  }
  @override
  Widget build(BuildContext context) {
    bool _isLoading = isLoading ?? false;
    Color _colors = color ?? Colors.black;
    Color _color_text = color_text ?? Colors.white;
    return GestureDetector(
     onTap: onPressed,
     child: Container(
      height: 65.0,

      decoration: BoxDecoration(
        color: _colors ,
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
     margin: EdgeInsets.symmetric(
        horizontal: 23.0,
        vertical: 23.0,
     ) ,
       child: Stack(
         children: [
           Visibility(
             visible:  _isLoading ? false : true,
             child: Center(
               child: Text(
                 text ?? "Text",
                 style: TextStyle(
                   fontSize: 16.0,
                   color:  _color_text ,
                   fontWeight: FontWeight.w600,
                 ),
               ),
             ),
           ),
           Visibility(
             visible: _isLoading ,
             child: Center(
               child: SizedBox(
                 height: 30.0,
                 width: 30.0,
                 child: CircularProgressIndicator(),
               ),
             ),
           ),
         ],
       ),

    ),


    );
  }
}
