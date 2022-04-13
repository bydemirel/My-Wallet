import 'package:flutter/material.dart';
import 'package:my_wallet/homePage.dart';
import 'myWalletPage.dart';
import 'package:fl_chart/fl_chart.dart';

class expensesPage extends StatefulWidget {

  int monthly_income;
  int money; //Current Money
  int expenseMoney;
  int pageIndex;
  int selectedItemIndex;
  int household_expense;
  int clothing_expense;
  int foodandDrink_expense;
  int hobby_expense;


  expensesPage({@required this.money,@required this.expenseMoney,@required this.pageIndex,@required this.selectedItemIndex,@required this.monthly_income,@required this.household_expense,@required this.clothing_expense,@required this.foodandDrink_expense,@required this.hobby_expense});
  @override
  _expensesPageState createState() => _expensesPageState(money,expenseMoney,pageIndex,selectedItemIndex,monthly_income,household_expense,clothing_expense,foodandDrink_expense,hobby_expense);
}

class _expensesPageState extends State<expensesPage> {

  int monthly_income;
  int money;
  int expenseMoney;
  int pageIndex;
  int selectedItemIndex;
  int household_expense;
  int clothing_expense;
  int foodandDrink_expense;
  int hobby_expense;

  _expensesPageState(this.money,this.expenseMoney,this.pageIndex,this.selectedItemIndex,this.monthly_income,this.household_expense,this.clothing_expense,this.foodandDrink_expense,this.hobby_expense);

  int page_index = 0;
  List<PieChartSectionData> _sections = List<PieChartSectionData>();
  double householdExpensesRatio;
  double clothingExpensesRatio;
  double foodAndDrinkExpensesRatio;
  double hobbyExpensesRatio;

  onBottomNavigationTap(int index)
  {
    setState(() {
      page_index = index;
    });

    if(index == 0)
    {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MaterialApp(debugShowCheckedModeBanner: false, title: "Home Page", home: homePage(current_money: money ,monthly_income: monthly_income,pageIndex: page_index,household_expense: household_expense,clothing_expense: clothing_expense,foodandDrink_expense: foodandDrink_expense,hobby_expense: hobby_expense,),)));
    }
    else if(index == 1)
    {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MaterialApp(debugShowCheckedModeBanner: false,title: "Wallet Page", home: walletPage(monthly_income: monthly_income,current_money: money,pageIndex: page_index,household_expense: household_expense,clothing_expense: clothing_expense,foodandDrink_expense: foodandDrink_expense,hobby_expense: hobby_expense,))));
    }
  }

  init()
  {
    householdExpensesRatio = (household_expense*100)/monthly_income;
    clothingExpensesRatio = (clothing_expense*100)/monthly_income;
    foodAndDrinkExpensesRatio = (foodandDrink_expense*100)/monthly_income;
    hobbyExpensesRatio = (hobby_expense*100)/monthly_income;

    PieChartSectionData _householdExpenses = PieChartSectionData(
      color: Colors.green[200],
      value: householdExpensesRatio,
      title: "%"+householdExpensesRatio.round().toString(),
      titleStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),
      radius: 100,
    );

    PieChartSectionData _clothingExpenses = PieChartSectionData(
      color: Colors.green[800],
      value: clothingExpensesRatio,
      title: "%"+clothingExpensesRatio.round().toString(),
      titleStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),
      radius: 100,
    );
    PieChartSectionData _foodAndDrinkExpenses = PieChartSectionData(
      color: Colors.green[400],
      value: foodAndDrinkExpensesRatio,
      title: "%"+foodAndDrinkExpensesRatio.round().toString(),
      titleStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),
      radius: 100,
    );

    PieChartSectionData _hobbyExpenses = PieChartSectionData(
      color: Colors.green[600],
      value: hobbyExpensesRatio,
      title: "%"+hobbyExpensesRatio.round().toString(),
      titleStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),
      radius: 100,
    );

    setState(() {
      page_index = pageIndex;
    });

    if(selectedItemIndex == 1)
    {
      household_expense = expenseMoney;
    }
    else if(selectedItemIndex == 2)
    {
      clothing_expense = expenseMoney;
    }
    else if(selectedItemIndex == 3)
    {
      foodandDrink_expense = expenseMoney;
    }
    else if(selectedItemIndex == 4)
    {
      hobby_expense = expenseMoney;
    }

    _sections = [_householdExpenses,_clothingExpenses,_foodAndDrinkExpenses,_hobbyExpenses];
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
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            alignment: Alignment.center,
                            child: Text("Your Total Money: "+money.toString()+"₺",textAlign: TextAlign.center,style: TextStyle(fontSize: 26,color: Colors.black,fontWeight: FontWeight.w600),),
                            decoration: BoxDecoration(
                              color: Colors.green[600].withOpacity(0.80),
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
                   Padding(
                        padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                          child: Text("Household Expenses: "+household_expense.toString()+"₺",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                          decoration: BoxDecoration(
                              color: Colors.green[200],
                            borderRadius: BorderRadius.circular(15),
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
                        padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                          child: Text("Clothing: "+clothing_expense.toString()+"₺",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                          decoration: BoxDecoration(
                              color: Colors.green[400],
                              borderRadius: BorderRadius.circular(15),
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
                        padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                          child: Text("Food/Drink: "+foodandDrink_expense.toString()+"₺",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                          decoration: BoxDecoration(
                              color: Colors.green[600],
                              borderRadius: BorderRadius.circular(15),
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
                        padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                          child: Text("Hobbies: "+hobby_expense.toString()+"₺",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                          decoration: BoxDecoration(
                              color: Colors.green[800],
                              borderRadius: BorderRadius.circular(15),
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
                    AspectRatio(
                      aspectRatio: 1.5,
                      child: Container(
                        child: FlChart(
                          chart: PieChart(
                            PieChartData(
                              borderData: FlBorderData(show: false),
                              centerSpaceRadius: 0,
                              sectionsSpace: 0,
                              sections: _sections,
                            ),
                          ),
                        ),
                      ),
                    ),

                  ]
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

