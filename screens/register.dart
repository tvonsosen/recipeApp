import 'package:recipes/models/registerForm.dart';
import 'package:recipes/services/auth.dart';
import 'package:recipes/style/inputDecoration.dart';
import 'package:recipes/shared/loading.dart';
import 'package:recipes/style/style.dart';
import 'package:flutter/material.dart';
import 'package:recipes/elements/pageTitle.dart';
import 'package:flutter/services.dart';




class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String comfirmPassword = '';
  String firstName = '';
  String lastName = '';


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white, // this one for android
      statusBarBrightness: Brightness.light// this one for iOS
    ));
    return loading ? Loading() : Scaffold(
    
  
      backgroundColor: backgroundColor,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              pageTitle(context, "Sign Up", false, false, setState),
              SizedBox(height: 20.0),
              SizedBox(height: 35.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'email'),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: ((MediaQuery.of(context).size.width)/2)-55,
                    child: TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'first name'),
                      validator: (val) => val.length < 1 ? 'Enter a first name' : null,
                      onChanged: (val) {
                        setState(() => RegisterForm.firstName = val);
                      },
                    ),
                  ),
                  Container(
                    width: ((MediaQuery.of(context).size.width)/2)-55,
                    child: TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'last name'),
                      validator: (val) => val.length < 1 ? 'Enter a last name' : null,
                      onChanged: (val) {
                        setState(() => RegisterForm.lastName = val);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'password'),
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'comfirm password'),
                obscureText: true,
                validator: (val) => val != password ? 'Enter the same password' : null,
                onChanged: (val) {
                  setState(() => comfirmPassword = val);
                },
              ),
              SizedBox(height: 30.0),
              RaisedButton(
                padding: EdgeInsets.all(7),
                color: redTheme,
                child: Text(
                  'Register',
                  style: basicWhite,
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if(result == null) {
                      setState(() {
                        loading = false;
                        error = 'Please supply a valid email';
                      });
                    }
                    // else{
                    //   print("hi");
                    // }
                  }
                }
              ),
              SizedBox(height: 27.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Have an account, ", style: basicBlack,),
                  InkWell(
                    child: Text("Sign In", style: basicBlue,),
                    onTap: () => widget.toggleView(),
                  ),
                  Text("!", style: basicBlack,)
                ],
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}