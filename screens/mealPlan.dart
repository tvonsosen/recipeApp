import 'package:recipes/elements/pageTitle.dart';
import 'package:recipes/services/auth.dart';
import 'package:recipes/shared/loading.dart';
import 'package:recipes/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipes/elements/recipeWidget.dart';
import 'package:recipes/screens/home.dart';
import 'package:recipes/screens/shoppingList.dart';

// Each day meal plan boxes class

MealDays (BuildContext context, String day, String mealNames, StateSetter setState){
  return Container(
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
    child: Column(children: [
      Align(
        alignment: Alignment.topLeft,
        child: Padding(
        
          padding: EdgeInsets.all(10),
          
          child: Text(day, style: mealPlanTitle),
        
           )
     ),
      Spacer(),
      Align(
        alignment: Alignment.bottomRight,
        child: IconButton(
          icon: Icon(Icons.add, color: Colors.white),
            iconSize: 30),
    ),
    ],)

  
    );
    
  

}
class MealPlan extends StatefulWidget {
  @override
  MealPlanState createState() => MealPlanState();
}

class MealPlanState extends State<MealPlan> {
  String dropdownValue = '5 Days';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 10, left: 10),
                  child: pageTitle(
                    context, "Meal Plan", false, false, setState),
                    )
                  ],
                ),


            Padding(
              padding: EdgeInsets.only(right: 20, bottom: 30),
              child:Align(
              
                alignment: Alignment.topRight,
                child: DropdownButton(
                  value: dropdownValue,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 35,
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
                  items: <String>['5 Days', '6 days', '7 days', '8 days', '9 days', '10 days']
                    .map<DropdownMenuItem<String>>((String value){
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
              )
        )
             
            ),
            // Column(children: [
              
            //   ListView(
            //   padding: EdgeInsets.all(10),
            //   children: [

                MealDays(context, 'Monday', 'Hot Dogs', setState),
            //     MealDays(context, 'Tuesday', 'Hot Dogs', setState),
            //     MealDays(context, 'Wednesday', 'Hot Dogs', setState),
            //     MealDays(context, 'Thursday', 'Hot Dogs', setState),
            //     MealDays(context, 'Friday', 'Hot Dogs', setState),

            // ],
            // ), ],)
            ]
        )
      )
        
    );
     
        
  }
}
