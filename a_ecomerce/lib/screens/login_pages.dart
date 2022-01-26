
import 'package:a_ecomerce/widgets/custom_button.dart';
import 'package:a_ecomerce/widgets/custom_input.dart';
import 'package:a_ecomerce/screens/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constains.dart';

class Login_pages extends StatefulWidget {

  @override

  _Login_pagesState createState() => _Login_pagesState();
}

class _Login_pagesState extends State<Login_pages> {
  Future<void> _alertDialogBuilder(String error) async{
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text(error),
            ),
            actions: [
              FlatButton(
                child: Text("Close Dialog"),
                onPressed: (){
                  Navigator.pop(context);

                },
              )
            ],
          );
        }
    );
  }
  Future<String?> _loginAccount() async {
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: _loginEmail, password: _loginPassword);
      return null;
    }on FirebaseAuthException catch(e){
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch(e){
      print(e.toString());

    }

  }

  void _submitFrom() async{
    setState(() {
      _loginFromLoading = true;
    });


    String? _signAccountFeedback = await _loginAccount();
    if(_signAccountFeedback != null ) {
      _alertDialogBuilder(_signAccountFeedback);

      setState(() {
        _loginFromLoading = false;
      });
    } else {

      Navigator.pop(context);
    }
  }
  //-------
  bool _loginFromLoading  = false;
  //----input
  String  _loginEmail = "";
  String  _loginPassword ="";
  //---------
  late FocusNode _passwordFocusNode;

  @override
  void initState(){
    _passwordFocusNode = FocusNode();
    super.initState();
  }
  @override
  void dispose(){
    _passwordFocusNode.dispose();
    super.dispose();
  }




  Widget build(BuildContext context) {
    return  Scaffold(
      body:  SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 24.0,
              ),
              child: Text('Welcome User,\n Login to your account',
                textAlign: TextAlign.center,
                style: Constants.bolHeading,
              ),
            ),
            Column(
              children: [
                CustomInput(
                  hintText: 'Email...',
                  onChanged: (value){
                    _loginEmail = value;
                  }
                ),
                CustomInput(
                   hintText: 'Password...',
                   isPasswordField: true,
                   onChanged: (value){
                     _loginPassword = value;
                  },
                  focusNode: _passwordFocusNode,
                  onSubmitted: (value){
                    _submitFrom();
                  },
                ),
                CustomBtn(
                  isLoading: _loginFromLoading,
                  text:'Login',
                  onPressed: (){
                    //-----------------------
                    _submitFrom();
                    //----------------------
                    setState(() {
                      _loginFromLoading= true;
                    });
                  },
                ),

              ],
            ),
            //--------------------------
            Padding(
              padding: const EdgeInsets.only(
                bottom: 14.0,

              ),
              child: CustomBtn(
                isLoading: _loginFromLoading,
                color: Colors.transparent,
                color_text: Colors.black,
                text: "Create New Account ",
                 onPressed: (){
                  //-----------
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()
                   ),);
                   //-----
                   setState(() {
                     _loginFromLoading= true;

                   });
                 },
               ),
            )
          ],
        ),
      ),),
    );
  }
}
