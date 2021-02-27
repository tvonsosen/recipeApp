import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:recipes/models/createRecipeForm.dart';

final picker = ImagePicker();
String URL='https://5adfc1b462c1.ngrok.io/findRecipe'; // ! I have to reset this url every 2 hours due to the tunneling tool

Future scanImage() async {
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
    CreateRecipeForm.title=result['title'];
    CreateRecipeForm.ingredients=result['ingredients'];
    CreateRecipeForm.steps=[result['instructions']];
    CreateRecipeForm.prepTime=0; // temporary value

  }else{
    throw Exception('Failed request');
  }
  //Image image = Image.file(fileImage);
  

}