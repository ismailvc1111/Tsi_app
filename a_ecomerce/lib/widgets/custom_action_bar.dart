import 'package:a_ecomerce/screens/constains.dart';
import 'package:flutter/material.dart';
class CustomActionBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top:    56.0,
        left:   24.0 ,
        right:  24.0,
        bottom: 24.0 ,

      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Action Bar",
           style:  Constants.bolHeading,
          ),
         Container(
           decoration: BoxDecoration(
          color: Colors.black
           ),
           child: Text(
             "0",//7:11
           style: TextStyle(
               fontSize: 16.0 ,
              fontWeight: FontWeight.w600,
              color: Colors.white,

           )

           ),
         )
        ],
      )
    );
  }
}
