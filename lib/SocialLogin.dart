import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class SocialLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SocialLogin();
  }
}

class _SocialLogin extends State<SocialLogin> {
  String name, email, imageUrl, phone;
  final facebookLogin = FacebookLogin();

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
      appBar: AppBar(title: Text("Social Login")),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 120, child: RaisedButton(onPressed: () async {
              facebookLoginMethod();
            },child: Text("Facebook login"),color: Colors.blueAccent,)),
            SizedBox(
              width: 120,
              child: RaisedButton(
                onPressed: () async {
                  UserCredential userCred = await signInWithGoogle();
                  name = userCred.user.displayName;
                  imageUrl = userCred.user.photoURL;
                  email = userCred.user.email;
                  phone = userCred.user.phoneNumber;

                  setState(() {});
                },
                child: Row(
                  children: [Icon(Icons.login), Text("Login")],
                ),
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(name ?? "data"),
            Text(email ?? "data"),
            Text(phone ?? "data"),
            imageUrl == null ? SizedBox() : Image.network(imageUrl)
          ],
        ),
      ),
    );
  }


  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }


  Future<void> facebookLoginMethod() async {
    final result = await facebookLogin.logIn(['email','public_profile']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
        final profile = graphResponse.body;
        print(profile);
        //_showLoggedInUI();
        break;
      case FacebookLoginStatus.cancelledByUser:
       // _showCancelledMessage();
        break;
      case FacebookLoginStatus.error:
        print('result.errorMessage');
       // _showErrorOnUI(result.errorMessage);
        break;
    }
  }
}
