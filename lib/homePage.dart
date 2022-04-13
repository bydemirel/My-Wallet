import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_wallet/expensesPage.dart';
import 'myWalletPage.dart';
import 'package:fl_chart/fl_chart.dart';

class homePage extends StatefulWidget {
  int monthly_income;
  int current_money;
  int pageIndex;
  int household_expense;
  int clothing_expense;
  int foodandDrink_expense;
  int hobby_expense;
  homePage({@required this.monthly_income,@required this.current_money,@required this.pageIndex,@required this.household_expense,@required this.clothing_expense,@required this.foodandDrink_expense,@required this.hobby_expense});

  @override
  _homePageState createState() => _homePageState(monthly_income,current_money,pageIndex,household_expense,clothing_expense,foodandDrink_expense,hobby_expense);
}

class _homePageState extends State<homePage> {

  int monthly_income;
  int current_money;
  int pageIndex;
  int household_expense;
  int clothing_expense;
  int foodandDrink_expense;
  int hobby_expense;

  _homePageState(this.monthly_income,this.current_money,this.pageIndex,this.household_expense,this.clothing_expense,this.foodandDrink_expense,this.hobby_expense);

  TextEditingController changeMonthlyIncomeController = TextEditingController();
  bool isVisibleForChangeMonthlyIncome = false;
  bool isVisibleForPieChart = false;
  int page_index = 0;
  List<PieChartSectionData> _sections = List<PieChartSectionData>();
  double spentMoneyRatio;
  double availableMoneyRatio;
  String advise_sentence ="";


   changeButton()
  {
    if(isVisibleForChangeMonthlyIncome)
      {
        monthly_income = int.parse(changeMonthlyIncomeController.text);
        current_money = int.parse(changeMonthlyIncomeController.text);

        household_expense = 0;
        clothing_expense = 0;
        foodandDrink_expense = 0;
        hobby_expense = 0;

        init();
        isVisibleForChangeMonthlyIncome = false;
      }
    else
      {
        isVisibleForChangeMonthlyIncome = true;
      }
    setState(() {

    });
  }
  changeAdviseSentence()
  {
    setState(() {
      if(availableMoneyRatio > 75 && availableMoneyRatio <= 100)
      {
        advise_sentence = "You have a lot of money. You can buy what do you want!";
      }
      else if(availableMoneyRatio > 50 && availableMoneyRatio <= 75)
      {
        advise_sentence = "You still have money. You can buy something for your hobby but try not to buy too expensive stuff!";
      }
      else if(availableMoneyRatio > 25 && availableMoneyRatio <= 50)
      {
        advise_sentence = "Your money is low, be careful not to spend too much money other than basic needs. You still have the opportunity to save!";
      }
      else if(availableMoneyRatio >=0 && availableMoneyRatio<=25)
      {
        advise_sentence = "Your money is getting too long now, so be careful to spend money. Don't take anything for your hobbies. Spend your remaining money only for essential needs!";
      }
    });
  }
  onBottomNavigationTap(int index)
  {
    setState(() {
      page_index = index;
    });
    if(index == 1)
    {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MaterialApp(debugShowCheckedModeBanner: false, title: "My Wallet Page", home: walletPage(current_money: current_money, monthly_income: monthly_income,pageIndex: page_index,household_expense: household_expense,clothing_expense: clothing_expense,foodandDrink_expense: foodandDrink_expense,hobby_expense: hobby_expense,),)));
    }
    else if(index == 2)
      {
        Navigator.push(context, MaterialPageRoute(builder: (context) => MaterialApp(debugShowCheckedModeBanner: false,title: "Expenses Page", home: expensesPage(money: current_money,monthly_income: monthly_income,pageIndex: page_index,household_expense: household_expense,clothing_expense: clothing_expense,foodandDrink_expense: foodandDrink_expense,hobby_expense: hobby_expense,),)));
      }
  }

  init()
  {

    spentMoneyRatio = (((household_expense+clothing_expense+foodandDrink_expense+hobby_expense)*100)/monthly_income);
    availableMoneyRatio = ((current_money*100)/monthly_income);

    changeAdviseSentence();

    PieChartSectionData _item1 = PieChartSectionData(
      color: Colors.green[600],
      value: availableMoneyRatio,
      title: "%"+availableMoneyRatio.round().toString(),
      titleStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),
      radius: 75,
    );

    PieChartSectionData _item2 = PieChartSectionData(
      color: Colors.black26,
      value: spentMoneyRatio,
      title: "%"+spentMoneyRatio.round().toString(),
      titleStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),
      radius: 75,
    );

    setState(() {
      page_index = pageIndex;
    });
    _sections = [_item1,_item2];
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
                child: Text("Monthly Income: "+monthly_income.toString()+"₺",style: TextStyle(fontSize: 26,color: Colors.black,fontWeight: FontWeight.w600),),
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
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                          child: Container(
                            height: 120,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              onPressed: () => changeButton(),
                                child: Text("Change Your Monthly Income",textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.w600),)
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
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
                      ),
                      Visibility(
                        visible: isVisibleForChangeMonthlyIncome,
                        child: Expanded(
                          flex: 2,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                              child: Container(
                                height: 120,
                                child: Padding(
                                  padding: EdgeInsets.all(25),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 49,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          child: TextField(
                                            controller: changeMonthlyIncomeController,
                                            keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
                                            style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
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
                        ),
                      ),
                    ],
                ),
                 Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                            child: Row(
                             children: <Widget>[
                               Container(
                                 height: 25,
                                 width: 25,
                                 color: Colors.green[600],
                                 margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                               ),
                               Container(
                                 height: 50,
                                 width: 160,
                                 alignment: Alignment.centerLeft,
                                 child: Text(" : The Money Available",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),),
                               ),
                               Container(
                                 height: 25,
                                 width: 25,
                                 color: Colors.black26,
                                 margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                               ),
                               Container(
                                 height: 50,
                                 width: 150,
                                 alignment: Alignment.centerLeft,
                                 child: Text(" : The Money Spent",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),),
                               ),
                             ],
                            ),
                          ),
                        ),
                          AspectRatio(
                            aspectRatio: 2.5,
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
                      Container(
                        height: 60,
                        width: 180,
                        alignment: Alignment.center,
                        child: Text("Current Money: "+current_money.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black),textAlign: TextAlign.center,),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                              height: 100,
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Text(advise_sentence,style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
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
                    ],
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
