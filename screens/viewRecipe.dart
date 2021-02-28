import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:recipes/elements/pageTitle.dart';
import 'package:recipes/models/assigningRecipe.dart';
import 'package:recipes/models/user.dart';
import 'package:recipes/services/database.dart';
import 'package:recipes/shared/loading.dart';
import 'package:recipes/style/style.dart';


ingredientBuilder(BuildContext context, Map ingredients, double scale){
  return MediaQuery.removePadding(
    removeTop: true,
    context: context,
    child: ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: ingredients.length,
      itemBuilder: (context, index) {
        return Text("${ingredients[index.toString()]["amount"]*scale} ${ingredients[index.toString()]["unit"]} ${ingredients[index.toString()]["name"]}", style: basicBlack,);
      },
    )
  );
}

stepBuilder(BuildContext context, List steps){
  return MediaQuery.removePadding(
    removeTop: true,
    context: context,
    child: ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: steps.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(10),
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
          margin: EdgeInsets.only(bottom: 13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Step ${index+1}:", style: basicMediumBlack,),
              SizedBox(height: 4),
              Text(steps[index], style: basicBlack,)
            ]
          )
        );
      },
    )
  );
}


class ViewRecipe extends StatefulWidget {
  @override
  ViewRecipeState createState() => ViewRecipeState();
}

class ViewRecipeState extends State<ViewRecipe> {
  double scale = 1;
  String scaleString;

  @override
  Widget build(BuildContext context) {
    UserID user= Provider.of<UserID>(context);
    
    // recipe = getRecipe(AssignedRecipe.id);
    return FutureBuilder(
      future: getRecipeForPage(AssignedRecipe.id),
      builder: (_, snapshot) {
        var recipe = AssignedRecipe.data;
        if(recipe != null){
          return Scaffold(
            body: Container(
              child: Column(
                children: [

                  pageTitle(context, "Recipe", false, true, setState),

                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        margin: EdgeInsets.all(15),
                        child: Column(
                          // mainAxisSize: MainAxisSize.min,
                          children:[
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: 300
                              ),
                              child: Image.network(recipe["image"]),
                            ),
                            Text("${recipe["title"]}", style: basicLargeBlack,),
                            SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Servings: ${recipe["servings"]}", style: basicBlackBold,),
                                Text("Prep Time: ${recipe["prep"]}min", style: basicBlackBold,),
                                DropdownButton(
                                  value: scaleString,
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
                                      print(newValue);
                                      scaleString = newValue;
                                      scale = double.parse(newValue);
                                    });
                                  },
                                  items: <String>['.25', '.5', '1', '2', '3',]
                                    .map<DropdownMenuItem<String>>((String value){
                                      print(value);
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value + "x"),
                                      );
                                    }).toList(),
                                )
                              ],
                            ),
                            SizedBox(height: 10,),
                            Container(
                              padding: EdgeInsets.all(10),
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
                              child: Column(
                                children: [
                                  Text("Ingredients:", style: basicMediumBlack,),
                                  SizedBox(height: 10),
                                  ingredientBuilder(context, recipe["ingredients"], scale),
                                ]
                              )
                            ),
                            SizedBox(height: 13),
                            stepBuilder(context, recipe["steps"]),
                            

                            
                          ]
                        ),
                      ),
                    )
                  )
                ]
              ),
            ),
          );
        }
        return Loading();
      }
    );
  }
}