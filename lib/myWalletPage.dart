import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_wallet/homePage.dart';

import 'expensesPage.dart';

class walletPage extends StatefulWidget {

  int current_money;
  int monthly_income;
  int pageIndex;
  int household_expense;
  int clothing_expense;
  int foodandDrink_expense;
  int hobby_expense;

  walletPage({@required this.current_money,@required this.monthly_income,@required this.pageIndex,@required this.household_expense,@required this.clothing_expense,@required this.foodandDrink_expense,@required this.hobby_expense});

  @override
  _walletPageState createState() => _walletPageState(current_money,monthly_income,pageIndex,household_expense,clothing_expense,foodandDrink_expense,hobby_expense);
}

class _walletPageState extends State<walletPage> {

  int current_money;
  int monthly_income;
  int pageIndex;
  int household_expense;
  int clothing_expense;
  int foodandDrink_expense;
  int hobby_expense;

  _walletPageState(this.current_money,this.monthly_income,this.pageIndex,this.household_expense,this.clothing_expense,this.foodandDrink_expense,this.hobby_expense);

  TextEditingController expenseController = TextEditingController();
  int expense_money = 0;
  int selectedItemIndex = -1;
  int page_index = 0;
  Color colorHousehold = Colors.grey;
  Color colorClothing = Colors.grey;
  Color colorFoodDrink = Colors.grey;
  Color colorHobby = Colors.grey;
  String expenseType = "";


  init()
  {
    setState(() {
      page_index = pageIndex;
    });

    if(household_expense == null)
      {
        household_expense = 0;
      }
    if(clothing_expense == null)
      {
        clothing_expense = 0;
      }
    if(foodandDrink_expense == null)
      {
        foodandDrink_expense = 0;
      }
    if(hobby_expense == null)
      {
        hobby_expense = 0;
      }
  }

  onBottomNavigationTap(int index)
  {
    setState(() {
      page_index = index;
    });

    if(index == 0)
    {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MaterialApp(debugShowCheckedModeBanner: false, title: "Home Page", home: homePage(current_money: current_money,monthly_income: monthly_income,pageIndex: page_index,household_expense: household_expense,clothing_expense: clothing_expense,foodandDrink_expense: foodandDrink_expense,hobby_expense: hobby_expense,),)));
    }
    else if(index == 2)
    {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MaterialApp(debugShowCheckedModeBanner: false,title: "Expenses Page", home: expensesPage(monthly_income: monthly_income,money:current_money,pageIndex: page_index,household_expense: household_expense,clothing_expense: clothing_expense,foodandDrink_expense: foodandDrink_expense,hobby_expense: hobby_expense,),)));
    }
  }

  listItemSelect(int index)
  {
    setState(() {
      selectedItemIndex = index;
      if(index == 1)
      {
        expenseType = "household";
        colorHousehold = Colors.green[800];
        colorClothing = Colors.grey;
        colorFoodDrink = Colors.grey;
        colorHobby = Colors.grey;

      }
      else if(index == 2)
      {
        expenseType = "clothing";
        colorClothing = Colors.green[800];
        colorHousehold = Colors.grey;
        colorFoodDrink = Colors.grey;
        colorHobby = Colors.grey;
      }
      else if(index == 3)
      {
        expenseType = "food/drink";
        colorFoodDrink = Colors.green[800];
        colorHousehold = Colors.grey;
        colorHobby = Colors.grey;
        colorClothing = Colors.grey;
      }
      else if(index == 4)
      {
        expenseType = "hobby";
        colorHobby = Colors.green[800];
        colorClothing = Colors.grey;
        colorHousehold = Colors.grey;
        colorFoodDrink = Colors.grey;
      }
    });

  }

  enterExpenses()
  {
    expense_money = int.parse(expenseController.text);

    setState(() {
      if(current_money >= expense_money)
      {
        current_money -= expense_money;
        if(selectedItemIndex == 1)
          {
           expense_money += household_expense;
          }
        if(selectedItemIndex == 2)
          {
            expense_money += clothing_expense;
          }
        if(selectedItemIndex == 3)
          {
            expense_money += foodandDrink_expense;
          }
        if(selectedItemIndex == 4)
          {
            expense_money += hobby_expense;
          }
      }
    });

    Navigator.push(context, MaterialPageRoute(builder: (context) => MaterialApp(debugShowCheckedModeBanner: false,title: "Expenses Page",home: expensesPage(monthly_income: monthly_income,selectedItemIndex: selectedItemIndex,money: current_money, expenseMoney: expense_money,pageIndex: page_index+1,household_expense: household_expense,clothing_expense: clothing_expense,foodandDrink_expense: foodandDrink_expense,hobby_expense: hobby_expense,))));
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white38,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(0),
                child: Container(
                  height: 300,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: Container(
                      height: 120,
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      alignment: Alignment.center,
                      child: Text("Monthly Income: "+monthly_income.toString()+"₺",textAlign: TextAlign.center,style: TextStyle(fontSize: 26,color: Colors.black,fontWeight: FontWeight.w600),),
                      decoration: BoxDecoration(
                        color: Colors.green[500].withOpacity(0.80),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("images/dollarBackground.jpg"),fit: BoxFit.cover),
                    color: Colors.black38,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                ),
              ),
              Container(
                height: 175,
                width: double.infinity,
                alignment: Alignment.topCenter,
                color: Colors.red.withOpacity(0),
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  height: 150,
                  width: 150,
                  alignment: Alignment.center,
                  child: Text(current_money.toString()+"₺",textAlign: TextAlign.center,style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600,color: Colors.black),),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.green[600],
                      boxShadow:
                      [
                        BoxShadow(
                          blurRadius: 7,
                          spreadRadius: 3,
                          color: Colors.grey.withOpacity(0.5),
                        )
                      ]
                  ),
                ),
              ),
              Container(
                height: 30,
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                alignment: Alignment.bottomCenter,
                child: Text("Choose Your Expense Type",textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black),),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                      child: CustomScrollView(
                        scrollDirection: Axis.horizontal,
                        slivers: <Widget>[
                          SliverList(
                              delegate: SliverChildListDelegate(
                                [
                                   Container(
                                     height: 130,
                                     width: 150,
                                     margin: EdgeInsets.fromLTRB(5, 5, 25, 5),
                                     child: FlatButton(
                                       shape: RoundedRectangleBorder(
                                         borderRadius: BorderRadius.circular(25),
                                       ),
                                         onPressed: () => listItemSelect(1),
                                         child: Image(
                                             image: AssetImage("images/household.png")
                                         ),
                                     ),
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(25),
                                         color: colorHousehold,
                                       boxShadow:
                                         [
                                           BoxShadow(
                                             blurRadius: 0.5,
                                             spreadRadius: 2,
                                             color: Colors.green[700].withOpacity(0.5),
                                           ),
                                         ]
                                     ),
                                   ),
                                  Container(
                                    height: 130,
                                    width: 150,
                                    margin: EdgeInsets.fromLTRB(5, 5, 25, 5),
                                    child: FlatButton(
                                      padding: EdgeInsets.all(15),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      onPressed: () => listItemSelect(2),
                                      child: Image(
                                          image: AssetImage("images/clothing.png")
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: colorClothing,
                                        boxShadow:
                                        [
                                          BoxShadow(
                                            blurRadius: 0.5,
                                            spreadRadius: 2,
                                            color: Colors.green[700].withOpacity(0.5),
                                          ),
                                        ]
                                    ),
                                  ),
                                  Container(
                                    height: 130,
                                    width: 150,
                                    margin: EdgeInsets.fromLTRB(5, 5, 25, 5),
                                    child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      onPressed: () => listItemSelect(3),
                                      child: Image(
                                          image: AssetImage("images/foodAndDrink.png")
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: colorFoodDrink,
                                        boxShadow:
                                        [
                                          BoxShadow(
                                            blurRadius: 0.5,
                                            spreadRadius: 2,
                                            color: Colors.green[700].withOpacity(0.5),
                                          ),
                                        ]
                                    ),
                                  ),
                                  Container(
                                    height: 130,
                                    width: 150,
                                    margin: EdgeInsets.fromLTRB(5, 5, 25, 5),
                                    child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      onPressed: () => listItemSelect(4),
                                      child: Image(
                                          image: AssetImage("images/hobbies.png")
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: colorHobby,
                                        boxShadow:
                                        [
                                          BoxShadow(
                                            blurRadius: 0.5,
                                            spreadRadius: 2,
                                            color: Colors.green[700].withOpacity(0.5),
                                          ),
                                        ]
                                    ),
                                  ),
                                ]
                              ),
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.green[600],
                        boxShadow:
                        [
                          BoxShadow(
                            blurRadius: 7,
                            spreadRadius: 3,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ]
                    ),
                  ),
                ),
             Padding(
                  padding: EdgeInsets.fromLTRB(50, 0, 50, 10),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.green[600],
                        boxShadow:
                        [
                          BoxShadow(
                            blurRadius: 7,
                            spreadRadius: 3,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ]
                    ),
                    child: Row(
                      children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  child: TextField(
                                    controller: expenseController,
                                    style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),
                                    textAlign: TextAlign.center,
                                     keyboardType: TextInputType.numberWithOptions(signed: false,decimal: false),
                                  ),
                                ),
                              ),
                            ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(25),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: IconButton(splashColor: Colors.white,iconSize: 35,icon: Icon(Icons.arrow_forward),
                                  onPressed: () => enterExpenses(),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.green[800],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>
        [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.print),
            title: Text("My wallet"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            title: Text("Expenses"),
          ),
        ],
        currentIndex: page_index,
        selectedItemColor: Colors.green[600],
        onTap: onBottomNavigationTap,
      ),
    );
  }
}
