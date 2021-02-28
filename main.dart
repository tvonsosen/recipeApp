import 'package:recipes/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipes/screens/wrapper.dart';
import 'package:recipes/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:recipes/models/user.dart';
import 'package:firebase_core/firebase_core.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {  
  
  @override
  Widget build(BuildContext context) {
    

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white, // this one for android
      statusBarBrightness: Brightness.light// this one for iOS
    ));
  
    return StreamProvider<UserID>.value(
      value: AuthService().user,
      child: Theme(
        data: ThemeData(
          primaryColor: redTheme,
          accentColor: redTheme,
          hintColor: redTheme
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Wrapper(),
        ),
      )
    );
  }
}