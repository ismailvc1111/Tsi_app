import 'package:a_ecomerce/screens/constains.dart';
import 'package:a_ecomerce/screens/product_page.dart';
import 'package:a_ecomerce/widgets/custom_action_bar.dart';
import 'package:a_ecomerce/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class HomeTab extends StatelessWidget {
  final  CollectionReference _producRef = FirebaseFirestore.instance.collection("Products");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
     children: [
       //--------------------------------------
       FutureBuilder<QuerySnapshot>(
       future: _producRef.get(),
         builder: ( context, snapshot) {
         if(snapshot.hasError){
          return Scaffold(
            body: Center(
              child: Text(
                "Error : ${snapshot.error}"),
            ),
          );
         }
         if(snapshot.connectionState== ConnectionState.done){
           return ListView(
             padding: EdgeInsets.only(
               top: 108.0,
               bottom: 12.0,
             ),
             children: snapshot.data!.docs.map((DocumentSnapshot  document){
               Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
  //data['images'][0]
  // data["name "]  ??"Product Name"
  //  ${data["price"]}" ??"Price"
  //
               return ProductCard(
                 title: data['name '],
                 imageUrl: data['images'][0],
                 price: "\$${data['price']}",
                 productId: document.id,
               );
           }).toList(),
           );
         }
         return Scaffold(
           body: Center(
             child: CircularProgressIndicator(),
                 ),
                 );





         },
       ),
       //-------------------------------------


       CustomActionBar(
         title: "Home",
         hasBackArrow: false,

       ),
     ],

      ),

    );
  }
}
