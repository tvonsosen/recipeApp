import "dart:io";
import 'package:firebase_storage/firebase_storage.dart';
import 'package:recipes/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as Path;  



class DatabaseUserService {



  final String uid;
  DatabaseUserService({ this.uid });  



  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference recipesCollection = FirebaseFirestore.instance.collection('recipes');





  Future<void> updateUserData(String firstName, String lastName, String email) async {
    return await userCollection.doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    });
  }


  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      firstName: snapshot.data()['firstName'],
      lastName: snapshot.data()['lastName'],
      email: snapshot.data()['email'],
    );
  }



  // get user doc stream
  Stream<UserData> get userData {
    // print(uid);
    return userCollection.doc(uid).snapshots()
      .map(_userDataFromSnapshot);
  }






  // // user data from snapshots
  // UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
  //   return UserData(
  //     uid: uid,
  //     firstName: snapshot.data()['firstName'],
  //     lastName: snapshot.data()['lastName'],
  //     email: snapshot.data()['email'],
  //   );
  // }



  // // get user doc stream
  // Stream<UserData> get userData {
  //   // print(uid);
  //   return userCollection.doc(uid).snapshots()
  //     .map(_userDataFromSnapshot);
  // }




}






Future<String> uploadFile(File _image) async {
  StorageReference storageReference = FirebaseStorage.instance
      .ref()
      .child('recipes/${Path.basename(_image.path)}');
  StorageUploadTask uploadTask = storageReference.putFile(_image);
  await uploadTask.onComplete;
  print('File Uploaded');
  String returnURL;
  await storageReference.getDownloadURL().then((fileURL) {
    returnURL =  fileURL;
  });
  return returnURL;
}


void createRecipe(String userId, String title, int prep, int servings, Map ingredients, List steps, File recipeImage) async{
  
  DocumentReference ref = await FirebaseFirestore.instance.collection('recipes').add({
    'createdBy': userId,
    'title': title,
    'prep': prep,
    'servings': servings,
    'ingredients': ingredients,
    'steps': steps,
    "votes": 1,
    "image": await uploadFile(recipeImage)
  }).catchError((error) => print("Failed to add recipes: $error"));

  // ! add to firestore
}










