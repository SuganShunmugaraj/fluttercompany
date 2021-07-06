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
  Map addEdit={};
  var paymentMode;
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
  }


  addAmount(amount){
    var receivedAmount = amount;

    this.payment.forEach((element) { 
      print(element['subTotal']);
     var test =   int.parse(amount) - element['subTotal'] ;
     if(test > 0){
       test  =   test - element['subTotal'];
     }else{
       return false;
     }
     print(test);
      // if(element['subTotal'] > amount ){ 
      //       element['amountPaid'] = element['subTotal'] - amount;
      // }
     
    });
    
    }


  savePaymentDetails()async{
    Map addPayment={
        'accountCompanyName':payment[0]['customerName']['companyName'],
'accounts': [{
'accountsinvoice': payment[0]['invoice'],
'accountsinvoiceDate': dateFormat(payment[0]['createdAt']),
'amountPaid': payment[0]['amountPaid'],
'balanceAmount': payment[0]['subTotal']-payment[0]['amountPaid'],
'dueAmount': 650,
'invoiceAmount': payment[0]['subTotal'],
'invoiceId': payment[0]['_id'],
'paymentAmount': payment[0]['amountPaid'],
'staticPaymentAmount': null
}],
'accountsCompanyId': payment[0]['customerName']['_id'],
'accountsDate': this.addEdit['paymentDate'],
'accountscustomerName': payment[0]['customerName']['userName']['firstName'],
'paymentCount': this.addEdit['paymentCount'],
'paymentMode':this.paymentMode,
      };
      final response = await http.post(Uri.parse(BaseUrl.payment),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode(addPayment));
      var res = response.body;
      if (response.statusCode == 200) {
        print('sucess');
      } else {
        print("Error :" + res);
      }print(addPayment);
    }
    

editPayment(paymentDate,paymentCount){
   setState(() {
      this.addEdit = {
        'paymentDate': paymentDate,
        'paymentCount': paymentCount,
      };
    });
}

setPaymentMode(paidMethod){
  setState(() {
  paymentMode= paidMethod;
  });
}
 Map editPaid = {
        'paymentDate':  dateFormat(DateTime.now()).toString(),
        'paymentCount': 'PAY003',
      };

final paymentCount = TextEditingController();
  final paymentDate = TextEditingController();
    @override
  void initState() {
    super.initState();
    getData(); 
     paymentDate.text = this.editPaid['paymentDate'];
    paymentCount.text = this.editPaid['paymentCount'];
  }
 // bool _afternoonOutdoor = false;
 
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
      body:Stack(children: [
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
                               Text(paymentCount.text, style: TextStyle(color: Colors.purple),),
                              Container(padding: const EdgeInsets.only(top:7.0),
                                child: Text(paymentDate.text,style: TextStyle(color: Colors.grey.shade500),))
                            ],
                            ),
                          ),
                          Container(padding: const EdgeInsets.only(right:15.0),
                           child:GestureDetector(
                             onTap: (){
                               showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return SingleChildScrollView(
                                      child:Container(
                                         child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Text(
                                                  'Edit Payment Date & Count',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                            Container(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0),
                                                child: Text('Payment Date')),
                                            Container(
                                                height: 40.0,
                                                padding: const EdgeInsets.only(
                                                    left: 15.0,
                                                    right: 15.0,
                                                    top: 5.0),
                                                child: TextFormField(
                                                  controller: paymentDate,
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText: "Payment Date",
                                                    suffixIcon: Icon(Icons
                                                        .calendar_today_outlined),
                                                  ),
                                                  onTap: () async {
                                                    DateTime date =
                                                        DateTime(1900);
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            new FocusNode());
                                                    date = await showDatePicker(
                                                        context: context,
                                                        initialDate:
                                                            (DateTime.now()),
                                                        firstDate:
                                                            DateTime(1900),
                                                        lastDate:
                                                            DateTime(2100));

                                                    paymentDate.text =
                                                        dateFormat(date)
                                                            .toString();
                                                  },
                                                )),
                                         
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          top: 15.0,
                                                          left: 5.0,
                                                        ),
                                                        child: Text(
                                                            'Payment Count')),
                                                    Container(
                                                      height: 40.0,
                                                      width: 340.0,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5.0,
                                                              top: 5.0,
                                                              right: 5.0),
                                                      child: TextField(
                                                        controller: paymentCount,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          labelText: ' Payment Count',
                                                          // hintText: 'Enter Number',
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                         
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0, right: 15.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  RaisedButton(
                                                      onPressed: () {
                                                        editPayment(
                                                          paymentDate.text,
                                                          paymentCount.text,
                                                          );Navigator.pop(context);
                                                      },
                                                      textColor: Colors.white,
                                                      color: Colors
                                                          .tealAccent.shade700,
                                                      child: Text(
                                                        'Save',
                                                        style: TextStyle(
                                                            fontSize: 20),
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      
                                      )
                                    );
                                    }
                                    );

                             },child: Text('Edit',style: TextStyle(color: Colors.purple),),
                           ) 
                           //Text('Edit',style: TextStyle(color: Colors.purple),),
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
                                      Container( padding: const EdgeInsets.only(left: 15.0),
                                        child: Text('Current Balence: ',style: TextStyle(color: Colors.grey.shade500),)),
                                  Container(padding: const EdgeInsets.only(right: 15.0),
                                    child: Text('₹ 12124',style: TextStyle(color: Colors.green),))
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
                                  child: Text(value['userName']['firstName'],
                                    style: TextStyle(
                                      color: Colors.white,
                                     // fontSize: 20.0,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                drop=value['userName']['firstName'];
                                getId(value['_id']);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
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
                        ),],
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
                                             border:  OutlineInputBorder(), 
                                             labelText: '₹',
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
                               child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                      //              Container(
                      //                child: Checkbox(
                      // value: _afternoonOutdoor,
                      // onChanged: (bool value) {
                      //   setState(() {
                      //     _afternoonOutdoor = value;
                      //   });
                      // }),
                      //  ),
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
                                  color:paymentMode=='Cash'?Colors.tealAccent.shade700:Colors.grey.shade300,
                                  onPressed: (){
                                    setPaymentMode('Cash');
                                  }, child: Text('Cash',)),
                                    ),
                                   Container(height: 25.0,width: 90.0,
                                     padding: const EdgeInsets.only(left:5.0,),
                                     child: FlatButton(
                                  shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
        ),
                                  color:paymentMode=='Cheque'?Colors.tealAccent.shade700:Colors.grey.shade300,
                                  onPressed: (){
                                    setPaymentMode('Cheque');

                                  }, child: Text('Cheque',)),
                                   ),
                                   Container(height: 25.0,width: 80.0,
                                     padding: const EdgeInsets.only(left:5.0,),
                                     child: FlatButton(
                                  shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
        ),
                                  color:paymentMode=='Online'?Colors.tealAccent.shade700:Colors.grey.shade300,
                                  onPressed: (){
                                     setPaymentMode('Online');

                                  }, child: Text('Online',)),
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
                child: RaisedButton(
                  onPressed: () {
                   savePaymentDetails();Navigator.pop(context);
                },
                child: Text("Save",),color: Colors.tealAccent.shade700,textColor: Colors.white,)),
           
        )
                    
         
              ],
            ),
          ),
        ),
      ],
      )
    );
  }
}


dateFormat(dateFormat) {
  return DateUtil().formattedDate(DateTime.parse(dateFormat.toString()));
}

class DateUtil {
  static const DATE_FORMAT = 'yyyy-MMM-dd';
  String formattedDate(DateTime dateTime) {
    return DateFormat(DATE_FORMAT).format(dateTime);
  }
}