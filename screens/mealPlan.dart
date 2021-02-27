import 'package:recipes/elements/pageTitle.dart';
import 'package:recipes/services/auth.dart';
import 'package:recipes/shared/loading.dart';
import 'package:recipes/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipes/elements/recipeWidget.dart';
import 'package:recipes/screens/home.dart';
import 'package:recipes/screens/shoppingList.dart';

class MealPlan extends StatefulWidget {
  @override
  MealPlanState createState() => MealPlanState();
}

class MealPlanState extends State<MealPlan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
                
            pageTitle(context, "Meal Plan", false, false, setState),

            DropdownButton(
              // value: dropdownValue,
              //items: ,
              onChanged: null
            )
            
          ]
        )
      )
        
    );
     
        
  }
}
