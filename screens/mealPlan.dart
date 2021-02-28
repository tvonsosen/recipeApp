import 'package:intl/intl.dart';
import 'package:recipes/elements/pageTitle.dart';
import 'package:recipes/functions/functions.dart';
import 'package:recipes/models/recipe.dart';
import 'package:recipes/services/auth.dart';
import 'package:recipes/services/database.dart';
import 'package:recipes/shared/loading.dart';
import 'package:recipes/style/inputDecoration.dart';
import 'package:recipes/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipes/elements/recipeWidget.dart';
import 'package:recipes/screens/home.dart';
import 'package:recipes/screens/shoppingList.dart';

// Each day meal plan boxes class

searchResultsBuilder(List<String> searchResults){
  return Expanded(
    child: ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (contect, index){
        return StreamBuilder<Recipe>(
          stream: DatabaseRecipeService().recipe(searchResults[index]),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              Recipe recipe = snapshot.data;
              ListTile(
                leading: Image.network(recipe.image),
              );
            }
          }
        );
      }
    ),
  );
}

addMealPopUp(BuildContext context){
  bool results = false; 
  List<String> searchResults;
  String query = "";
  return showDialog(
    context: context,
    barrierDismissible: false, 
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Add Step'),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
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
                  results ? searchResultsBuilder(searchResults) : SizedBox(height:1),
                ],
              ),
            );
          }
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () async {

              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text('Add'),
            onPressed: () async {
              // CreateRecipeForm.steps.add(step);
              Navigator.pop(context);
            },
          ),
          
        ],
      );
    },
  );
}


MealPlanWidget(BuildContext context, String day, StateSetter setState){
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
            Text(day, style: mealPlanTitle),
            IconButton(icon: Icon(Icons.add_box, color: Colors.white), onPressed: (){
              addMealPopUp(context);
            })
          ]
        )
      ]
    )
  );
    
  

}
class MealPlan extends StatefulWidget {
  @override
  MealPlanState createState() => MealPlanState();
}

class MealPlanState extends State<MealPlan> {
  String dropdownValue = '5';
  @override
  Widget build(BuildContext context) {
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
                  return MealPlanWidget(context, DateFormat("EEEE").format(DateTime.fromMillisecondsSinceEpoch(getEpochs(int.parse(dropdownValue))[index])).toString(), setState);
                },
              )
            )
            
          ]
        )
      )
        
    );
     
        
  }
}
