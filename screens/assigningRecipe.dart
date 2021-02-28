import 'package:provider/provider.dart';
import 'package:recipes/elements/pageTitle.dart';
import 'package:recipes/models/mealPlan.dart';
import 'package:recipes/models/recipe.dart';
import 'package:recipes/models/user.dart';
import 'package:recipes/services/database.dart';
import 'package:recipes/shared/loading.dart';
import 'package:recipes/style/inputDecoration.dart';
import 'package:recipes/style/style.dart';
import 'package:flutter/material.dart';




class AssigningRecipe extends StatefulWidget {
  @override
  AssigningRecipeState createState() => AssigningRecipeState();
}

class AssigningRecipeState extends State<AssigningRecipe> {
  bool results = false; 
  List<String> searchResults;
  String query = "";
  @override
  Widget build(BuildContext context) {
    UserID user = Provider.of<UserID>(context);
    return Scaffold(
      body: Container(
        child: Column(
          children: [

            pageTitle(context, "Assign Recipe", false, true, setState),


            StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            Expanded(
                              child: TextFormField(
                                style: basicBlack,
                                decoration: textInputDecoration.copyWith(hintText: 'Search by name'),
                                validator: (val) {
                                  if(val.isEmpty){
                                    return "description required";
                                  }
                                  else{
                                    return null;
                                  }
                                },
                                onChanged: (val) {
                                  setState(() => query = val);
                                },

                              ),
                            ),
                            IconButton(icon: Icon(Icons.search), onPressed: () async{
                              searchResults = await search(query);
                              setState((){results = true;});
                            }),
                          ]
                        ),
                        results ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: searchResults.length,
                          itemBuilder: (contect, index){
                            return StreamBuilder<Recipe>(
                              stream: DatabaseRecipeService().recipe(searchResults[index]),
                              builder: (context, snapshot) {
                                if(snapshot.hasData){
                                  Recipe recipe = snapshot.data;
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
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children:[
                                            Image.network(recipe.image, width: 50,),
                                            SizedBox(width:3),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(recipe.title, style: basicSmallBlackBold,),
                                                Text("Prep Time: ${recipe.prep}min", style: basicSmallBlack),
                                              ],
                                            ),
                                          ]
                                        ),
                                        IconButton(icon: Icon(Icons.add, size: 40), onPressed: () async {
                                          var recipe = await getRecipe(searchResults[index]);
                                          String recipeTitle = recipe.data()["title"];
                                          uploadMealPlan(ActiveDay.day, user.uid, searchResults[index], recipeTitle);
                                          print("new meal plan");
                                          Navigator.of(context).pop();
                                        },),
                                      ],
                                    )
                                  );
                                }
                              }
                            );
                          }
                        )
                            
                        : 
                        SizedBox(height:1),
                      ],
                    ),
                  )
                );
              }
            ),

            
            
          ]
        )
      )
        
    );
     
        
  }
}
