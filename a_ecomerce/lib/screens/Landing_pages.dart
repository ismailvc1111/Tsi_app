import 'package:a_ecomerce/screens/constains.dart';
import 'package:a_ecomerce/screens/home_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login_pages.dart';

class LadingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(

        future: _initialization,
        builder: (BuildContext  context,  snapshot ) {
          if (snapshot.hasError) {
            return Scaffold(
              body:  Center(
                child: Text('Hello world ${snapshot.hasError}',
                  style: Constants.regularHeding,
                ),
                ),
            );
          }
          //--------------------------------------------------------------------
          if(snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges() ,
              builder:(context,Stremsnapshot) {
                if (Stremsnapshot.hasError) {
                  return Scaffold(
                    body:  Center(
                      child: Text('Hello world ${Stremsnapshot.hasError}',
                        style: Constants.regularHeding,

                      ),
                    ),
                  );
                }//--------------------------------------------------------------
                if(Stremsnapshot.connectionState == ConnectionState.active){
                  //Get User
                  Object? _user = Stremsnapshot.data ;
                  //si el usuario aun no esta logeado en el sistema
                  if(_user == null){
                   return Login_pages();
                  }else {
                    return HomePage();
                  }
                }


                //slash screen
                return Scaffold(
                    body:  Center(
                      child: Text('Checking auth ',
                        style: Constants.regularHeding,

                      ),

                    )
                );
            //------------------------------------------------------------------




                } ,
            );

          }
          return Scaffold(
              body:  Center(
                child: Text('Appp incialializada ',
                  style: Constants.regularHeding,
                ),
              ));

        }

    );
  }}