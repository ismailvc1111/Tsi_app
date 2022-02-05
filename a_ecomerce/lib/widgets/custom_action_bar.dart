import 'package:a_ecomerce/screens/cart_page.dart';
import 'package:a_ecomerce/screens/constains.dart';
import 'package:a_ecomerce/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class CustomActionBar extends StatelessWidget {
  final String? title ;
  final bool? hasBackArrow;
  final bool? hastitle;
  final bool? hasBackround;
  CustomActionBar({ this.title,  this.hasBackArrow ,  this.hastitle , this.hasBackround});
  FireabaseServices _firebaseService = FireabaseServices();
  final CollectionReference _userRef =
  FirebaseFirestore.instance.collection("User");

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrow ?? false;
    bool _hastitle = hastitle ?? true;
    bool _hasBackround = hasBackround ?? true;

    return Container(
      decoration: BoxDecoration(
        gradient: _hasBackround ? LinearGradient(
          colors: [
            Colors.white,
            Colors.white.withOpacity(0),
          ],
          begin: Alignment(0,0),
          end: Alignment(0,1),
        ):null
      ),
      padding: EdgeInsets.only(
        top:    56.0,
        left:   24.0 ,
        right:  24.0,
        bottom: 42.0 ,

      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if(_hasBackArrow)
             GestureDetector(
               onTap: (){
                 Navigator.pop(context);
               },
               child: Container(
                 width: 52.0,
                 height: 52.0,
                 decoration: BoxDecoration(
                     color: Colors.black,
                   borderRadius: BorderRadius.circular(8.0),

                 ),
                 alignment: Alignment.center,
                 child: Image(
                   image: AssetImage("assets/images/back_arrow.png"),
                   color: Colors.white,
                   width: 16.0,
                   height: 18.0,
                 ),
               ),
             ),
            if(_hastitle)
               Text(
               title ??"Action Bar",
               style:  Constants.bolHeading,
                 ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => CartPage(),

              )
              );
            },
            child: Container(
              width: 52.0,
              height: 52.0,
              decoration: BoxDecoration(
              color: Colors.black ,
              borderRadius: BorderRadius.circular(8.0),
              ),
             alignment: Alignment.center,
             child: StreamBuilder<QuerySnapshot>(
               stream: _userRef.doc(_firebaseService.getUserid()).collection("Cart").snapshots(),
               builder: (context, snapshot){
                 int _totalItems = 0;
                 if(snapshot.connectionState == ConnectionState.active){

                   List _documents = snapshot.data!.docs;
                   _totalItems = _documents.length;
                 }
                return Text(
                      "$_totalItems" ?? "0",//7:11
                     style: TextStyle(
                       fontSize: 18.0 ,
                       fontWeight: FontWeight.w600,
                       color: Colors.white,

                     )

                 );
               },
             ),
         ),
          )
        ],
      )
    );
  }
}
