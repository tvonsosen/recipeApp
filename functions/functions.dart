import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:recipes/models/createRecipeForm.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';

final picker = ImagePicker();
String URL='https://d64516092c87.ngrok.io/findRecipe'; // ! I have to reset this url every 2 hours due to the tunneling tool



Future scanImage(StateSetter setState) async {
  final pickedFile = await picker.getImage(source: ImageSource.gallery);  // ! change to camera for use on real phone
  File fileImage = File(pickedFile.path);
  final bytes=fileImage.readAsBytesSync();
  String img64=base64Encode(bytes);
  final json={
    "image":img64
  };
  final response=await http.post(URL,body:json);

  if(response.statusCode == 200){
    var result=jsonDecode(response.body);

   setState((){
    CreateRecipeForm.title=result['title'];
    result['ingredients'].forEach((obj){
          CreateRecipeForm.ingredients["${CreateRecipeForm.ingredients.length}"] = {
                  "name" : obj['desc'], 
                  "amount" : obj['amount'], 
                  "unit" : obj['measurment'],
      }; 
    });
    CreateRecipeForm.steps=result['instructions'];
    CreateRecipeForm.prepTime=0; // temporary value
    CreateRecipeForm.servings=int.parse(result['servings']);
   });


  }else{
    throw Exception('Failed request');
  }
}

Future saveImage() async{
  final pickedFile = await picker.getImage(source: ImageSource.gallery);
  File fileImage = File(pickedFile.path);
  CreateRecipeForm.recipeImage = fileImage;
}



List getEpochs(int time){
  int todayEarly = (DateTime.parse(formatDate(DateTime.now(), [yyyy, "-", mm, "-", dd]) +  " 00:00:01").millisecondsSinceEpoch.toInt());
  List returnList = [];
  for(int i = 0; i < time; i++){
    returnList.add(todayEarly+(86400000*i));
  }
  print(returnList);
  return returnList;
}
