import 'package:flutter/material.dart';
import 'package:recipes/style/style.dart';



pageTitle(BuildContext context, String pageHeaderTitle, bool homePage, bool back, StateSetter setState,){
  if(back == true){
    return Column(
      children:[
        SizedBox(height: 37),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
            Container(
              width:50,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: darkFontColor,),
                iconSize: 36,
                onPressed: (){
                  Navigator.pop(context,);
                },
              ),
            ),
            SizedBox(width: 10,),
            Container(
              child: Text(pageHeaderTitle, style: pageTitleStyle),
            ),
            SizedBox(width: 10,),
            SizedBox(width:50)
            // IconButton(
            //   icon: Icon(Icons.settings, color: darkFontColor,),
            //   iconSize: 36,

            // ),
          ]
        )
      ]
    );
  }
  if(homePage == true){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          SizedBox(height: 37),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(child: Text(pageHeaderTitle, style: pageTitleStyle),),
              Icon(Icons.person, size: 40,)
            ],
          )
          
        ]
      )
    );
  }
  else{
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children:[
        SizedBox(height: 37),
        Container(child: Text(pageHeaderTitle, style: pageTitleStyle),),
      ]
    );
  }

  

}