import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipes/elements/pageTitle.dart';
import 'package:recipes/screens/createRecipe.dart';
import 'package:recipes/services/auth.dart';
import 'package:recipes/shared/loading.dart';
import 'package:recipes/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipes/elements/recipeWidget.dart';
import 'package:recipes/screens/mealPlan.dart';
import 'package:recipes/screens/shoppingList.dart';

class HomePage extends StatefulWidget {
  final Function toggleView;
  HomePage({this.toggleView});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        statusBarBrightness: Brightness.light // this one for iOS
      )
    );

    return loading ? Loading() : Scaffold(
      backgroundColor: backgroundColor,
      body: Theme(
        data: ThemeData(
          primaryColor: redTheme,
          accentColor: redTheme,
          hintColor: redTheme
        ),
        child: Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 25),
                      child: pageTitle(
                          context, "Recipes", true, false, setState),
                    )
                  ],
                ),

                // Row for favorites and folder of my recipes of user
                Container(
                  padding: EdgeInsets.only(bottom:30,),
                  decoration: BoxDecoration(
                    // color: lightGrey,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Ink(
                            decoration: ShapeDecoration(
                              color: redTheme, shape: CircleBorder()
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.star,
                                color: Colors.white,
                              ),
                              iconSize: 80,
                              onPressed: null
                            ),
                          ),
                          Text("Favorites")
                        ],
                      ),
                      Column(
                        children: [
                          Ink(
                            decoration: ShapeDecoration(
                                color: redTheme, shape: CircleBorder()
                              ),
                            child: IconButton(
                              icon: Icon(Icons.folder, color: Colors.white),
                              iconSize: 80,
                              onPressed: null,
                            ),
                          ),
                          Text("My Recipes")
                        ],
                      ),
                    ]
                  ),
                ),

                
                Container(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('recipes').snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                      // for(var item in snapshot.data.docs){
                      //   print(item.id);
                      // }
                      if(!snapshot.hasData){
                        return Loading();
                      }
                      List schedulesList = snapshot.data.docs.toList();
                      return Container(
                        
                        // margin: EdgeInsets.only(left:15, right: 15),

                              
                        child: Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            clipBehavior: Clip.none,
                            scrollDirection: Axis.vertical,
                            itemCount: schedulesList.length,
                            itemBuilder: (context, index){
                              return RecipesWidget(context, "Hot Dogs", "2", "20 min", "Hot Dogs and Buns", "Cook hot dogs, put into buns", 20, setState);
                            }
                          )
                        )
                      );

                    }
                  ),
                )
                
                
              ]
            ),
          ),
          floatingActionButton: FloatingActionButton(
            focusColor: redTheme,
            child: Icon(Icons.add, size: 30,),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => CreateRecipe()),);
            },
          ),
        ),
      )
    );
  }
}
