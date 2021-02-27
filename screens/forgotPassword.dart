import 'package:recipes/services/auth.dart';
import 'package:recipes/style/inputDecoration.dart';
import 'package:recipes/shared/loading.dart';
import 'package:recipes/style/style.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:recipes/elements/pageTitle.dart';
import 'package:flutter/services.dart';




class ForgotPassword extends StatefulWidget {

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white, // this one for android
      statusBarBrightness: Brightness.light// this one for iOS
    ));

    return loading ? Loading() : Scaffold(
    
  
      backgroundColor: backgroundColor,
      body: Theme(
        data: ThemeData(
          // primaryColor: redTheme,
          // accentColor: redTheme,
          // hintColor: redTheme
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              
              children: <Widget>[
                SizedBox(height: 20.0),
                pageTitle(context, "Forgot Password", true, true, setState),
                SizedBox(height: 20.0),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                      
                        SizedBox(height: 35.0),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(hintText: 'email'),
                          validator: (val) => val.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        SizedBox(height: 30.0),
                        RaisedButton(
                          padding: EdgeInsets.all(7),
                          color: redTheme,
                          child: Text(
                            'Send Reset Email',
                            style: basicWhite,
                          ),
                          onPressed: () async {
                            if(_formKey.currentState.validate()){
                              AuthService().forgotPassword(email);
                              return showDialog(
                                context: context,
                                barrierDismissible: false, 
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: backgroundColor,
                                    title: Text('Insturctions'),
                                    content: StatefulBuilder(
                                      builder: (BuildContext context, StateSetter setState) {
                                        return Text("Your email has sent to $email, please follow instructions there to continue to reset your password. Once done return to the app.");
                                      }
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Close'),
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }
                        ),
                        SizedBox(height: 27.0),
                        
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        )
                      ]
                    )
                  )
                ),
                SizedBox(height:175)
              ],
            ),
          ),
        ),
      ),
    );
  }
  
}

































