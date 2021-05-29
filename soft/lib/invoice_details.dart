

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
class InvoiceDetails extends StatefulWidget {
  InvoiceDetails({
    this.name,
  });
  final Map name;
  @override
  _InvoiceDetailsState createState() => _InvoiceDetailsState();
}

class _InvoiceDetailsState extends State<InvoiceDetails> {
  String value;
  String expiry;
  String current;

  @override
  void initState() {
    super.initState();
    expiry = dateFormat(this.widget.name['expiryDate']);
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MMM-dd').format(now);

    if (expiry.compareTo(formattedDate.toString()) < 0) {
      value = 'OverDue';
    }
  }
  String _chosenValue;

  @override
  Widget build(BuildContext context) {
   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
   statusBarColor:Colors.purple.shade50, // Color for Android
   statusBarBrightness: Brightness.dark // Dark == white status bar -- for IOS.
));
    return Scaffold(
     backgroundColor: Colors.purple.shade50,
      appBar: AppBar(backgroundColor: Colors.white,
        title: Text('Create Bill/ Invoice',style: TextStyle(color: Colors.black

        ),),
        leading: Icon(Icons.arrow_back,color: Colors.black,),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:15.0),
            child: Icon(Icons.save,color: Colors.black,),
          )
        ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:50.0),
                  child: Container(
                    color: Color(0xFFECEFF1),
                     padding: const EdgeInsets.all(15.0),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Invoice #H5'),
                              GestureDetector(
                                onTap: (){
                                  showModalBottomSheet(context: context, builder: (BuildContext context){
                                    return SingleChildScrollView(
                                    child: new Container(
                                       
                                       
                                       child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Container(
                                             padding: const EdgeInsets.all(15.0),
                                             child: Text('Edit Invoice Date & Number',
                                             style: TextStyle(fontWeight: FontWeight.bold),
                                             )
                                             ), 
                                             Container(padding: const EdgeInsets.only(left:15.0),
                                               child: Text('Invoice Date')),
                                            Container(
                                              height: 40.0,
                                              padding: const EdgeInsets.only(left:15.0,right: 15.0,top: 5.0),
                                              child: TextField(  
                                        obscureText: true,  
                                       decoration: InputDecoration(  
                                       border: OutlineInputBorder(), 
                                       suffixIcon: Icon(Icons.calendar_today_outlined),
                                       labelText: ' Invoice Date',
                                       hintText: 'Enter Invoice Date',  
                    ),  
                  ),
                                            ), Container(padding: const EdgeInsets.only(left:15.0,top: 15.0),
                                               child: Text('Due Date')),
                                            Container(
                                              height: 40.0,
                                              padding: const EdgeInsets.only(left:15.0,right: 15.0,top: 5.0),
                                              child: TextField(  
                                        obscureText: true,  
                                       decoration: InputDecoration(  
                                       border: OutlineInputBorder(), 
                                      
                                       labelText: ' Due Date',
                                       hintText: 'Enter Due Date',  
                    ),  
                  ),
                                            ),

                  Container(padding: const EdgeInsets.only(left:15.0,top: 15.0),
                  
                    child: Row(
                      children: [Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                    radius: 7.0,
                    backgroundColor: Colors.purple,
                    child: Icon(Icons.close, color: Colors.white,size: 9.0,),
                    ),
                ),
                                  Container(padding: const EdgeInsets.only(left:5.0),
                                      child: Text('Remove Due Date',style: TextStyle(color: Colors.purple),)),
                      ],
                    )),
                 
                       Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                         children: [
                           Column(crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                                Container(padding: const EdgeInsets.only(left:10.0,top: 15.0),
                    child: Text('Invoice Prefix')),
                               Container(
                                                      height: 40.0,
                                                      width: 170.0,
                                                      padding: const EdgeInsets.only(left:10.0,top: 5.0),
                                                      child: TextField(  
                                                obscureText: true,  
                                               decoration: InputDecoration(  
                                               border: OutlineInputBorder(), 
                                               labelText: ' Invoice ',
                                               hintText: 'Invoice ',  
                    ),  
                  ),
                                                    ),
                             ],
                           ),
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                                Container(padding: const EdgeInsets.only(top: 15.0),
                    child: Text('Invoice Number')),
                               Container(
                                                      height: 40.0,
                                                      width: 170.0,
                                                      padding: const EdgeInsets.only(right: 10.0,top: 5.0),
                                                      child: TextField(  
                                                obscureText: true,  
                                               decoration: InputDecoration(  
                                               border: OutlineInputBorder(), 
                                               labelText: ' Number',
                                               hintText: 'Enter Number',  
                    ),  
                  ),
                                                    ),
                             ],
                           ),
                         ],
                       ),
                      Container(padding: const EdgeInsets.only(top: 15.0),
                        child: Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(padding: const EdgeInsets.only(left: 15.0,bottom: 15.0),
                              child: Row(
                                children: [
                                   Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                    radius: 7.0,
                    backgroundColor: Colors.purple,
                    child: Icon(Icons.close, color: Colors.white,size: 9.0,),
                    ),
                ),
                                  Container(padding: const EdgeInsets.only(left:5.0),
                                      child: Text('Remove Prefix',style: TextStyle(color: Colors.purple),)),
                                ],
                              )),
                              Container(padding: const EdgeInsets.only(left: 160.0,bottom: 15.0),
                                child: Text('(ex:h5,h6)'))
                          ],
                        ),
                      ),
                      Container(padding: const EdgeInsets.only(left:15.0,right: 15.0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            RaisedButton(
                onPressed: () {},
                textColor: Colors.white,
                color: Colors.purple,
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 20),
                )),
                          ],
                        ),
                      ),
                     
                    ],
                  ),
                                      ),
                                    );

                                  });
                                  
                                  },
                                    child: Container(
                                 child:Text('Edit', 
                                 style: TextStyle(
                                   color: Colors.purple,fontWeight: FontWeight.bold),),
                                ),
                              ),
                            ],
                          ),
                          Text('Due Date'),
                        ],
                      ),
                    ),
                ),
                Padding(
              padding: const EdgeInsets.only(top:15.0),
              child: Container(
                
                color: Color(0xFFECEFF1),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                          Container(
                            padding: const EdgeInsets.only(
                         left:15.0,top: 15.0,),
                            child: Text('PARTY NAME')),
                       Container( 
                         padding: const EdgeInsets.only(
                         left:15.0,right:15.0,top: 15.0,),
                    height: 60.0,
                          child: TextField(  
                    obscureText: true,  
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(), 
                      prefixIcon: Icon(Icons.person_outline),
                      labelText: ' Party Name',  
                      hintText: 'Enter Party Name',  
                    ),  
                  ),
                         ),
                         GestureDetector(
                                onTap: (){
                               
                                                
                                },
                                    child: Container(
                                  padding: const EdgeInsets.only(right: 15.0,
                         top: 15.0),
                                  child: Row(mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(Icons.add),
                                      Text('Mobile Number'),
                                     
                                    ],
                                  ),
                                ),
                              ),
                         
                       
                            Container(
                            padding: const EdgeInsets.only(top: 20.0,
                         left:15.0,),
                            child: Text('ITEMS')
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                         left:15.0,right: 15.0,bottom: 15.0),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  FlatButton(
                onPressed: () {
                  showModalBottomSheet(context: context, builder: (BuildContext context){
                                    return SingleChildScrollView(
                                    child: Container(
                                         child:  Column(
                                           children: [
                                             Container(
                                        padding: const EdgeInsets.only(
                         left:15.0,right:15.0,top: 15.0,),
                    height: 60.0,
                     child: TextField(  
                    obscureText: true,  
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(), 
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: Icon(Icons.record_voice_over),icon: Icon(Icons.arrow_back),
                      labelText: ' Search..',  
                      // hintText: 'Enter Party Name',  
                    ),  
                  ),
                  ),
                     Divider(),                    
                  Container(
                                      padding: const EdgeInsets.only(
                         left:15.0,right:15.0,top: 15.0,),
                    child: 
                    Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                         Container(
                          
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
    "Add Category",
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
              GestureDetector(
                                onTap: (){
                               
                                                
                                },
                                    child: Container(
                                 
                                  child: Row(mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(Icons.add),
                                      Text('Mobile Number'),
                                     
                                    ],
                                  ),
                                ),
                              ),
            
                      ],
                    ),
                    
                  ),
                  Divider(),
                  Container(
                     child:
                         Row(
                           children: [
                             Container(  padding: const EdgeInsets.only(
                         left:15.0,),
                               child:  ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Container(
          color: Colors.red,
          width: 50,
          height: 50,
  ),
        ), 
  ),
    
                             Container( padding: const EdgeInsets.only(
                         left:15.0,),
                               child: Column(
                       children: [
                               Text('GsT'),
                               Container(child: DropdownButton<String>(
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
    "₹ 10",
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
),),
                               Text('Stock'),

                           ],
                         ),
                             ),
                             Container(
                               padding: const EdgeInsets.only(
                         left:100.0,),
                                child:   Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    TextButton(
      child: Row(
        children: [
          Text(
            "ADD",
            style: TextStyle(color: Colors.purple)
          ),Icon(Icons.add),
        ],
      ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: Colors.purple)
          )
        )
      ),
      onPressed: () => null
    ),])
                             ),

                       ],
                     ),
                  ),

                Divider(),
                 Container(
                     child:
                         Row(
                           children: [
                             Container(  padding: const EdgeInsets.only(
                         left:15.0,),
                               child:  ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Container(
          color: Colors.red,
          width: 50,
          height: 50,
  ),
        ), 
  ),
    
                             Container( padding: const EdgeInsets.only(
                         left:15.0,),
                               child: Column(
                       children: [
                               Text('GsT'),
                               Container(child: DropdownButton<String>(
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
    "₹ 10",
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
),),
                               Text('Stock'),

                           ],
                         ),
                             ),
                             Container(
                               padding: const EdgeInsets.only(
                         left:100.0,),
                                child:   Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    TextButton(
      child: Row(
        children: [
          Text(
            "ADD",
            style: TextStyle(color: Colors.purple )
          ),Icon(Icons.add),
        ],
      ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: Colors.purple)
          )
        )
      ),
      onPressed: () => null
    ),])
                             ),

                       ],
                     ),
                  ),

                                           ])));
                                    
                   });           
                },
                textColor: Colors.purple,
                color: Colors.purple.shade50,
                child: Text(
                  'Add Items',
                  style: TextStyle(fontSize: 20),
                )),
                                ],
                              )),
                            
                            

                         
                    ],
                  ),
                
                
                ),
            ),
              ],
            ), 
        ),
        
        )

       );

        // SingleChildScrollView(
        //   child: Container(
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Padding(
        //           padding: const EdgeInsets.only(top: 60.0),
        //           child: Row(
        //             children: [
        //               Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: IconButton(
        //                     icon: Icon(Icons.arrow_back_sharp),
        //                     color: Colors.white,
        //                     onPressed: () {
        //                       Navigator.of(context).pop();
        //                     }),
        //               ),
        //               Padding(
        //                 padding: const EdgeInsets.only(left: 30.0),
        //                 child: Text(
        //                   (this.widget.name['invoice']).toString(),
        //                   style: TextStyle(
        //                       color: Colors.white,
        //                       fontWeight: FontWeight.bold,
        //                       fontSize: 20.0),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //         Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Padding(
        //                 padding: const EdgeInsets.only(left:15.0),
        //                 child: Text(
        //                   (this.widget.name['invoice']).toString(),
        //                   style: TextStyle(color: Colors.white, fontSize: 15.0),
        //                 ),
        //               ),
        //               Padding(
        //                 padding: const EdgeInsets.all(15.0),
        //                 child: Text(
        //                   (value != null) ? value : 'Pending',
        //                   style: TextStyle(color: Colors.white, fontSize: 15.0),
        //                 ),
        //               )
        //             ]),
        //         Padding(
        //           padding: const EdgeInsets.only(left:15.0),
        //           child: Text(
        //             (this.widget.name['customerName']['companyName'])
        //                 .toString(),
        //             style: TextStyle(
        //                 color: Colors.white,
        //                 fontWeight: FontWeight.bold,
        //                 fontSize: 18.0),
        //           ),
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.only(left:15.0,top: 10.0),
        //           child: Text(
        //             '₹' + (this.widget.name['totalAmount']).toString(),
        //             style: TextStyle(
        //                 color: Colors.white,
        //                 fontWeight: FontWeight.bold,
        //                 fontSize: 30.0),
        //           ),
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.only(left:15.0,bottom: 5.0),
        //           child: Text(
        //             'BALANCE',
        //             style: TextStyle(color: Colors.white, fontSize: 10.0),
        //           ),
        //         ),
        //         Container(padding: const EdgeInsets.only(top: 5.0),
        //           color: Colors.white,
        //           child: Column(
        //             children: [
        //               Padding(
        //                 padding: const EdgeInsets.all(15.0),
        //                 child: Container(
        //                   child: Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       Column(
        //                         children: [
        //                           if (this.widget.name['invoiceDate'] == null)
        //                             Text(dateFormat(
        //                                 this.widget.name['recurringstartDate']))
        //                           else
        //                             Text(dateFormat(
        //                                 this.widget.name['invoiceDate'])),
        //                           Padding(
        //                             padding: const EdgeInsets.only(right: 25.0),
        //                             child: Text(
        //                               'Invoice Date',
        //                               style: TextStyle(
        //                                   color: Colors.tealAccent.shade700,
        //                                   fontWeight: FontWeight.bold,
        //                                   fontSize: 10.0),
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                       Column(
        //                         children: [
        //                           if (this.widget.name['expiryDate'] == null)
        //                             Text(dateFormat(
        //                                 this.widget.name['recurringstartDate']))
        //                           else
        //                             Text(dateFormat(
        //                                 this.widget.name['expiryDate'])),
        //                           Padding(
        //                             padding: const EdgeInsets.only(right: 30.0),
        //                             child: Text(
        //                               'Expiry Date',
        //                               style: TextStyle(
        //                                   color: Colors.tealAccent.shade700,
        //                                   fontWeight: FontWeight.bold,
        //                                   fontSize: 10.0),
        //                             ),
        //                           )
        //                         ],
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //               Divider(),
        //               Container(padding: const EdgeInsets.only(bottom:15.0,top:15.0),
        //                 child: Padding(
        //                   padding: const EdgeInsets.only(right: 275.0),
        //                   child: Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       Text(
        //                         'Reference#',
        //                         style: TextStyle(
        //                             color: Colors.tealAccent.shade700,
        //                             fontWeight: FontWeight.bold,
        //                             fontSize: 10.0),
        //                       ),
        //                       Text((this.widget.name['reference']).toString()),
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //               Divider(),
        //               Container(
        //               padding: const EdgeInsets.only(bottom:15.0,top:15.0),
        //                   child: Column(
        //                     children: [
        //                       Padding(
        //                         padding: const EdgeInsets.only(right: 260.0),
        //                         child: Text(
        //                           'Billing Address',
        //                           style: TextStyle(
        //                               color:Colors.tealAccent.shade700,
        //                               fontWeight: FontWeight.bold,
        //                               fontSize: 10.0),
        //                         ),
        //                       ),
        //                       Padding(
        //                   padding: const EdgeInsets.only(left:15.0),
        //                         child: Text((this.widget.name['customerName']
        //                                 ['billingAddress']['Street1']) +
        //                             ', ' +
        //                             (this.widget.name['customerName']
        //                                 ['billingAddress']['Street2']) +
        //                             ', ' +
        //                             (this.widget.name['customerName']
        //                                 ['billingAddress']['attention']) +
        //                             ', ' +
        //                             (this.widget.name['customerName']
        //                                 ['billingAddress']['fax']) +
        //                             ', ' +
        //                             (this.widget.name['customerName']
        //                                 ['billingAddress']['city']) +
        //                             ', ' +
        //                             (this.widget.name['customerName']
        //                                 ['billingAddress']['state']) +
        //                             ', ' +
        //                             (this.widget.name['customerName']
        //                                 ['billingAddress']['countryRegion']) +
        //                             ', ' +
        //                             (this.widget.name['customerName']
        //                                 ['billingAddress']['phone1']) +
        //                             ', ' +
        //                             (this.widget.name['customerName']
        //                                     ['billingAddress']['zipCode'])
        //                                 .toString()),
        //                       ),
        //                     ],
        //                   ),
        //                 ),
                      
        //             Container( 
        //                     color: Color(0xFFECEFF1),
        //                     height: 40.0,
        //                     child: Row(
        //                         mainAxisAlignment:
        //                             MainAxisAlignment.spaceBetween,
        //                         children: [
        //                           Padding(
        //                             padding: const EdgeInsets.only(left:15.0),
        //                             child: Text(
        //                               'Items',
        //                               style: TextStyle(
        //                                   color: Colors.tealAccent.shade700,
        //                                   fontWeight: FontWeight.bold,
        //                                  ),
        //                             ),
        //                           ),
        //                           Padding(
        //                             padding: const EdgeInsets.only(right:15.0),
        //                             child: Text(
        //                               'Amount',
        //                               style: TextStyle(
        //                                   color: Colors.tealAccent.shade700,
        //                                   fontWeight: FontWeight.bold,
        //                                   ),
        //                             ),
        //                           ),
        //                         ]),
        //                   ),
                        
        //               for (var k = 0; k < this.widget.name['items'].length; k++)
        //                 Container(
        //                   padding: const EdgeInsets.only(left:3.0),
        //                   child: Row(
        //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                       children: [
        //                         Padding(
        //                           padding: const EdgeInsets.all(13.0),
        //                           child: Text((this.widget.name['items'][k]
        //                                   ['itemdetails'])
        //                               .toString()),
        //                         ),
        //                         Padding(
        //                           padding: const EdgeInsets.all(15.0),
        //                           child: Text('₹' +
        //                               (this.widget.name['items'][k]['amount'])
        //                                   .toString()),
        //                         ),
        //                       ]),
        //                 ),
        //               Divider(),
        //               Container(
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.end,
        //                   children: [
        //                     Padding(
        //                       padding: const EdgeInsets.only(right: 100.0),
        //                       child: Text(
        //                         'Sub Total',
        //                         style: TextStyle(
        //                             color: Colors.tealAccent.shade700,
        //                             fontWeight: FontWeight.bold,
        //                             fontSize: 15.0),
        //                       ),
        //                     ),
        //                     Padding(
        //                       padding: const EdgeInsets.all(15.0),
        //                       child: Text('₹' +
        //                           (this.widget.name['subTotal']).toString()),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //               Divider(),
        //               Container(
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.end,
        //                   children: [
        //                     Padding(
        //                       padding: const EdgeInsets.only(right: 100.0),
        //                       child: Text(
        //                         'Total',
        //                         style: TextStyle(
        //                             color: Colors.tealAccent.shade700,
        //                             fontWeight: FontWeight.bold,
        //                             fontSize: 15.0),
        //                       ),
        //                     ),
        //                     Padding(
        //                       padding: const EdgeInsets.all(15.0),
        //                       child: Text('₹' +
        //                           (this.widget.name['totalAmount']).toString()),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
       // )
        
  
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
