import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:recipes/elements/pageTitle.dart';
import 'package:recipes/models/shoppingList.dart';
import 'package:recipes/models/user.dart';
import 'package:recipes/services/database.dart';
import 'package:recipes/shared/loading.dart';
import 'package:recipes/style/style.dart';
import 'package:flutter/material.dart';



shoppingListWidget(BuildContext context, String ingredient, bool shoppingCart, var user, StateSetter setState) {
  return Container(
    padding: EdgeInsets.all(10),
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
    child: Row(

      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:[
        
        Flexible(child: Text(ingredient, style: basicMediumBlack, overflow: TextOverflow.ellipsis,)),
        !shoppingCart ? IconButton(icon: Icon(Icons.add, color: darkFontColor,), iconSize: 40, onPressed: (){ 
          addToShoppingCart(ingredient, user.uid);
        },)
        :
        Icon(Icons.close, color: darkFontColor, size: 40,),

        
      ]
    )
  );
}


getIngredients(var snapshot) async {
  List recipesPlanned = [];
  print("recipe planned: " + recipesPlanned.toString());
  ShoppingItemList.shoppingList = [];
  for(var item in snapshot.data.docs){
    // recipesPlanned = [];
    recipesPlanned.add(item["recipeId"]);
  }
  print("recipe planned: " + recipesPlanned.toString());
  for(var item in recipesPlanned){
    var mealPlan = await getRecipe(item);
    // print(mealPlan.data());
    for(var ingredient = 0; ingredient < mealPlan.data()["ingredients"].length; ingredient++){
      if(ShoppingItemList.shoppingList.contains(mealPlan.data()["ingredients"][ingredient.toString()]["name"]) != true){
        ShoppingItemList.shoppingList.add(mealPlan.data()["ingredients"][ingredient.toString()]["name"]);
      }
    }
  }
}


class ShoppingList extends StatefulWidget {
  @override
  ShoppingListState createState() => ShoppingListState();
}

class ShoppingListState extends State<ShoppingList> {
  
  var update = true;

  @override
  Widget build(BuildContext context) {
    UserID user = Provider.of<UserID>(context);

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('mealPlan').where("userId", isEqualTo: UserData().uid).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        return FutureBuilder(
          future: getIngredients(snapshot),
          builder: (_, snapshot) {
            return StreamBuilder(
              stream: FirebaseFirestore.instance.collection('shoppingCart').where("userId", isEqualTo: UserData().uid).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            
                if(ShoppingItemList.shoppingList.toString() != "[]"){
                  return Scaffold(
                    body: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top:20, bottom: 10),
                          child: pageTitle(context, "Shopping List", false, false, setState),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [

                                // List view for shopping list ingredients
                                SizedBox(height:30),
                                Text("Current Shopping Cart: ", style: basicBlackBold,),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index){
                                    return shoppingListWidget(context, snapshot.data.docs[index]["name"], true, user, setState);
                                  }
                                ),


                                SizedBox(height:30),
                                Text("All Items: ", style: basicBlackBold,),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: ShoppingItemList.shoppingList.length,
                                  itemBuilder: (context, index){
                                    return shoppingListWidget(context, ShoppingItemList.shoppingList[index], false, user, setState);
                                  }
                                ),
                                    
                              ]
                            )
                          )
                        )
                      ] 
                    )
                  );
                }
                return Loading();
              }
            );
          }
        );
      }
    );
  }
}
