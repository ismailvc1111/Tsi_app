import 'package:a_ecomerce/screens/constains.dart';
import 'package:a_ecomerce/services/firebase_services.dart';
import 'package:a_ecomerce/widgets/custom_action_bar.dart';
import 'package:a_ecomerce/widgets/image_swipe.dart';
import 'package:a_ecomerce/widgets/product_size.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ProductPage extends StatefulWidget {
 final String productId;
 ProductPage({required this.productId});


 @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FireabaseServices _firebaseService = FireabaseServices();


  String _selectedProductSize = "0";
  _addToCart(){
    return _firebaseService.userRef
        .doc(_firebaseService.getUserid())
        .collection("Cart")
        .doc(widget.productId)
        .set({"size": _selectedProductSize});
  }
 final SnackBar _snackBar = SnackBar(content: Text("Product addes to the cart"),);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
           children: [
             FutureBuilder<DocumentSnapshot>(
              future:_firebaseService.productRef.doc(widget.productId).get() ,
               builder: ( context, snapshot){
                 if(snapshot.hasError){
                   return Scaffold(
                     body: Center(
                       child: Text(
                           "Error : ${snapshot.error}"),
                     ),
                   );
                 }
                 if(snapshot.connectionState == ConnectionState.done){
                   Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                   //List of images
                   List imageList = data["images"];
                   List productsize = data["size"];
                   _selectedProductSize = productsize[0];


                   return ListView(
                     padding: EdgeInsets.all(0),
                     children: [
                       ImageSwipe(imageList: imageList,),
                         Padding(
                           padding: const EdgeInsets.only(
                             top: 24.0,
                             left: 24.0,
                             right: 24.0,
                             bottom: 4.0,
                           ),
                           child: Text( "${data["name "]}" ??"Product Name",
                           style: Constants.bolHeading,
                       ),
                         ),
                         Padding(
                           padding:const EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 24.0,
                            ),
                           child: Text( "${data["name "]}",
                           style: TextStyle(
                           fontSize: 18.0,
                           color:Theme.of(context).accentColor,
                           fontWeight: FontWeight.w600,
                       ),
                       ),
                         ),
                         Padding(
                         padding: const EdgeInsets.symmetric(
                           vertical: 4.0,
                            horizontal: 24.0,
                            ),
                         child: Text("${data["desc"]}",
                             style: TextStyle(
                             fontSize: 16.0,
                             ),
                         ),
                       ),
                         Padding(
                          padding:const EdgeInsets.symmetric(
                          vertical: 24.0,
                          horizontal: 24.0,
                 ),
                         child: Text(
                             "Select Size",
                             style: Constants.regularDarkText,
                         ),
                       ),
                      product_size(
                        productsize: productsize,
                        onSelector: (size){
                          _selectedProductSize = size;
                        },
                      ),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             Padding(
                               padding: const EdgeInsets.all(22.0),
                               child: Container(
                                 width :65.0,
                                 height: 65.0,
                                 decoration: BoxDecoration(
                                   color:  Color(0xFFDCDCDC),
                                   borderRadius: BorderRadius.circular(12.0),
                                 ),

                                 alignment :Alignment.center,
                                 child: Image(
                                   image: AssetImage('assets/images/tab_saved.png'),
                                   height: 22.0,
                                 ),
                               ),
                             ),

                             Expanded(
                               child: GestureDetector(
                                 onTap:() async{
                                   await _addToCart();
                                  Scaffold.of(context).showSnackBar(_snackBar);
                                 },
                                 child: Container(
                                   height: 65.0,
                                   margin: EdgeInsets.only(
                                     left: 16.0,
                                   ),
                                   decoration: BoxDecoration(
                                     color: Colors.black,
                                     borderRadius: BorderRadius.circular(12.0),
                                   ),

                                   alignment: Alignment.center,
                                   child: Text("Addd To Cart",
                                     style: TextStyle(
                                       color:Colors.white ,
                                         fontSize: 16.0,
                                         fontWeight: FontWeight.w600
                                     ),
                                   ),
                                 ),
                               ),
                             ),
                           ],
                         ),
                       )
                     ],
                   );
                 }
                 //Loading
                 return Scaffold(
                   body: Center(
                     child: CircularProgressIndicator(),
                   ),
                 );

               },
            ),
           CustomActionBar(
             hasBackArrow: true,
             hastitle: false,
           ),

           ],
        )
      );
  }
}
