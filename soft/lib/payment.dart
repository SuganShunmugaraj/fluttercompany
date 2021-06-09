import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:soft/config/upload_url.dart';
import 'package:intl/intl.dart';
class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  List customer=[];
  List payment=[];
    Future getData() async {
    var response = await http.get(Uri.parse(BaseUrl.contacts),
        headers: {"Accept": "application/json"});
    this.setState(() {
      var customerData = json.decode(response.body);
      customer = customerData['data'];
    });
  }


  getId(getid)async{
     var response = await http.get(Uri.parse(BaseUrl.invoice + getid),
        headers: {"Accept": "application/json"});
    this.setState(() {
   var paymentList = json.decode(response.body);
      payment = paymentList['data'];
    }); 
    print(payment);
  }


  addAmount(amount){
    this.payment.forEach((element) { 
      
    });
    print(amount);
    print(payment);

  }

    @override
  void initState() {
    super.initState();
    getData(); 
    
  }
  bool _afternoonOutdoor = false;
 
  String _chosenValue;
  String drop = 'Customer Name';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
       appBar:AppBar(backgroundColor: Colors.white,
        title: Text('Add Received Payment',style: TextStyle(color: Colors.black
        ),),
        leading: Icon(Icons.arrow_back,color: Colors.black,),
        ),
      body: payment.length>0?
      Stack(children: [
        SingleChildScrollView(
          child: Container(  padding: const EdgeInsets.only(bottom:65.0),
            child: Column(
              children: [
                Padding(
                     padding: const EdgeInsets.only(top:10.0),
                     child: Container(  color: Colors.white,
                       child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left:15.0,top: 15.0,bottom: 15.0),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text('Received Payment #4', style: TextStyle(color: Colors.purple),),
                              Container(padding: const EdgeInsets.only(top:7.0),
                                child: Text('21 May 2021',style: TextStyle(color: Colors.grey.shade500),))
                            ],
                            ),
                          ),
                          Container(padding: const EdgeInsets.only(right:15.0),
                           child: Text('Edit',style: TextStyle(color: Colors.purple),),
                          ),
                          
                        ],
                  ),
                     ),
                   ),
                    Padding(
                     padding: const EdgeInsets.only(top:10.0),
                     
                     child: Container(  
                      
                       color: Colors.white,
                       child: Container(padding: const EdgeInsets.only(left:15.0,right: 15.0,top: 10.0),
                         child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                     Text('PARTY NAME',style: TextStyle(
                               fontWeight:FontWeight.bold
                             ), ),
                                      Container( padding: const EdgeInsets.only(left: 80.0),
                                        child: Text('Current Balence: ',style: TextStyle(color: Colors.grey.shade500),)),
                                  Text('₹ 12124',style: TextStyle(color: Colors.green),)
                              ],
                  ),
                         Container( 
                          child: 
                          DropdownButtonHideUnderline(
                                child: 
                                DropdownButton(
                              dropdownColor: Colors.tealAccent.shade700,
                              value: _chosenValue,
                              style: TextStyle(
                                  color: Colors.white,
                                  decorationColor: Colors.white),
                              items: customer.map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(
                                    value['userName']['firstName'],
                                    style: TextStyle(
                                      color: Colors.white,
                                     // fontSize: 20.0,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                 getId( value['_id']);
                              },
                              hint: Text(this.drop.toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                  )),
                              icon: Icon(
                                Icons.arrow_drop_down,
                                //color: Colors.white,
                              ),
                            ),
                         
                          ),
                        ),

  //      Container(height: 60.0,
  // padding: const EdgeInsets.only(top: 10.0,bottom: 15.0),
  //                 child:TextField( 
  //                    decoration: InputDecoration(  
  //                       filled: true,
  //                   fillColor: Colors.grey.shade200,
  //                                          border:  InputBorder.none, 
  //                                        prefixIcon: Icon(Icons.person_outline),
  //                                          labelText: 'Name',
  //                                          hintText: 'Enter Name',  
  //                     ),  
  //                   ), ), 
                           
                           ],
                         ),
                       ),
                     ),
                   ),
              
                Padding(
                     padding: const EdgeInsets.only(top:10.0),
                     child: Container(  
                      
                       color: Colors.white,
                       child: Container(padding: const EdgeInsets.only(left:15.0,right: 15.0,top: 10.0,bottom: 10.0),
                         child:
                             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                     Text('AMOUNT',style: TextStyle(
                               fontWeight:FontWeight.bold
                             ), ),
                                      Container(width: 250.0,
                                      height: 45.0,
                                        child: TextField(  onChanged: (text) {
                                         addAmount(text);
                                        },
                     decoration: InputDecoration( 
                        //filled: true,
                   // fillColor: Colors.grey.shade200,
                                             border:  OutlineInputBorder(), 
                                           //prefixIcon: Icon(Icons.person_outline),
                                             labelText: ('₹'),
                                             hintText: 'Enter Amount',  
                      ),  
                    ),
                                      ),
                           ],
                         ),
                       ),
                     ),
                   ),
                  
                   for (var i = 0;i <payment.length;i++)
                  Padding(
                     padding: const EdgeInsets.only(top:10.0),
                     child: Container( 
                       color: Colors.white,
                       child: Container(padding: const EdgeInsets.only(left:15.0,right: 15.0,top: 10.0,bottom: 10.0),
                         child:Column(crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             
                             Text('Invoice',style: TextStyle(
                               fontWeight:FontWeight.bold
                             ),),
                             Text('Settle outstanding Invoice with the above Payment',style: TextStyle(
                               color: Colors.grey.shade500
                             ),),


                             Container(padding: const EdgeInsets.only(top: 15.0,),
                               child: Row(
                                 children: [
                                   Container(
                                     child: Checkbox(
                      value: _afternoonOutdoor,
                      onChanged: (bool value) {
                        setState(() {
                          _afternoonOutdoor = value;
                        });
                      }),
                       ),
                        Container(
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(payment[i]['invoice'].toString()),
                                      Text(dateFormat(payment[i]['createdAt']),style: TextStyle(color: Colors.grey.shade500),)
                                    ],
                                  ),
                                ),
                                Container(padding: const EdgeInsets.only(left:65.0),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(payment[i]['subTotal'].toString()),
                                      Text(payment[i]['amountPaid'].toString(),style: TextStyle(color: Colors.green),),
                                      Text((payment[i]['subTotal']-payment[i]['amountPaid']).toString()+' '+ ' Remaining',style: TextStyle(color: Colors.red),)
                                    ],
                                  ),
                                )
                                
                                 ],
                               ),
                            
                             ),
                              
                           
                             
                           ],
                         )
                            
                       ),
                     ),
                   ),  
              
                 Padding(
                     padding: const EdgeInsets.only(top:10.0),
                     child: Container(  
                      
                       color: Colors.white,
                       child: Container(padding: const EdgeInsets.only(left:15.0,right: 15.0,top: 10.0,bottom: 10.0),
                         child:Column(crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text('PAYMENT MODE',style: TextStyle(
                               fontWeight:FontWeight.bold
                             ),),
                             Container(
                               padding: const EdgeInsets.only(top: 10.0,),
                               child: Row(
                                 children: [
                                    Container(height: 25.0,width: 70.0,
                                      child: FlatButton(
                                  shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
        ),
                                  color: Colors.grey.shade300,
                                  onPressed: (){}, child: Text('Cash',)),
                                    ),
                                   Container(height: 25.0,width: 90.0,
                                     padding: const EdgeInsets.only(left:5.0,),
                                     child: FlatButton(
                                  shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
        ),
                                  color: Colors.grey.shade300,
                                  onPressed: (){}, child: Text('Cheque',)),
                                   ),
                                   Container(height: 25.0,width: 80.0,
                                     padding: const EdgeInsets.only(left:5.0,),
                                     child: FlatButton(
                                  shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
        ),
                                  color: Colors.grey.shade300,
                                  onPressed: (){}, child: Text('Online',)),
                                   ),
                                 ],
                               ),
                             ),
                             Container(  padding: const EdgeInsets.only(top: 10.0,),
                               child: Row(
                                 children: [
                                   Icon(Icons.add_circle,color: Colors.purple,),
                                   Text('  Add Node/Description',style: TextStyle(
                               color: Colors.purple
                             ),)
                                 ],
                               ),
                             ),
                             Divider(),
                           ],
                         )
                             
                       ),
                     ),
                   ),
              ],
            ),
          ),
        ),
         Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            height: 60,
            width: double.infinity,
            color: Colors.white,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container( padding: const EdgeInsets.only(top:10.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('New Party Balence'),
                      Text('₹  13145',style: TextStyle(color: Colors.green),),
                    ],
                  )
                ),
               Container(
                   padding: const EdgeInsets.only(left:15.0),
                   child:
              SizedBox(
                width: 165.0,
                child: RaisedButton(onPressed: () {},child: Text("Save",),color: Colors.purple,textColor: Colors.white,)),
           
        )
                    
         
              ],
            ),
          ),
        ),
      ],
      ):
      
      Container(child:Text('dilip'))
    );
  }
}


dateFormat(dateFormat) {
  return DateUtil().formattedDate(DateTime.parse(dateFormat));
}

class DateUtil {
  static const DATE_FORMAT = 'yyyy-MMM-dd';
  String formattedDate(DateTime dateTime) {
    return DateFormat(DATE_FORMAT).format(dateTime);
  }
}