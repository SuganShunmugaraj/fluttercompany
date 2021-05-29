

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:soft/config/upload_url.dart';


class CreateItems extends StatefulWidget {
 
  @override
  _CreateItemsState createState() => _CreateItemsState();
}

class _CreateItemsState extends State<CreateItems> {
  String _chosenValue;

  Map subDetail={};
List service;

  Future getData() async {
    var response = await http.get(Uri.parse(BaseUrl.service),
        headers: {"Accept": "application/json"});
    this.setState(() {
      var categoryData = json.decode(response.body);
      service = categoryData['data'];
    });
    print('..............................');
    print(service);
    print('........................');
  }

 
  
  addContact(serviceName, serviceSaleSellingPrice)async{
    print(serviceName, );
    print(serviceSaleSellingPrice);
    
    setState(() {
       this.subDetail['serviceName'] = serviceName;
      this.subDetail['serviceSaleSellingPrice'] = serviceSaleSellingPrice;
     
     service.add(subDetail);
     print('...................');
    print(service);
     print(subDetail);
    print('...................');
    }
    ); final response = await http.post(Uri.parse(BaseUrl.service),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(this.subDetail));
       var res = response.body;

    if (response.statusCode == 200) {
      print('sucess');
    } else {
      print("Error :" + res);
    }
  }
  
  @override
  void initState() {
    getData();
   
    super.initState();
  }

  final categoryName = TextEditingController();
  final categoryDescription = TextEditingController();
  final subcategoryName = TextEditingController();
  final subcategoryDescription = TextEditingController();
  final categoryid = TextEditingController();
  final serviceName = TextEditingController();
  final serviceSaleSellingPrice = TextEditingController();
 String drop = 'Select Category ';
 String title = 'Select Subcategory';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(backgroundColor: Colors.white,
        title: Text('Create New Item',style: TextStyle(color: Colors.black

        ),),
        leading: Icon(Icons.arrow_back,color: Colors.black,),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:15.0),
            child: Icon(Icons.settings,color: Colors.black,),
          )
        ],
        ),
        body: Stack(
                  children:[ 
                    SingleChildScrollView(
            child: Container(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(padding: const EdgeInsets.only(left:15.0,top: 15.0),
                                                 child: Text('Service Name')),
                                              Container(
                                                height: 40.0,
                                                padding: const EdgeInsets.only(left:15.0,right: 15.0,top: 5.0),
                                                child: TextField(  
                                          //obscureText: true,  
                                         decoration: InputDecoration(  
                                         border: OutlineInputBorder(), 
                                        //  suffixIcon: Icon(Icons.calendar_today_outlined),
                                         labelText: ' Service Name',
                                         hintText: 'Enter Service Name',  
                      ),controller: serviceName,
                    ),   
                     ),
                 
                  Container(
                    child:DropdownButton(
                       dropdownColor:Colors.tealAccent .shade700,
                          value:_chosenValue,
                            style: TextStyle( color: Colors.white,
                              decorationColor:Colors.white),
                            items:this.service.map((pageon) {
                              return DropdownMenuItem(
                               value: pageon['serviceCategory']['_id'],
                                child: Text(pageon['serviceCategory']['categoryName'],
                                  style:TextStyle(color: Colors.white,
                                   fontSize:20.0,
                                ),
                                ),
                                );
                                }).toList(),
                                 onChanged: (value) {
                                   this.subDetail['serviceCategory'] =value;
                                   print(this.subDetail['serviceCategory'] =value);
                                                                
                                   },
                                   hint: Text(
                                  this.drop.toString(),
                                    style:TextStyle(color: Colors.black,
                                     fontSize: 20.0,
                                     )),
                                      icon: Icon(Icons.arrow_drop_down,
                                      color: Colors.white,
                                     ),
                                    ),
                                  ),
                                                         
                     Container(
                            child: DropdownButton(dropdownColor:Colors.tealAccent.shade700,
                             value:_chosenValue,
                              style: TextStyle(color: Colors .white,
                               decorationColor:Colors.white),
                               items:this.service.map((pagesubCategory) {
                               return DropdownMenuItem(
                               value: pagesubCategory['serviceSubCategory']['_id'],
                               child: Text(pagesubCategory['serviceSubCategory']['subcategoryName'],
                                 style:TextStyle(
                                color: Colors.white,
                                fontSize:20.0,
                               ),
                               ),
                              );
                            }).toList(),
                              onChanged: (value) {
                              print('.........');
                               this.subDetail['serviceSubCategory'] =value;
                             print(this.subDetail['serviceSubCategory'] =value);
                             print('...........');
                            },
                             hint: Text(this.title.toString(),
                             style:TextStyle(color: Colors.black,
                             fontSize: 20.0,
                              )),
                               icon: Icon(Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                              ),
                         ),
                       
                    //  Container(padding: const EdgeInsets.only(left:15.0,),
                    //     child: Column(
                    //       children: [
                    //         Text('serviceSaleInfo  :'  + this.widget.category['serviceSaleInfo']),
                    //         Text('serviceUnit  : '),
                    //         Container(padding: const EdgeInsets.only(left:15.0,),
                    //           child: Text('name  :  '  + this.widget.category['serviceUnit']['name'])),
                    //         Container(
                    //           child: Text('id  :  '  + this.widget.category['serviceUnit']['id']))
                    //       ],
                    //     ),

                    //   ),
                  
                          


                       Container(padding: const EdgeInsets.only(left:15.0,top: 15.0),
                               child: Text('Item Type')),
                               Container(padding: const EdgeInsets.only(left:15.0,top: 15.0,right: 200.0),
                                 child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Container(color: Colors.grey.shade200,
                               child: Text('Product')),
                                Container(
                                  color: Colors.grey.shade200,
                               child: Text('Service')),
                                   ],
                                 ),
                               ),
                               Divider(),
                                DefaultTabController(
                      length: 1,
                      initialIndex: 0,
                      child: Column(
                        children: [
                        TabBar(
                          indicatorColor: Colors.tealAccent.shade700,
                          isScrollable: true,
                          unselectedLabelColor: Colors.black,
                          labelColor: Colors.tealAccent.shade700,
                          tabs: [
                            Tab(text: 'Pricing'),
                            // Tab(text: 'Stock'),
                            // Tab(text: 'Others'),
                          ],
                        ),
                        Divider(),
                       Container(
                          height: 550,
                          child: TabBarView(children: [
                            Container(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container( padding: const EdgeInsets.only(left:15.0,right: 15.0,),
                                                 child: Text('Sales Price')),
                                              Container(
                                                height: 40.0,
                                                padding: const EdgeInsets.only(left:15.0,right: 15.0,top: 5.0),
                                                child: TextField(  
                                         // obscureText: true,  
                                          controller: serviceSaleSellingPrice,
                                         decoration: InputDecoration(  
                                         border: OutlineInputBorder(), 
                                          suffixIcon:  Container(
                                            child: DropdownButton<String>(
  focusColor:Colors.white,
  value: _chosenValue,
  //elevation: 5,
  style: TextStyle(color: Colors.blue),
  iconEnabledColor:Colors.black,
  items: <String>[
    'Android',
    'IOS',
    'Flutter',
    'Node',
    'Java',
    'Python',
    'PHP',
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value,style:TextStyle(color:Colors.black),),
    );
  }).toList(),
  hint:Text(
    "Add Unit",
    style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500),
  ),
  onChanged: (String value) {
    setState(() {
      _chosenValue = value;
    });
  },
),
                                          ),
                                         labelText: ' ₹',
                                         hintText: 'Enter price',  
                      ),  
                    ),    
                     ),
                     Container(padding: const EdgeInsets.only(left:15.0,right: 15.0,),
                       child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.purple,
                          size: 18,
                        ),
                        Text('Add GST & Tax Details',style: TextStyle(color: Colors.purple),)
                      ],
                    ),
                     ),
                                 ],
                              ),
                            ),
                            
                    //          Container(
                    //           child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Container( padding: const EdgeInsets.only(left:15.0,right: 15.0,),
                    //                              child: Text('Sales Price')),
                    //                           Container(
                    //                             height: 40.0,
                    //                             padding: const EdgeInsets.only(left:15.0,right: 15.0,top: 5.0),
                    //                             child: TextField(  
                    //                       obscureText: true,  
                    //                      decoration: InputDecoration(  
                    //                      border: OutlineInputBorder(), 
                    //                     //  suffixIcon: Icon(Icons.calendar_today_outlined),
                    //                      labelText: ' Item Name',
                    //                      hintText: 'Enter Item Name',  
                    //   ),  
                    // ),  
                      
                    //  ),
                    
                    //              ],
                    //           ),
                    //         ),
                            
                    //          Container(
                    //           child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Container( padding: const EdgeInsets.only(left:15.0,right: 15.0,),
                    //                              child: Text('Item Name')),
                    //                           Container(
                    //                             height: 40.0,
                    //                             padding: const EdgeInsets.only(left:15.0,right: 15.0,top: 5.0),
                    //                             child: TextField(  
                    //                       obscureText: true,  
                    //                      decoration: InputDecoration(  
                    //                      border: OutlineInputBorder(), 
                    //                     //  suffixIcon: Icon(Icons.calendar_today_outlined),
                    //                      labelText: ' Item Name',
                    //                      hintText: 'Enter Item Name',  
                    //   ),  
                    // ),    
                    //  ),
                    //              ],
                    //           ),
                    //         ),
                            
                          ]),
                        ),
                        
                     
                
                                             
                ],
              ),
            ),
                
                 ] ),
          )),
                   Align(
          alignment: Alignment.bottomLeft,
          child:Container( padding: const EdgeInsets.only(left:15.0,right: 15.0),
                   child:
          Row(
            children: <Widget>[
              SizedBox(
                width: 165.0,
                child: RaisedButton(onPressed: () {},child: Text("Save & New",),color: Colors.white,textColor: Colors.purple,)),
               SizedBox(width: 165.0,
                 child: RaisedButton(onPressed: () {
                   addContact(
                     serviceName.text, 
                     serviceSaleSellingPrice.text
                     );Navigator.pop(context);
                 },child: Text("Save"),color: Colors.purple,textColor: Colors.white,)),
            ],
          ),
        )
          ),     
           ] ),
                   );
  }
}