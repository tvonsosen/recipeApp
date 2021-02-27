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
              // Where image would go
              Row(
                children: [
                  Text(
                    "Servings: " + servings,
                    style: infoRecipes,
                  ),
                  Text("Prep Time:" + prepTime)
                ],
              ),
              Text("Ingredients:" + ingredients, style: ingredientsRecipes)
            ],
            //upvote/downvote outside of inkwell
          )
          )
        ),
        Row(
          children: [
            ToggleButtons(
              isSelected: [true, true],
              color: Colors.black.withOpacity(0.7),
              children: [
                Icon(Icons.arrow_upward), 
                Icon(Icons.arrow_downward)
              ],
            ),
            Text(upvotesNumber.toString(), style: ingredientsRecipes),
            Spacer(),
            ToggleButtons(
              color: Colors.black.withOpacity(0.7),
              isSelected: [true],
              children: [
                Icon(Icons.star)
              ],
            )
          ]
        ),
      ]
    )
  );
}
