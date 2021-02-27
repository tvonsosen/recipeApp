import 'package:recipes/models/user.dart';
import 'package:recipes/screens/authenticate.dart';
import 'package:recipes/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes/screens/mealPlan.dart';
import 'package:recipes/screens/shoppingList.dart';
import 'package:recipes/style/style.dart';
// import 'package:firebase_core/firebase_core.dart';

class Wrapper extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserID>(context);
    // print("user");
    // print(user.uid);
    
    // return either the Home or Authenticate widget
    if (user == null){
      return Authenticate();
    } else {
      return new DefaultTabController(
        child:Scaffold(
          body: TabBarView(
            children: [
              HomePage(),
              MealPlan(),
              ShoppingList(),
            ],
          ),
          bottomNavigationBar: Container(
            // margin: CurrentDevice.hasNotch ? EdgeInsets.only(bottom:20) : null,
            child: new TabBar(
              tabs: [
                Tab(
                  icon: new Icon(Icons.fastfood),
                ),
                Tab(
                  icon: new Icon(Icons.list),
                ),
                Tab(
                  icon: new Icon(Icons.shopping_bag),
                ),
              ],
              labelColor: redTheme,
              unselectedLabelColor: redTheme,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.all(5.0),
              indicatorColor: redTheme,
            )
            
          ),
        ),
        length: 3,
      );
    }
    
  }
}