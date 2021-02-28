import 'package:provider/provider.dart';
import 'package:recipes/elements/pageTitle.dart';
import 'package:recipes/functions/functions.dart';
import 'package:recipes/models/createRecipeForm.dart';
import 'package:recipes/models/newIngredient.dart';
import 'package:recipes/models/user.dart';
import 'package:recipes/style/inputDecoration.dart';
import 'package:recipes/style/style.dart';
import 'package:flutter/material.dart';
import 'package:recipes/services/database.dart';


class CreateRecipe extends StatefulWidget {
  @override
  CreateRecipeState createState() => CreateRecipeState();
}

class CreateRecipeState extends State<CreateRecipe> {

  ingredientPopUp(){
    return showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Ingredient'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: TextFormField(
                        style: basicBlack,
                        decoration: textInputDecoration.copyWith(hintText: 'Ingredient Title'),
                        validator: (val) {
                          if(val.isEmpty){
                            return "ingredient required";
                          }
                          else{
                            return null;
                          }
                        },
                        onChanged: (val) {
                          setState(() => NewIngredient.name = val);
                        },

                      ),
                    ),
                    SizedBox(height:20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                        Container(
                          width: MediaQuery.of(context).size.width*.25,
                          child: TextFormField(
                            style: basicBlack,
                            decoration: textInputDecoration.copyWith(hintText: 'amount'),
                            validator: (val) {
                              if(val.isEmpty){
                                return "amount required";
                              }
                              else{
                                return null;
                              }
                            },
                            onChanged: (val) {
                              setState(() => NewIngredient.amount = int.parse(val));
                            },

                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width*.25,
                          child:DropdownButtonFormField<String>(
                            iconEnabledColor: Colors.black,
                            dropdownColor: lightGrey,
                            validator: (value) => value == null ? 'Language Required' : null,
                            value: NewIngredient.unit,
                            hint: Text(
                              'Unit',
                              style: basicSmallBlack,
                            ),
                            items: ["Cups", "Tbsps", "OZs", "Tsp", "g", "packs"].map((String value) {
                              return new DropdownMenuItem<String>(
                                
                                value: value,
                                child: new Text(value, style: basicBlack),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState((){
                                NewIngredient.unit = value;
                              });
                            },
                          ),
                        ),
                      ]
                    ),
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
                CreateRecipeForm.ingredients["${CreateRecipeForm.ingredients.length}"] = {
                  "name" : NewIngredient.name, 
                  "amount" : NewIngredient.amount, 
                  "unit" : NewIngredient.unit,
                };
                Navigator.pop(context);
              },
            ),
            
          ],
        );
      },
    );
  }

  stepPopUp(){
    String step = "";
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
                        decoration: textInputDecoration.copyWith(hintText: 'Step Description'),
                        validator: (val) {
                          if(val.isEmpty){
                            return "description required";
                          }
                          else{
                            return null;
                          }
                        },
                        onChanged: (val) {
                          setState(() => step = val);
                        },

                      ),
                    ),
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
                CreateRecipeForm.steps.add(step);
                Navigator.pop(context);
              },
            ),
            
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    UserID user = Provider.of<UserID>(context);

    // text controllers
    var titleControl = TextEditingController();
    var prepControl = TextEditingController();
    var servingsControl = TextEditingController();
    return Scaffold(
      body: Container(
        child: Column(
          children: [
                
            pageTitle(context, "Create Recipe", false, true, setState),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      SizedBox(height:50),
                      InkWell(
                        child: Container(
                          width: 170,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: redTheme,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:[
                              Icon(Icons.camera_alt, color: whiteFontColor,),
                              Text("Scan Recipe", style: basicWhite,),
                            ]
                          )
                        ),
                        onTap: () async{
                          await scanImage(setState);
                          servingsControl.text = CreateRecipeForm.servings.toString();
                          prepControl.text = CreateRecipeForm.prepTime.toString();
                          titleControl.text = CreateRecipeForm.title;
                        },
                      ),
                      SizedBox(height:50),
                      InkWell(
                        child: Container(
                          width: 220,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: redTheme,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:[
                              Icon(Icons.camera_alt, color: whiteFontColor,),
                              Text("Photo of recipe", style: basicWhite,),
                            ]
                          )
                        ),
                        onTap: (){
                          //  !
                          saveImage(); 
                        },
                      ),
                      SizedBox(height: 10,),
                      Container(
                        child: TextFormField(
                          controller: titleControl,
                          style: basicBlack,
                          decoration: textInputDecoration.copyWith(hintText: 'Recipe Title'),
                          validator: (val) {
                            if(val.isEmpty){
                                  return "title required";
                                }
                                else{
                                  return null;
                                }
                          },
                          onChanged: (val) {
                            setState(() => CreateRecipeForm.title = val);
                          },

                        ),
                      ),
                      SizedBox(height:30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width*.4,
                            child: TextFormField(
                              controller: prepControl,
                              style: basicBlack,
                              decoration: textInputDecoration.copyWith(hintText: 'Prep Min'),
                              validator: (val) {
                                if(val.isEmpty){
                                  return "prep time required";
                                }
                                else if(int.parse(val) == null || int.parse(val) == 0){
                                  return "please input number";
                                }
                                else if(int.parse(val) > 360){
                                  return "too long(less than 6 hrs)";
                                }
                                else{
                                  return null;
                                }
                              },
                              onChanged: (val) {
                                setState(() => CreateRecipeForm.prepTime = int.parse(val));
                              },

                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*.4,
                            child: TextFormField(
                              controller: servingsControl,
                              style: basicBlack,
                              decoration: textInputDecoration.copyWith(hintText: 'Servings'),
                              validator: (val) {
                                if(val.isEmpty){
                                  return "servings required";
                                }
                                else{
                                  return null;
                                }
                              },
                              onChanged: (val) {
                                setState(() => CreateRecipeForm.servings = int.parse(val));
                              },

                            ),
                          ),
                        ],
                      ),
                      ConstrainedBox(
                        constraints: new BoxConstraints(
                          minHeight: 10,
                          maxHeight: 270,
                          // maxWidth: 30.0,
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: CreateRecipeForm.ingredients.length,
                          itemBuilder: (context, index){
                            return Container(
                              margin: EdgeInsets.only(bottom: 12),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(CreateRecipeForm.ingredients[index.toString()]["amount"].toString() + " " + CreateRecipeForm.ingredients[index.toString()]["unit"].toString() + " " + CreateRecipeForm.ingredients[index.toString()]["name"].toString(), style: basicBlackBold,),
                                  IconButton(icon: Icon(Icons.close), onPressed: null)
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      InkWell(
                        child: Container(
                          width: 190,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: redTheme,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:[
                              Icon(Icons.add, color: whiteFontColor,),
                              Text("Add Ingredient", style: basicWhite,),
                            ]
                          )
                        ),
                        onTap: (){
                          ingredientPopUp();
                        },
                      ),
                      ConstrainedBox(
                        constraints: new BoxConstraints(
                          minHeight: 10,
                          maxHeight: 270,
                          // maxWidth: 30.0,
                        ),
                        child:ListView.builder(
                          shrinkWrap: true,
                          itemCount: CreateRecipeForm.steps.length,
                          itemBuilder: (context, index){
                            return Container(
                              margin: EdgeInsets.only(bottom: 12),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Step ${index+1}", style: basicBlackBold,),
                                      Text(CreateRecipeForm.steps[index])
                                    ],
                                  ),
                                  IconButton(icon: Icon(Icons.close), onPressed: null)
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      InkWell(
                        child: Container(
                          width: 190,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: redTheme,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:[
                              Icon(Icons.add, color: whiteFontColor,),
                              Text("Add Step", style: basicWhite,),
                            ]
                          )
                        ),
                        onTap: (){
                          stepPopUp();
                        },
                      ),
                      
                            
                      SizedBox(height:50),
                      InkWell(
                        child: Container(
                          width: 220,
                          padding: EdgeInsets.all(21),
                          decoration: BoxDecoration(
                            color: redTheme,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:[
                              Icon(Icons.fastfood_rounded, color: whiteFontColor,),
                              Text("Publish Recipe", style: basicWhite,),
                            ]
                          )
                        ),
                        onTap: () async{
                          print(CreateRecipeForm.title);
                          print(CreateRecipeForm.prepTime);
                          print(CreateRecipeForm.servings);
                          print(CreateRecipeForm.ingredients);
                          print(CreateRecipeForm.steps);
                          createRecipe(user.uid, CreateRecipeForm.title, CreateRecipeForm.prepTime, CreateRecipeForm.servings,CreateRecipeForm.ingredients, CreateRecipeForm.steps,CreateRecipeForm.recipeImage);
                        },
                      ),
                      SizedBox(height: 10)
                    ],
                  )
                ),
              )
            ),
          ]
        )
      )
        
    );
     
        
  }
}
