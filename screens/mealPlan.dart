import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:recipes/elements/pageTitle.dart';
import 'package:recipes/functions/functions.dart';
import 'package:recipes/models/mealPlan.dart';
import 'package:recipes/models/user.dart';
import 'package:recipes/screens/assingRecipe.dart';
import 'package:recipes/services/database.dart';
import 'package:recipes/style/style.dart';
import 'package:flutter/material.dart';




class MealPlan extends StatefulWidget {
  @override
  MealPlanState createState() => MealPlanState();
}



class MealPlanState extends State<MealPlan> {
  String dropdownValue = '5';
  @override
  Widget build(BuildContext context) {
    UserID user = Provider.of<UserID>(context);
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("mealPlan").where("userId", isEqualTo: user.uid).snapshots(),
      builder: (context, snapshot) {
        return Scaffold(
          body: Container(
            child: Column(
              children: [

                pageTitle(context, "Meal Plan", false, false, setState),
                  


                Padding(
                  padding: EdgeInsets.only(right: 20, bottom: 30),
                  child:Align(
                  
                    alignment: Alignment.topRight,
                    child: DropdownButton(
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 25,
                      elevation: 15,
                      style: TextStyle(color: redTheme),
                      underline: Container(
                        height: 3,
                        color: redTheme

                      ),

                    
                      onChanged: (String newValue) {
                        setState((){
                          dropdownValue = newValue;
                        });
                      },
                      items: <String>['5', '6', '7', '8', '9', '10']
                        .map<DropdownMenuItem<String>>((String value){
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value + " days"),
                          );
                        }).toList(),
                    )
                  )
                
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: getEpochs(int.parse(dropdownValue)).length,
                    itemBuilder: (context, index){
                      return FutureBuilder(
                        future: getMeals(user.uid),
                        builder: (_, snapshot) {
                          String recipeString = "";
                          // print("Full meal stuff: ${Meals.meals}");
                          if(Meals.meals == null || Meals.meals.length > 0 ){
                            for(var item in Meals.meals){
                              if(item.data()['time'] == getEpochs(int.parse(dropdownValue))[index]){
                                
                                recipeString = "$recipeString${item.data()["title"]}\n";
                              }
                            }
                          }
                          if(recipeString == ""){
                            recipeString = "No Assigned Recipes";
                          }

                          return Container(
                            margin: EdgeInsets.all(15),
                            height: 160,
                            width: 320,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: redTheme, width: 4),
                              boxShadow: [
                                BoxShadow(
                                  color: redTheme,
                                  spreadRadius: 5,
                                  blurRadius: 1,
                                  offset: Offset(0, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:[
                                    Text(DateFormat("EEEE").format(DateTime.fromMillisecondsSinceEpoch(getEpochs(int.parse(dropdownValue))[index])), style: basicLargeWhite),
                                    IconButton(icon: Icon(Icons.add_box, color: Colors.white), onPressed: (){
                                      ActiveDay.day = getEpochs(int.parse(dropdownValue))[index];
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => AssingRecipe()),);
                                    })
                                  ]
                                ),
                                Text(recipeString, style: basicWhite, textAlign: TextAlign.center,)
                              ]
                            )
                          );
                        }
                      );
                    },
                  )
                )
              ]
            )
          )
        );
      }
    );
  }
}
