import 'package:flutter/material.dart';
import 'CircleProgress.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:sliding_up_panel/sliding_up_panel.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    // When navigating to the "/" route, build the FirstScreen widget.
    '/': (context) => LoadScreen(),
    // When navigating to the "second" route, build the SecondScreen widget.
    '/home': (context) => Homepage(),
    // When navigating to the "second" route, build the SecondScreen widget.
    '/CardsPage': (context) => CardsPage(),
  },
));

class LoadScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<LoadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
        Container(
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.teal,
                  Colors.teal[200],],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                stops: [0.0,1.0],
                tileMode: TileMode.clamp
            )
        ),
          child: Stack(
            children:[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(40))
                  ),
                  margin: EdgeInsets.all(5.0),
                ),
//              Container(
//                margin: EdgeInsets.fromLTRB(250, 810, 0, 0),
//                child: OutlineButton.icon(
//                  onPressed: (){},
//                  label: Text('Start', style: TextStyle(
//                    color: Colors.white,
//                    fontSize: 20,
//                    letterSpacing: 3,
//                  ),),
//                  icon: Icon(Icons.navigate_next, color: Colors.white,),
//                  borderSide: BorderSide(
//                    color: Color(0xFF00FF5B),
//                  ),
//                  highlightedBorderColor: Color(0xFF00FF5B),
//                  highlightColor: Color(0xFF00FF5B),
//
//                ),
//              )
              Container(
                margin: EdgeInsets.fromLTRB(200, 810, 0, 0),
//                margin: EdgeInsets.fromLTRB(0, 300, 200, 0),

                child: Stack(
                  children: [
                    Positioned(
                      right:-25,
                      child: Container(
                        width: 190.0,
                        height: 190.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                            color: Colors.teal[200],
                        ),
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 20, 110),
                          child: FlatButton.icon(
                            icon: Icon(
                              Icons.navigate_next
                            ),
                            label: Text('Start', style: TextStyle(
                              color: Colors.white
                            ),) ,
                            onPressed: (){
                              Navigator.pushReplacementNamed(context, '/home');
                            },
                      ),
                        ),
                    ),
                    )
                  ],
                      ),
                    )
                  ],
                ),
              )
          ]
          ),
    );
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState.withSampleData();
}

class _HomepageState extends State<Homepage> with SingleTickerProviderStateMixin {


  final List<charts.Series> seriesList;
  final bool animate;

  _HomepageState(this.seriesList, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory _HomepageState.withSampleData() {
    return new _HomepageState(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  AnimationController _progressController;
  Animation<double> animation;

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    _progressController = AnimationController(duration: Duration(milliseconds: 2000),vsync: this);
    animation = Tween<double>(begin: 0, end: 80).animate(_progressController)..addListener(() {
      setState(() {

      });
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios, color: Colors.teal[200],
          ),
          onPressed: () {
          },
        ),
        actions: [IconButton(
          icon: Icon(Icons.menu, color: Colors.teal[200],),
          onPressed: (){},
        )
        ],
      ),
      body: Stack(
        children:[
          Container(
          margin: EdgeInsets.fromLTRB(140, 130, 0, 0),
          child: Text(
            'Total Balance', style: TextStyle(
              color: Colors.white, fontSize: 20
          ),
          ),
        ),
      Container(
        margin: EdgeInsets.fromLTRB(155, 162, 0, 0),
        child: Text(
          '\$ 13,250', style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold,
        ),
        ),
      ),
          Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.teal
        )
      ),
      margin: EdgeInsets.fromLTRB(100, 230, 100, 0),
      padding: EdgeInsets.all(9),
      child: DefaultTabController(
        length: 2,
        child: TabBar(
          unselectedLabelColor: Colors.grey[500],
          labelColor: Colors.teal,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Colors.teal,
        tabs: [
          Text(
            'Income'
          ),
          Text(
            'Expenses'
          )
        ],
        ),
      ),
    ),
          Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.fromLTRB(45, 300, 45, 0),
      padding: EdgeInsets.all(6),
      child: DefaultTabController(
        length: 4,
        child: TabBar(
          unselectedLabelColor: Colors.grey[500],
          labelColor: Colors.teal,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Colors.teal,
        tabs: [
          Text(
            'Day'
          ),
          Text(
            'Week'
          ),
          Text(
            'Month'
          ),
          Text(
            'Year'
          )
        ],
        ),
      ),
    ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 400, 0, 300),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child:  new charts.TimeSeriesChart(
                    seriesList,
                    animate: animate,

                    // Optionally pass in a [DateTimeFactory] used by the chart. The factory
                    // should create the same type of [DateTime] as the data provided. If none
                    // specified, the default creates local date time.
                    dateTimeFactory: const charts.LocalDateTimeFactory(),
                primaryMeasureAxis:
                new charts.NumericAxisSpec(showAxisLine: false, renderSpec: new charts.NoneRenderSpec()),
    )
          )
    ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 710, 30, 80),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                colors: [Colors.teal, Colors.black],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                stops: [0.0,1.0],
                tileMode: TileMode.clamp
    ),
              borderRadius: BorderRadius.circular(20),
                border: Border.all(
                color: Colors.teal
    )
            ),

          ),
          Container(
            margin: EdgeInsets.fromLTRB(50, 730, 0, 0),
            child: CustomPaint(
              foregroundPainter: CircleProgress(animation.value), //this will add custom painter after child
              child: Container(
                width: 70,
                height: 70,

                child:  GestureDetector(
                  onTap: (){
                    if(animation.value == 80 ){
                      _progressController.reverse();
                    }else{
                      _progressController.forward();
                    }
                  },
                  child: Center(
                    child: Text('${animation.value.toInt()}%',style: TextStyle(
                        color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold
                    ),),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(135, 750, 0, 0),
            child: Text('Your credit limit', style: TextStyle(
    color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
          )
          ),
          Container(
            margin: EdgeInsets.fromLTRB(135, 770, 0, 0),
            child: Text('\$ 39,750 of 53,000', style: TextStyle(
    color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
          )
          ),
          
          Container(
            child: FlatButton(
              child: Icon(Icons.navigate_next, color: Colors.teal,),shape: CircleBorder(),
              color: Colors.grey[800],
              onPressed: () { Navigator.pushReplacementNamed(context, '/CardsPage');},
            ),
            margin: EdgeInsets.fromLTRB(300, 740, 0, 0),

          )
    ]
    )
    );
  }
}


/// Create one series with sample hard coded data.
List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
final data = [
new TimeSeriesSales(new DateTime(2017,), 5),
new TimeSeriesSales(new DateTime(2018,), 25),
new TimeSeriesSales(new DateTime(2019,), 100),
new TimeSeriesSales(new DateTime(2020,), 75),
];

return [
new charts.Series<TimeSeriesSales, DateTime>(
id: 'Sales',
colorFn: (_, __) => charts.MaterialPalette.teal.shadeDefault,
domainFn: (TimeSeriesSales sales, _) => sales.time,
measureFn: (TimeSeriesSales sales, _) => sales.sales,
data: data,
)
];
}


/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}

class CardsPage extends StatefulWidget {
  @override
  _CardsPageState createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  String dropdownValue = 'All';
  bool isSwitched = false;
  bool isSwitched1 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
        icon: Icon(
        Icons.arrow_back_ios, color: Colors.teal[200],
    ),
    onPressed: () {
      Navigator.popAndPushNamed(context, '/home');
    },
    ),
    actions: [IconButton(
    icon: Icon(Icons.menu, color: Colors.teal[200],),
    onPressed: (){},
    )
    ],
    ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(165, 130, 0, 0),
            child: Text(
              'My Cards', style: TextStyle(
              color: Colors.white, letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 17
            ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 180, 0, 550),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 100),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15), color: Colors.teal
                        ),
                        padding: EdgeInsets.all(7),
                        child: IconButton(
                          icon: Icon(Icons.add), color: Colors.black,
                          onPressed: () {},
                        )
                    ),
                  ),
                  Container(
                      width:270,
                   margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15), color: Color(0xFF828282)
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Stack(
                                children: [
                                  Container
                                    (
                                      padding: EdgeInsets.fromLTRB(92, 0, 0, 0),
                                      child: Stack(children: [Image.asset('Assets/Path 2@2x.png',  ),
                                        Container(
                                          margin: EdgeInsets.fromLTRB(110, 0, 0, 0),
                                          child: Switch(
                                            value: isSwitched1,
                                            onChanged: (value){
                                              setState(() {
                                                if(isSwitched == true){
                                                  isSwitched1 == false;
                                                }else{
                                                  isSwitched1 ==true;
                                                }
                                                isSwitched1=value;
                                                print(isSwitched1);
                                              });
                                            },
                                            activeTrackColor: Colors.lightGreenAccent,
                                            activeColor: Colors.white,
                                            inactiveTrackColor:  Colors.white,
                                          ),
                                        ),
                                      ])),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(20, 30, 0, 0),
                                    child: Text(
                                      '**** 6543', style: TextStyle(
                                      color: Colors.white, letterSpacing: 2,
                                    ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(20, 105, 0, 0),
                                    child: Text(
                                      'Balance', style: TextStyle(
                                        color: Colors.white, fontSize: 13
                                    ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(20, 120, 0, 0),
                                    child: Text(
                                      '\$ 1,524', style: TextStyle(
                                        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold
                                    ),
                                    ),
                                  ),
                                ],
                              )

                          )
                      )
                  ),Container(
                      height: 10,
                      width:270,
                   margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15), color: Colors.lightBlueAccent
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Stack(
                                children: [
                                  Container
                                    (
                                      padding: EdgeInsets.fromLTRB(92, 0, 0, 0),
                                      child: Stack(children: [Image.asset('Assets/Path 2@2x.png',  ),
                                        Container(
                                          margin: EdgeInsets.fromLTRB(110, 0, 0, 0),
                                          child: Switch(
                                            value: isSwitched,
                                            onChanged: (value){
                                              setState(() {
                                                if(isSwitched1 == true){
                                                  isSwitched == false;
                                                }else{
                                                  isSwitched == true;
                                                }
                                                isSwitched=value;
                                                print(isSwitched);
                                              });
                                            },
                                            activeTrackColor: Colors.lightGreenAccent,
                                            activeColor: Colors.white,
                                            inactiveTrackColor:  Colors.white,
                                          ),
                                        ),
                                      ])),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(20, 30, 0, 0),
                                    child: Text(
                                      '**** 3432', style: TextStyle(
                                      color: Colors.white, letterSpacing: 2,
                                    ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(20, 105, 0, 0),
                                    child: Text(
                                      'Balance', style: TextStyle(
                                        color: Colors.white, fontSize: 13
                                    ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(20, 120, 0, 0),
                                    child: Text(
                                      '\$ 5,524', style: TextStyle(
                                        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold
                                    ),
                                    ),
                                  ),
                                ],
                              )

                          )
                      )
                  ),

              ],
            ),
          ),


          Container(
            margin: EdgeInsets.fromLTRB(20, 400, 0, 0),
            child: Text(
              'Popular operations', style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold
            ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 470, 0, 360),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
              Container(

                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15), color: Colors.teal
                      ),
                      padding: EdgeInsets.all(7),
                      child: IconButton(
                        icon: Icon(Icons.home), color: Colors.black,
                        onPressed: () {},
                        tooltip: 'All',
                      )
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15), color: Colors.teal
                      ),
                      padding: EdgeInsets.all(7),
                      child: IconButton(
                        icon: Icon(Icons.favorite), color: Colors.black,
                        onPressed: () {},
                        tooltip: 'Health',
                      )
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15), color: Colors.teal
                      ),
                      padding: EdgeInsets.all(7),
                      child: IconButton(
                        icon: Icon(Icons.flight), color: Colors.black,
                        onPressed: () {},
                        tooltip: 'Travel',
                      )
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15), color: Colors.teal
                    ),
                    padding: EdgeInsets.all(7),
                    child: IconButton(
                      icon: Icon(Icons.fastfood), color: Colors.black,
                      onPressed: () {},
                      tooltip: 'Food',
                    ),
                  ),
                ),Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15), color: Colors.teal
                    ),
                    padding: EdgeInsets.all(7),
                    child: IconButton(
                      icon: Icon(Icons.phone_iphone), color: Colors.black,
                      onPressed: () {},
                      tooltip: 'Airtime',

                    ),
                  ),
                )
              ],
            ),
          ),


          Stack(
            children: [
              SlidingUpPanel(
//                collapsed: _floatingCollapsed(),
              minHeight: 80,
                panel:  Stack(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                          child: Text(
                            'Transactions', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0,
                              color: Colors.black
                          ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(150, 10, 0, 0),
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.black),
                            underline: Container(
                              height: 2,
                              color: Colors.black,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue = newValue;
                              });
                              },
                            items: <String>['All', 'One', 'Free', 'Four']
                                .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                          child: Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 270),
                              width: 35,
                              height: 5,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.all(Radius.circular(12.0))
                )
            ),
          )
        ],
      ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 60, 0, 0),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),  color: Colors.black
                              ),
                              child:
                                  Image.asset('Assets/1829956-20.png',),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(25, 40, 0, 0),
                              child: Text(
                                'Invision', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.fromLTRB(160, 50, 0, 0),
                              child: Text(
                                '-68.03', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                            Row(
                              children: [
                                Container(

                                  margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),  color: Colors.black
                                  ),
                                  child:
                                  Image.asset('Assets/mcdonalds-png-logo-simple-m-1.png',),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(25, 0, 0, 15),
                                  child: Text(
                                    'McDonald\'s', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                ),

                                Container(
                                  margin: EdgeInsets.fromLTRB(130, 0, 0, 0),
                                  child: Text(
                                    '-68.03', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),  color: Colors.black
                                  ),
                                  child:
                                  Icon(Icons.favorite, color: Colors.red,)
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(25, 0, 0, 15),
                                  child: Text(
                                    'Invision', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                ),

                                Container(
                                  margin: EdgeInsets.fromLTRB(160, 0, 0, 0),
                                  child: Text(
                                    '-68.03', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),


                      ],
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(95, 110, 0, 0),
                      child: Text(
                        '13 Nov, 8:34 AM', style: TextStyle(fontSize: 12, letterSpacing: 1),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(95, 185, 0, 0),
                      child: Text(
                        '9 Nov, 3:52 PM', style: TextStyle(fontSize: 12, letterSpacing: 1),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(95, 255, 0, 0),
                      child: Text(
                        '7 Nov, 3:34 PM', style: TextStyle(fontSize: 12, letterSpacing: 1),
                      ),
                    ),

    ],
    ),
                borderRadius: BorderRadius.circular(30), color: Color(0xFF828282), maxHeight: 300,
              ),
            ],
          )
        ],
      ),
    );
  }
}

//Widget _floatingCollapsed() {
//  return Container(
//      child: Row(
//        children: [
//          Container(
//            margin: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
//            child: Text(
//              'Transactions', style: TextStyle(
//                fontWeight: FontWeight.bold,
//                fontSize: 24.0,
//                color: Colors.black
//            ),
//            ),
//          ),
//
//        ],
//      ));
//}