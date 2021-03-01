

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class SocialLogin extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SocialLogin();
  }


}


class _SocialLogin extends State<SocialLogin>{

  String name, email, imageUrl,phone;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title:Text("Social Login")),
      body: Container(
        width: double.infinity,
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 120,
              child: RaisedButton(onPressed: () async {
                UserCredential userCred= await  signInWithGoogle();
                 name= userCred.user.displayName;
                imageUrl=userCred.user.photoURL;
                email= userCred.user.email;
                phone= userCred.user.phoneNumber;

                setState(() {

                });
              },child: Row(
                children: [
                  Icon(Icons.login),
                  Text("Login")
                ],
              ),
              color: Colors.blueAccent,),
            ),

            SizedBox(height: 10,),
            Text(name??"data"),
            Text(email??"data"),
            Text(phone??"data"),
            imageUrl==null?SizedBox():Image.network(imageUrl)
          ],
        ),
      ),
    );
  }


  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );


    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

}