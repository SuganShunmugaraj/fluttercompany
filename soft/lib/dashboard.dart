import 'package:flutter/material.dart';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;





class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
   List<charts.Series> seriesList;
 
  static List<charts.Series<Sales, String>> _createRandomData() {
    final random = Random();
 
    final desktopSalesData = [
      Sales('2015', random.nextInt(100)),
      Sales('2016', random.nextInt(100)),
      Sales('2017', random.nextInt(100)),
      Sales('2018', random.nextInt(100)),
      Sales('2019', random.nextInt(100)),
    ];
 
    final tabletSalesData = [
      Sales('2015', random.nextInt(100)),
      Sales('2016', random.nextInt(100)),
      Sales('2017', random.nextInt(100)),
      Sales('2018', random.nextInt(100)),
      Sales('2019', random.nextInt(100)),
    ];
 
 
    return [
      charts.Series<Sales, String>(
        id: 'Sales',
        domainFn: (Sales sales, _) => sales.year,
        measureFn: (Sales sales, _) => sales.sales,
        data: desktopSalesData,
        colorFn: (Sales sales, __) => charts.ColorUtil.fromDartColor(Colors.teal.shade100),
        fillColorFn: (Sales sales, _) =>charts.ColorUtil.fromDartColor(Colors.teal.shade100),
      ),
      charts.Series<Sales, String>(
        id: 'Sales',
        domainFn: (Sales sales, _) => sales.year,
        measureFn: (Sales sales, _) => sales.sales,
        data: tabletSalesData,
        colorFn: (Sales sales, __) => charts.ColorUtil.fromDartColor(Colors.tealAccent.shade700),
        fillColorFn: (Sales sales, _) =>charts.ColorUtil.fromDartColor(Colors.tealAccent.shade700),
      ),
    ];
  }
 
  barChart() {
    return charts.BarChart(
      seriesList,
      animate: true,
      vertical: true,
      barGroupingType: charts.BarGroupingType.grouped,
      defaultRenderer: charts.BarRendererConfig(
        groupingType: charts.BarGroupingType.grouped,
        strokeWidthPx: 1.0,
      ),
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: charts.NoneRenderSpec(),
      ),
    );
  }
 
  @override
  void initState() {
    super.initState();
    seriesList = _createRandomData();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(padding: const EdgeInsets.only(left: 15.0,top: 15.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(padding: const EdgeInsets.only(right: 15.0,top: 15.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Orchid Family',style: TextStyle(fontWeight: FontWeight.bold),),
                    Container(
  width: 30,
  height: 30,
  child:
   Stack(
    children: [
      Icon(
        Icons.notifications,
        color: Colors.grey,
        size: 30,
      ),
      Container(
        width: 30,
        height: 30,
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(top: 2),
        child: Container(
          width: 9,
          height: 9,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
             // border: Border.all(color: Colors.white, width: 1)
             ),
         
        ),
      ),
    ],
  ),)
                   // Icon(Icons.notifications)
                  ],
                ),
              ),

              Container(padding: const EdgeInsets.only(top: 20.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('₹ 45,200',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30.0),),
                   
                    Container(
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text('Current cash Balence',style: TextStyle(fontSize: 10.0,color: Colors.grey),),
          Container(padding: const EdgeInsets.only(left: 50.0),
            child: Row(
              children: [
                Icon(Icons.circle,size: 12.0,color: Colors.tealAccent.shade700,),
                Text(' Money In',
                  style: TextStyle(fontSize: 10.0
                      // color: Color(0xff797979)
                  ),
                ),
              ],
            )
        ),
           Container(padding: const EdgeInsets.only(right: 15.0),
            child: Row(
              children: [
                Icon(Icons.circle,size: 12.0,color: Colors.teal.shade100,),
                Text(' Money Out',
                  style: TextStyle(fontSize: 10.0
                      // color: Color(0xff797979)
                  ),
                ),
              ],
            )
        ),
          ],),
                    ),
              

                  ],
                )),
              
           Container(
             height: 270.0,
        child: barChart(),
      ),
Container(
  padding: const EdgeInsets.only(top: 30.0,right: 15.0),
 
  child: DefaultTabController(
                        length: 3,
                        initialIndex: 0,
                        child: Column(
                          children: [
                          Container(
                            height: 30.0,
                            child: TabBar(
                              indicatorWeight: 0,
                       unselectedLabelColor: Colors.grey,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.tealAccent.shade700,
                        
                        ),
                              tabs: [
                                Tab(
                                   child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                 border: Border.all(
                                  color: Colors.tealAccent.shade700, 
                                      )
                                      ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("Payments",
                                style: TextStyle(fontWeight: FontWeight.bold),), 
                              ),
                            ),
                                ),
                                Tab(
                                   child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: Colors.tealAccent.shade700, 
                                      width: 1)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("Invoices",
                                style: TextStyle(fontWeight: FontWeight.bold),), 
                              ),
                            ),
                                ),
                                Tab(
                                   child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: Colors.tealAccent.shade700, 
                                      width: 1)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("Upcoming",
                                style: TextStyle(fontWeight: FontWeight.bold),), 
                              ),
                            ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 100,
                            child: TabBarView(children: [
                              Container(
                                child: Column(
                                  children: [
                                    Text('ssss')
                                 ],
                                ),
                              ),
                              SingleChildScrollView(
                                child: Container(
                                  child: Column(
                                    children: [
                                      Text('aad')
                                    ],
                                  ),
                                ),
                              ),
                             
                              Container(
                                  child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Text('ssssssssss')
                                    ],
                                ),
                              )),
                            ]),
                          ),
                        
                        ])),
               
)
                 
          ]),
        ));
  }
}

class Sales {
  final String year;
  final int sales;
 
  Sales(this.year, this.sales);
}