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
  int upvotesNumber,
  StateSetter setState,
  //Image asset
) {
  // bool favorited;
  // bool valueUp;
  return Container(
    margin: EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12), 
      boxShadow: [
         BoxShadow(
          color: Colors.grey.withOpacity(0.15),
          spreadRadius: 10,
          blurRadius: 5,
          offset: Offset(0, 0), // changes position of shadow
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
            
            // ToggleButtons(
            //   isSelected: [true, true],
            //   color: Colors.black.withOpacity(0.7),
            //   children: [
            //     Icon(Icons.arrow_upward), 
            //     Icon(Icons.arrow_downward)
            //   ],
            // ),
            IconButton(
              icon: Icon(Icons.arrow_upward, color: Colors.black.withOpacity(0.7)),
              iconSize: 35
            ),
            Text(upvotesNumber.toString(), style: ingredientsRecipes),
            IconButton(
              icon: Icon(Icons.arrow_downward, color: Colors.black.withOpacity(0.7)),
              
              iconSize: 35
            ),
            
            
            Spacer(flex: 7),
            IconButton(
              
              icon: Icon(Icons.star, color: Colors.black.withOpacity(0.7)),
              iconSize: 35
            )
          ]
        ),
        ),
      ]
    )
  );
}
