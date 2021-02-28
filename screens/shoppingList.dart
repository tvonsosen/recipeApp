import 'package:recipes/elements/pageTitle.dart';
import 'package:recipes/services/auth.dart';
import 'package:recipes/shared/loading.dart';
import 'package:recipes/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipes/elements/recipeWidget.dart';
import 'package:recipes/screens/home.dart';
import 'package:recipes/screens/mealPlan.dart';

ShoppingListWidget(BuildContext context, String ingredient1, bool addToList, StateSetter setState) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children:[
      Text(ingredient1, style: titleRecipes),
    if(addToList == true) (
      IconButton(icon: Icon(Icons.add), iconSize: 30)
  )])
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
          padding: EdgeInsets.all(20),
          child: pageTitle(context, "Shopping List", false, false, setState),
      )],)
    );
  }
}
