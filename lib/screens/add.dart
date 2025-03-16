import 'package:flutter/material.dart';
import 'package:khoder/components/myappbar.dart';
import 'package:khoder/components/mylisttile.dart';
import 'package:khoder/screens/addproblem.dart';
import 'package:khoder/screens/addsuggestion.dart';

class Add extends StatelessWidget {
  const Add({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Add"),
      body: Column(
        children: [
          MyListTile(title: "Add Suggestions", leading: Icon(Icons.lightbulb , color: Color(0xFFFF6B00),), subtitle: "Ask for Suggestions or a Question to enhance your knowledge", onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddSuggestion()));
          }),
          MyListTile(title: "Add Problem", leading: Icon(Icons.question_answer , color: Color(0xFFFF6B00),), subtitle: "Upload your Problems to the feed with your code", onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> AddProblem()));
          }),

        ],
      ),
    );
  }
}
