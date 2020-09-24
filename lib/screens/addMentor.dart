import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:toast/toast.dart';

import '../scoped_models/shared.dart';
import '../scoped_models/mainModel.dart';

class AddMentor extends StatefulWidget {
  @override
  _AddMentorState createState() => _AddMentorState();
}

class _AddMentorState extends State<AddMentor> {
  final _emailController = TextEditingController();

  @override
  void initState() {
    _initializePage();
    super.initState();
  }

  void _initializePage() async {
    final _email = await Shared.getDoctorEmail();
    if (_email != null || _email != '') {
      _emailController.text = _email;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext conext, Widget child, MainModel model) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Container(
            margin: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),
          title: Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Text(
                "Add Doctor",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 18.0,
          ),
          child: Center(
            child: Column(
              children: [
                Container(
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    maxLines: null,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    try {
                      Shared.setDoctorEmail(_emailController.text);
                      model.sendThreapistEmail(_emailController.text);
                      Toast.show("Email Saved!", context,
                          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                      Navigator.pop(context);
                    } catch (err) {
                      print(err);
                      Toast.show("Error saving email!", context,
                          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 80,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    margin: EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blueAccent,
                    ),
                    child: Text(
                      "SUBMIT",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
