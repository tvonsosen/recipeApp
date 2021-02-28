import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes/elements/pageTitle.dart';
import 'package:recipes/models/user.dart';

class ViewRecipe extends StatefulWidget {
  @override
  ViewRecipeState createState() => ViewRecipeState();
}

class ViewRecipeState extends State<ViewRecipe> {
  
  var update = true;

  @override
  Widget build(BuildContext context) {
    UserID user= Provider.of<UserID>(context);
    return Scaffold(
      body: Container(
        child: Column(
          children: [

            pageTitle(context, "Recipe", false, true, setState),

            // Image.network()
          ]
        ),
      ),
    );
  }
}