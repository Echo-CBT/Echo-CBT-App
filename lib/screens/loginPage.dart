import 'package:device_apps/device_apps.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:toast/toast.dart';

import '../models/user.dart';
import '../scoped_models/mainModel.dart';
import '../scoped_models/shared.dart';
import 'homePage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loading = false;

  @override
  void initState() {
    super.initState();
    print("Shared preferences initializing!");
    Shared.initialize();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> signInWithGoogle(MainModel model) async {
    setState(() {
      loading = true;
    });
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    // print('Registered User: $user');
    print('UID:');
    print(user.uid);
    if (user != null && user.uid != null) {
      var user1 = User.fromJson(
          {"uid": user.uid, "name": user.displayName, "email": user.email});
      //  model.logIn(user.uid, "Someone2");
      var mssg;
      try {
        var mssg = await model.register(user1);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return HomePage();
            },
          ),
        );
        Toast.show("Logged In!", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      } catch (err) {
        print("$err");
        if (err == "User already registered, try signing in!") {
          try {
            await model.logIn(user1.uid);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return HomePage();
                },
              ),
            );
          } catch (err) {
            Toast.show("Login Error!", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          }
        } else {
          Toast.show("Login Error!", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        }
      }
    }
    List<Application> apps = await DeviceApps.getInstalledApplications();
    print(apps);
    // //var resp=await
    // var resp=await _setUpListener(user.uid);
    // //var a=json.decode(user);
    // //print('JSON Decoded $a');
    // //setName("Someone");
    // //final LoginPage state=new LoginPage();
    // //state.setName(user.displayName);
    // //setName(user.displayName);
    // //print("Name Set: $name");
    // setEmail(user.email);
    // setUID(user.uid);
    // //var uid=user.uid;
    // //print('UID: $uid');
    // print(user.runtimeType);
    // print('User Email: '+user.email);
    // return 'signInWithGoogle succeeded: $user';
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
          body: loading
              ? Center(
                  child: Container(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.black,
                          child: Image(
                              image: AssetImage(
                                "images/support.png",
                              ),
                              height: 100,
                              width: 100),
                        ),
                        SizedBox(height: 40),
                        Text(
                          'ECHO',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 54,
                            fontWeight: FontWeight.w800,
                            wordSpacing: 18,
                            letterSpacing: 5.1,
                          ),
                        ),
                        SizedBox(height: 80),
                        _signInButton(model),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  Widget _signInButton(MainModel model) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .85,
      height: MediaQuery.of(context).size.width * .14,
      child: DecoratedBox(
        decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.black),
        child: OutlineButton(
          splashColor: Colors.white70,
          onPressed: () {
            signInWithGoogle(model);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          highlightElevation: 0,
          borderSide: BorderSide(color: Colors.black),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
