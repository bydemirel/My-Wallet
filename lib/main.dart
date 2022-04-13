import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'homePage.dart';


void main() {
  runApp(MyWallet());
}

class MyWallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My App",
      home: homePage(current_money: 2324,monthly_income: 2324,pageIndex: 0,household_expense: 0,clothing_expense: 0,foodandDrink_expense: 0,hobby_expense: 0,),
    );
  }
}




