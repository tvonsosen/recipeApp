import 'package:recipes/elements/pageTitle.dart';
import 'package:recipes/services/auth.dart';
import 'package:recipes/shared/loading.dart';
import 'package:recipes/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipes/elements/recipeWidget.dart';
import 'package:recipes/screens/home.dart';
import 'package:recipes/screens/mealPlan.dart';



ShoppingListWidget(BuildContext context, String ingredient, bool addToList, StateSetter setState) {
  return Padding(
    padding: EdgeInsets.all(10),
    child: Row(

      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:[
        if(addToList == true)(
          Text(ingredient, style: titleRecipes)
        ) else(
          Text(ingredient, style: unusedingredients)
        ),
        if(addToList == true) (
          IconButton(icon: Icon(Icons.add), iconSize: 40)
        ) 
  ]))
  ;
}
class ShoppingList extends StatefulWidget {
  @override
  ShoppingListState createState() => ShoppingListState();
}

class ShoppingListState extends State<ShoppingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: EdgeInsets.only(top:20, bottom: 10),
          child: pageTitle(context, "Shopping List", false, false, setState),
      ),

      // List view for shopping list ingredients

        Expanded(
          child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Container(
              child: Column(children: [
                ShoppingListWidget(context, "Bread Bun", true, setState),
                ShoppingListWidget(context, "Mustard", false, setState),
                ShoppingListWidget(context, "Sausages", true, setState),
                ShoppingListWidget(context, "Ketchup", false, setState),
                ShoppingListWidget(context, "Relish", true, setState),
                ShoppingListWidget(context, "Frozen Curly Fries", true, setState),
           
          ]
          )
          );} ),
      ),
      ] )
      
    );
  }
}
