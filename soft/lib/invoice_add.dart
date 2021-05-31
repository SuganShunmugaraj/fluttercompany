import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:soft/config/upload_url.dart';

class InvoiceAdd extends StatefulWidget {
  @override
  _InvoiceAddState createState() => _InvoiceAddState();
}

class _InvoiceAddState extends State<InvoiceAdd> {
  List customer = [];
  List items;
  List selectedItems = [];
  int totalAmount ;
  //Map addStorage;
  List addEdit=[];

  Future getCustomerData() async {
    var response = await http.get(Uri.parse(BaseUrl.contacts),
        headers: {"Accept": "application/json"});
    this.setState(() {
      var customerData = json.decode(response.body);
      customer = customerData['data'];
    });
  }

  getItems() async {
    var response = await http.get(Uri.parse(BaseUrl.service),
        headers: {"Accept": "application/json"});
    this.setState(() {
      var itemsList = json.decode(response.body);
      items = itemsList['data'];
    });
  }

  setSelectedItems(items) {
    var mockItem = {
      'itemdetails': items['_id'],
      'quantity': 1,
      'name': items['serviceName'],
      'rate': items['serviceSaleSellingPrice'],
      'discount': 0,
      'percentage': 0
    };

    
    int index = this.selectedItems.indexWhere((element) {
      return element['itemdetails'] == items['_id'];
    });

    if (index >= 0) {
         setState(() {
      this.selectedItems[index]['quantity'] += 1;
         });
    } else {
      setState(() {
        this.selectedItems.add(mockItem);
      });
    }
print(selectedItems[index]['quantity'] );
   getTotal();
  }
  
  getTotal(){
    var total = 0;
    selectedItems.forEach((element) {
      total += element['rate']*element['quantity'];
      
    });
 print(total);
 setState(() {
    totalAmount = total;
   });
    
  }


  editItems(expiryDate,invoiceDate,invoice, subject) async{
    print(expiryDate);
    print('.............');
    print(invoiceDate);
    print('////////////////////');
    print(invoice);  print('.............');
    print(subject);  print('.............');
    setState(() {
      final addStorage = {
        'expiryDate': expiryDate,
        'invoiceDate': invoiceDate,
        'invoice': invoice,
        'subject': subject
      };
      addEdit.add(addStorage);
      print(addEdit);
      print('.............................');
    });
     
  }

  @override
  void initState() {
    super.initState();
    getCustomerData();
    getItems();
   
  }

  String _chosenValue;
  String drop = 'Customer Name';

  final expiryDate =TextEditingController();
  final invoiceDate =TextEditingController();
  final invoice =TextEditingController();
  final subject =TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.purple.shade50, // Color for Android
        statusBarBrightness:
            Brightness.dark // Dark == white status bar -- for IOS.
        ));
    return Scaffold(
        backgroundColor: Colors.purple.shade50,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Create Bill/ Invoice',
            style: TextStyle(color: Colors.black),
          ),
          leading: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(
                Icons.save,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Container(
                    color: Color(0xFFECEFF1),
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Invoice #H5'),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SingleChildScrollView(
                                        child: new Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Text(
                                                    'Edit Invoice Date & Number',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0),
                                                  child: Text('Invoice Date')),
                                              Container(
                                                height: 40.0,
                                                padding: const EdgeInsets.only(
                                                    left: 15.0,
                                                    right: 15.0,
                                                    top: 5.0),
                                                child: TextField(
                                                  obscureText: true,
                                                   controller: expiryDate,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    suffixIcon: IconButton(
                                                      icon: Icon(Icons.calendar_today_outlined), 
                                                      onPressed: (){
                                                    
                                                        showDatePicker(
                                                           context: context,
                                                            initialDate: DateTime.now(),
                                                             firstDate: DateTime(2015, 8),
                                                             lastDate: DateTime(2101),
                                                              );
        
                                                    }),
                                                    
                                                    labelText: ' Invoice Date',
                                                    hintText: 'Enter Invoice Date',
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                  padding:
                                                      const EdgeInsets.only(left: 15.0,top: 15.0),
                                                  child: Text('Due Date')),
                                              Container(
                                                height: 40.0,
                                                padding: const EdgeInsets.only(
                                                    left: 15.0,
                                                    right: 15.0,
                                                    top: 5.0),
                                                child: TextField(
                                                  obscureText: true,
                                                  controller: invoice,
                                                  decoration: InputDecoration(
                                                    border:OutlineInputBorder(),
                                                    suffixIcon: IconButton(
                                                      icon: Icon(Icons.calendar_today_outlined), 
                                                      onPressed: (){
                                                    
                                                        showDatePicker(
                                                           context: context,
                                                            initialDate: DateTime.now(),
                                                             firstDate: DateTime(2015, 8),
                                                             lastDate: DateTime(2101),
                                                              );
        
                                                    }),
                                                    labelText: ' Due Date',
                                                    hintText: 'Enter Due Date',
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0,
                                                          top: 15.0),
                                                  child: Row(
                                                    children: [
                                                      Align(alignment:Alignment.center,
                                                        child: CircleAvatar(
                                                          radius: 7.0,
                                                          backgroundColor:Colors.purple,
                                                          child: Icon(Icons.close,
                                                            color: Colors.white,
                                                            size: 9.0,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                          padding:const EdgeInsets.only(left: 5.0),
                                                          child: Text(
                                                            'Remove Due Date',
                                                            style: TextStyle(
                                                                color: Colors.purple),
                                                          )),
                                                    ],
                                                  )),
                                              Row(
                                                mainAxisAlignment:MainAxisAlignment.spaceAround,
                                                children: [
                                                 
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                          padding:const EdgeInsets.only(top: 15.0),
                                                          child: Text('Invoice Number')),
                                                      Container(
                                                        height: 40.0,
                                                       width: 340.0,
                                                        padding:const EdgeInsets.only(left: 5.0,top: 5.0,right: 5.0),
                                                        child: TextField(
                                                         
                                                          controller: invoiceDate,
                                                          decoration:InputDecoration(
                                                            border:OutlineInputBorder(),
                                                            labelText:
                                                                ' Number',
                                                            hintText:
                                                                'Enter Number',
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                               Row(
                                                mainAxisAlignment:MainAxisAlignment.spaceAround,
                                                children: [
                                                 
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                          padding:const EdgeInsets.only(top: 15.0),
                                                          child: Text('Subject')),
                                                      Container(
                                                        height: 40.0,
                                                       width: 340.0,
                                                        padding:const EdgeInsets.only(left: 5.0,top: 5.0,right: 5.0),
                                                        child: TextField(
                                                         
                                                          controller: subject,
                                                          decoration:InputDecoration(
                                                            border:OutlineInputBorder(),
                                                            labelText:' Subject',
                                                            hintText:'Enter Subject',
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    top: 15.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 15.0,
                                                                bottom: 15.0),
                                                        child: Row(
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child:
                                                                  CircleAvatar(
                                                                radius: 7.0,
                                                                backgroundColor:
                                                                    Colors
                                                                        .purple,
                                                                child: Icon(
                                                                  Icons.close,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 9.0,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            5.0),
                                                                child: Text(
                                                                  'Remove Prefix',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .purple),
                                                                )),
                                                          ],
                                                        )),
                                                    Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 160.0,
                                                                bottom: 15.0),
                                                        child:
                                                            Text('(ex:h5,h6)'))
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0, right: 15.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    RaisedButton(
                                                        onPressed: () {
                                                          editItems(
                                                            expiryDate.text,
                                                            invoiceDate.text,
                                                            invoice.text,  
                                                            subject.text
                                                            );

                                                        },
                                                        textColor: Colors.white,
                                                        color: Colors.purple,
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
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                child: Text(
                                  'Edit',
                                  style: TextStyle(
                                      color: Colors.purple,
                                      fontWeight: FontWeight.bold),
                                ),
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
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    color: Color(0xFFECEFF1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: const EdgeInsets.only(
                              left: 15.0,
                              top: 15.0,
                            ),
                            child: Text('PARTY NAME')),
                        Container(
                          child: DropdownButton(
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
                                    fontSize: 20.0,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {},
                            hint: Text(this.drop.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                )),
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        //      Container(
                        //        padding: const EdgeInsets.only(
                        //        left:15.0,right:15.0,top: 15.0,),
                        //   height: 60.0,
                        //         child: TextField(
                        //   obscureText: true,
                        //   decoration: InputDecoration(
                        //     border: OutlineInputBorder(),
                        //     prefixIcon: Icon(Icons.person_outline),
                        //     labelText: ' Party Name',
                        //     hintText: 'Enter Party Name',
                        //   ),
                        // ),
                        //        ),

                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding:
                                const EdgeInsets.only(right: 15.0, top: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.add),
                                Text('Mobile Number'),
                              ],
                            ),
                          ),
                        ),
selectedItems.length > 0 ? Container(
                          padding: const EdgeInsets.only(
                            top: 20.0,
                            left: 15.0,
                          ),
                          child: Column(
                            children: [
                              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text('Items'),
                                 GestureDetector(
                          onTap: () {
                          
                            Container(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15.0, bottom: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                FlatButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ListView.separated(
                                                itemCount: items.length,
                                                itemBuilder: (context, index) {
                                                  return SingleChildScrollView(
                                                      child: Container(
                                                          child: Column(
                                                              children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 15.0,
                                                            right: 15.0,
                                                            top: 15.0,
                                                          ),
                                                          height: 60.0,
                                                          child: TextField(
                                                            obscureText: true,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              prefixIcon: Icon(
                                                                  Icons.search),
                                                              suffixIcon: Icon(Icons
                                                                  .record_voice_over),
                                                              icon: Icon(Icons
                                                                  .arrow_back),
                                                              labelText:
                                                                  ' Search..',
                                                              // hintText: 'Enter Party Name',
                                                            ),
                                                          ),
                                                        ),
                                                        Divider(),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 15.0,
                                                            right: 15.0,
                                                            top: 15.0,
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
//                          Container(

//                            child: DropdownButton<String>(
//   focusColor:Colors.white,
//   value: _chosenValue,
//   //elevation: 5,
//   style: TextStyle(color: Colors.blue),
//   iconEnabledColor:Colors.black,
//   items: <String>[
//     'Android',
//     'IOS',
//     'Flutter',
//     'Node',
//     'Java',
//     'Python',
//     'PHP',
//   ].map<DropdownMenuItem<String>>((String value) {
//     return DropdownMenuItem<String>(
//       value: value,
//       child: Text(value,style:TextStyle(color:Colors.black),),
//     );
//   }).toList(),
//   hint:Text(
//     "Add Category",
//     style: TextStyle(
//         color: Colors.black,
//         fontSize: 14,
//         fontWeight: FontWeight.w500),
//   ),
//   onChanged: (String value) {
//     setState(() {
//       _chosenValue = value;
//     });
//   },
// ),
//                          ),

//               GestureDetector(
//                                 onTap: (){

//                                 },
//                                     child: Container(

//                                   child: Row(mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       Icon(Icons.add),
//                                       Text('Mobile Number'),

//                                     ],
//                                   ),
//                                 ),
//                               ),
                                                            ],
                                                          ),
                                                        ),
                                                        Divider(),
                                                        Container(
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  left: 15.0,
                                                                ),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5.0),
                                                                  child:
                                                                      Container(
                                                                    color: Colors
                                                                        .red,
                                                                    width: 50,
                                                                    height: 50,
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  left: 15.0,
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    Text('Name :' +
                                                                        this.items[index]
                                                                            [
                                                                            'serviceName']),
                                                                    Text('price : ' +
                                                                        this.items[index]
                                                                            [
                                                                            'serviceSaleSellingPrice']),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                    left: 50.0,
                                                                  ),
                                                                  child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        TextButton(
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Text("ADD", style: TextStyle(color: Colors.purple)),
                                                                                Icon(Icons.add),
                                                                              ],
                                                                            ),
                                                                            style: ButtonStyle(
                                                                                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                                                                                foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: Colors.purple)))),
                                                                            onPressed: () => {setSelectedItems(this.items[index])}),
                                                                      ])),
                                                            ],
                                                          ),
                                                        ),
                                                      ])));
                                                },
                                                separatorBuilder:
                                                    (context, index) {
                                                  return Divider();
                                                });
                                          });
                                    },
                                    textColor: Colors.purple,
                                    color: Colors.purple.shade50,
                                    child: Text(
                                      'Add Items',
                                      style: TextStyle(fontSize: 20),
                                    )),
                              ],
                            ));
                       
                          },
                          child: Container(
                            padding:
                                const EdgeInsets.only(right: 15.0, top: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.add),
                                Text('Add More Items'),
                              ],
                            ),
                          ),
                        ),
                                ],
                              ),
                            SizedBox(
                            height: 200.0,
                              child: new ListView.separated(
                                scrollDirection: Axis.vertical,
                                itemCount: this.selectedItems.length,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                          Text(selectedItems[index]['name']),
                          Text(selectedItems[index]['rate'] * Text(selectedItems[index]['quantity']))
                                 
                                    ],
                                  );
                                },separatorBuilder: (context, index) {
                                      return Divider();
                                }),
                            ),
                          ]),
                        ) : 
                      Container(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15.0, bottom: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                FlatButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ListView.separated(
                                                itemCount: items.length,
                                                itemBuilder: (context, index) {
                                                  return SingleChildScrollView(
                                                      child: Container(
                                                          child: Column(
                                                              children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 15.0,
                                                            right: 15.0,
                                                            top: 15.0,
                                                          ),
                                                          height: 60.0,
                                                          child: TextField(
                                                            obscureText: true,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              prefixIcon: Icon(
                                                                  Icons.search),
                                                              suffixIcon: Icon(Icons
                                                                  .record_voice_over),
                                                              icon: Icon(Icons
                                                                  .arrow_back),
                                                              labelText:
                                                                  ' Search..',
                                                              // hintText: 'Enter Party Name',
                                                            ),
                                                          ),
                                                        ),
                                                        Divider(),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 15.0,
                                                            right: 15.0,
                                                            top: 15.0,
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
//                          Container(

//                            child: DropdownButton<String>(
//   focusColor:Colors.white,
//   value: _chosenValue,
//   //elevation: 5,
//   style: TextStyle(color: Colors.blue),
//   iconEnabledColor:Colors.black,
//   items: <String>[
//     'Android',
//     'IOS',
//     'Flutter',
//     'Node',
//     'Java',
//     'Python',
//     'PHP',
//   ].map<DropdownMenuItem<String>>((String value) {
//     return DropdownMenuItem<String>(
//       value: value,
//       child: Text(value,style:TextStyle(color:Colors.black),),
//     );
//   }).toList(),
//   hint:Text(
//     "Add Category",
//     style: TextStyle(
//         color: Colors.black,
//         fontSize: 14,
//         fontWeight: FontWeight.w500),
//   ),
//   onChanged: (String value) {
//     setState(() {
//       _chosenValue = value;
//     });
//   },
// ),
//                          ),

//               GestureDetector(
//                                 onTap: (){

//                                 },
//                                     child: Container(

//                                   child: Row(mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       Icon(Icons.add),
//                                       Text('Mobile Number'),

//                                     ],
//                                   ),
//                                 ),
//                               ),
                                                            ],
                                                          ),
                                                        ),
                                                        Divider(),
                                                        Container(
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  left: 15.0,
                                                                ),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5.0),
                                                                  child:
                                                                      Container(
                                                                    color: Colors
                                                                        .red,
                                                                    width: 50,
                                                                    height: 50,
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  left: 15.0,
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    Text('Name :' +
                                                                        this.items[index]
                                                                            [
                                                                            'serviceName']),
                                                                    Text('price : ' +
                                                                        this.items[index]
                                                                            [
                                                                            'serviceSaleSellingPrice']),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                    left: 50.0,
                                                                  ),
                                                                  child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        TextButton(
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Text("ADD", style: TextStyle(color: Colors.purple)),
                                                                                Icon(Icons.add),
                                                                              ],
                                                                            ),
                                                                            style: ButtonStyle(
                                                                                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                                                                                foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: Colors.purple)))),
                                                                            onPressed: () => {setSelectedItems(this.items[index])}),
                                                                      ])),
                                                            ],
                                                          ),
                                                        ),
                                                      ])));
                                                },
                                                separatorBuilder:
                                                    (context, index) {
                                                  return Divider();
                                                });
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
                       
                          //getTotal()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
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
