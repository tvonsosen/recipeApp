import 'package:flutter/material.dart';
import 'package:recipes/style/style.dart';
// ! Not working super well at the moment - needs to have isselected
RecipesWidget(
  // ! Could add image as preview image
  BuildContext context,
  String recipeTitle,
  String servings,
  String prepTime,
  String ingredients,
  String instructions,
  double upvotesNumber,
  StateSetter setState,
  //Image asset
) {
  bool favorited;
  bool valueUp;
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12), 
      boxShadow: [
         BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 1,
          offset: Offset(0, 3), // changes position of shadow
                                  ),
                                 ],
      ),
    padding: EdgeInsets.all(15),
    height: 260,
    width: 320,
    child: Column(
      children: [
        InkWell(
        onTap: () {},
        child: Container(
          child: Column(
            
            children: [
              Text(
                recipeTitle,
                style: titleRecipes,
              ),
              
              
              // ! Image goes here
                
              
              Row(
                
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                
                children: [
                  Text(
                    "Servings: " + servings,
                    style: infoRecipes,
                  ),
                  Text("Prep Time: " + prepTime, style: infoRecipes),
                 
                ],
              ),
              
              //Text("Ingredients: " + ingredients, style: ingredientsRecipes)
            ],
            //upvote/downvote outside of inkwell
          )
          )
        ),
        Spacer(),
        Text("Ingredients: " + ingredients, style: ingredientsRecipes),
        Padding(
          padding: EdgeInsets.only(top: 15),
          child: Row(
          
          children: [
            Text(upvotesNumber.toString(), style: ingredientsRecipes),
            Spacer(flex:1),
            ToggleButtons(
              isSelected: [true, true],
              color: Colors.black.withOpacity(0.7),
              children: [
                Icon(Icons.arrow_upward), 
                Icon(Icons.arrow_downward)
              ],
            ),
            
            
            Spacer(flex: 5),
            ToggleButtons(
              color: Colors.black.withOpacity(0.7),
              isSelected: [true],
              children: [
                Icon(Icons.star)
              ],
            )
          ]
        ),
        ),
        ]
    )
  );
}
