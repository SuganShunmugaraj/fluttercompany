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
  dynamic amount;
  Map addEdit = {};
  Map addTotalEdit = {};

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
      'quantity': 0,
      'name': items['serviceName'],
      'rate': items['serviceSaleSellingPrice'],
      'discount': 0,
      'percentage': 0
    };

    setState(() {
      selectedItems.add(mockItem);
    });
    int index = selectedItems.indexWhere((element) {
      return element['itemdetails'] == items['_id'];
    });

    if (index >= 0) {
      print('inside');
      setState(() {
        selectedItems[index]['quantity'] += 1;
      });
    } else {
      print('out');
      setState(() {
        selectedItems.add(mockItem);
      });
    }
    // print('----2----');
    // print(selectedItems);
    // print('----2----');
    getTotal();
  }

  getTotal() {
    var total = 0;

    selectedItems.forEach((element) {
      print(int.parse(element['rate']) );
      print(element['quantity'] );

      total += int.parse(element['rate']) *  element['quantity'];
    });
    setState(() {
      amount = total;
    });

    print('----3----'); 
    print(amount); 

    print('----3----');
  }

  editTotalItems() {
    setState(() {
      this.addTotalEdit = {
        'adjust': "",
        'adjustValue': 0,
        'amountPaid': 0,
        'customerId': "",
        'customerName': "60b330832b24111e58827185",
        'customerNotes': "",
        'customrepeat': "",
        'expiryDate': addEdit['expiryDate'],
        'files': [],
        'invoice': addEdit['invoice'],
        'invoiceDate': addEdit['invoiceDate'],
        'items': this.selectedItems,
        'paymentterm': "",
        'projectName': null,
        'recurringagreed': null,
        'recurringendDate': null,
        'recurringstartDate': null,
        'reference': "7878",
        'repeat': "",
        'salesPerson': null,
        'status': "Draft",
        'subTotal': 56780,
        'subject': addEdit['subject'],
        'terms': "",
        'total': "",
        'totalAmount': 56780,
        'totalwords': "fifty six thousand seven hundred and eighty rupee",
      };
      print('......................');
      print(addTotalEdit);
    });
  }

  editItems(expiryDate, invoiceDate, invoice, subject) async {
    setState(() {
      this.addEdit = {
        'expiryDate': expiryDate,
        'invoiceDate': invoiceDate,
        'invoice': invoice,
        'subject': subject
      };
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

  final expiryDate = TextEditingController();
  final invoiceDate = TextEditingController();
  final invoice = TextEditingController();
  final subject = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white, // Color for Android
        statusBarBrightness:
            Brightness.dark // Dark == white status bar -- for IOS.
        ));
    return Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   title: Text(
        //     'Create Bill/ Invoice',
        //     style: TextStyle(color: Colors.black),
        //   ),
        //   leading: Icon(
        //     Icons.arrow_back,
        //     color: Colors.black,
        //   ),
        //   actions: [
        //     Padding(
        //       padding: const EdgeInsets.only(right: 15.0),
        //       child: Icon(
        //         Icons.save,
        //         color: Colors.black,
        //       ),
        //     )
        //   ],
        // ),

        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(
              top: 20.0,
            ),
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.tealAccent.shade700,
                          ),
                          onPressed: () {}),
                      Text(
                        'Edit Bill/ Invoice',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Invoice #H5',
                            style: TextStyle(color: Colors.tealAccent.shade700),
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SingleChildScrollView(
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Text(
                                                  'Edit Invoice Date & Number',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                            Container(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0),
                                                child: Text('Invoice Date')),
                                            Container(
                                              height: 40.0,
                                              padding: const EdgeInsets.only(
                                                  left: 15.0,
                                                  right: 15.0,
                                                  top: 5.0),
                                              child: TextField(
                                                controller: expiryDate,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  suffixIcon: IconButton(
                                                      icon: Icon(Icons
                                                          .calendar_today_outlined),
                                                      onPressed: () {
                                                        showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime(2015, 8),
                                                          lastDate:
                                                              DateTime(2101),
                                                        );
                                                      }),
                                                  labelText: ' Invoice Date',
                                                  hintText:
                                                      'Enter Invoice Date',
                                                ),
                                              ),
                                            ),
                                            Container(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0, top: 15.0),
                                                child: Text('Due Date')),
                                            Container(
                                              height: 40.0,
                                              padding: const EdgeInsets.only(
                                                  left: 15.0,
                                                  right: 15.0,
                                                  top: 5.0),
                                              child: TextField(
                                                controller: invoiceDate,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  suffixIcon: IconButton(
                                                      icon: Icon(Icons
                                                          .calendar_today_outlined),
                                                      onPressed: () {
                                                        showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime(2015, 8),
                                                          lastDate:
                                                              DateTime(2101),
                                                        );
                                                      }),
                                                  labelText: ' Due Date',
                                                  hintText: 'Enter Due Date',
                                                ),
                                              ),
                                            ),
                                            Container(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0, top: 15.0),
                                                child: Row(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: CircleAvatar(
                                                        radius: 7.0,
                                                        backgroundColor:
                                                            Colors.purple,
                                                        child: Icon(
                                                          Icons.close,
                                                          color: Colors.white,
                                                          size: 9.0,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 5.0),
                                                        child: Text(
                                                          'Remove Due Date',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .purple),
                                                        )),
                                                  ],
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
                                                            'Invoice Number')),
                                                    Container(
                                                      height: 40.0,
                                                      width: 340.0,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5.0,
                                                              top: 5.0,
                                                              right: 5.0),
                                                      child: TextField(
                                                        controller: invoice,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          labelText: ' Number',
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
                                                                left: 5.0,
                                                                top: 15.0),
                                                        child: Text('Subject')),
                                                    Container(
                                                      height: 40.0,
                                                      width: 340.0,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5.0,
                                                              top: 5.0,
                                                              right: 5.0),
                                                      child: TextField(
                                                        controller: subject,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          labelText: ' Subject',
                                                          hintText:
                                                              'Enter Subject',
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
                                                          const EdgeInsets.only(
                                                              left: 15.0,
                                                              bottom: 15.0),
                                                      child: Row(
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: CircleAvatar(
                                                              radius: 7.0,
                                                              backgroundColor:
                                                                  Colors.purple,
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
                                                          const EdgeInsets.only(
                                                              left: 160.0,
                                                              bottom: 15.0),
                                                      child: Text('(ex:h5,h6)'))
                                                ],
                                              ),
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
                                                        editItems(
                                                            expiryDate.text,
                                                            invoiceDate.text,
                                                            invoice.text,
                                                            subject.text);

                                                        editTotalItems();
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
                                    color: Colors.tealAccent.shade700,
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
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
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
                          padding: const EdgeInsets.only(
                            top: 15.0,
                          ),
                          child: Center(
                            child: Container(
                                padding: const EdgeInsets.only(
                                  left: 15.0,
                                ),
                                height: 40.0,
                                width: 330.0,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.person_outline),
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        dropdownColor:
                                            Colors.tealAccent.shade700,
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
                                        onChanged: (value) {},
                                        hint: Text(this.drop.toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                            )),
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),

                        // GestureDetector(

                        //   onTap: () {},
                        //   child: Container(
                        //     padding:
                        //         const EdgeInsets.only(right: 15.0, top: 15.0),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.end,
                        //       children: [
                        //         Icon(Icons.add),
                        //         Text('Mobile Number'),
                        //       ],
                        //     ),
                        //   ),
                        // ),

                        selectedItems.length > 0
                            ? Container(
                                padding: const EdgeInsets.only(
                                  top: 20.0,
                                  left: 15.0,
                                ),
                                child: Column(children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('ITEMS'),
                                      GestureDetector(
                                        onTap: () {
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0,
                                                  right: 15.0,
                                                  bottom: 15.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  FlatButton(
                                                      onPressed: () {
                                                        showModalBottomSheet(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return ListView
                                                                  .separated(
                                                                      itemCount:
                                                                          items
                                                                              .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return SingleChildScrollView(
                                                                            child: Container(
                                                                                child: Column(children: [
                                                                          Container(
                                                                            padding:
                                                                                const EdgeInsets.only(
                                                                              left: 15.0,
                                                                              right: 15.0,
                                                                              top: 15.0,
                                                                            ),
                                                                            height:
                                                                                60.0,
                                                                            child:
                                                                                TextField(
                                                                              obscureText: true,
                                                                              decoration: InputDecoration(
                                                                                border: OutlineInputBorder(),
                                                                                prefixIcon: Icon(Icons.search),
                                                                                suffixIcon: Icon(Icons.record_voice_over),
                                                                                icon: Icon(Icons.arrow_back),
                                                                                labelText: ' Search..',
                                                                                // hintText: 'Enter Party Name',
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Divider(),
                                                                          Container(
                                                                            padding:
                                                                                const EdgeInsets.only(
                                                                              left: 15.0,
                                                                              right: 15.0,
                                                                              top: 15.0,
                                                                            ),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                                                          Container(
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Container(
                                                                                  padding: const EdgeInsets.only(
                                                                                    left: 15.0,
                                                                                  ),
                                                                                  child: ClipRRect(
                                                                                    borderRadius: BorderRadius.circular(5.0),
                                                                                    child: Container(
                                                                                      color: Colors.red,
                                                                                      width: 50,
                                                                                      height: 50,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  padding: const EdgeInsets.only(
                                                                                    left: 15.0,
                                                                                  ),
                                                                                  child: Column(
                                                                                    children: [
                                                                                      Text(this.items[index]['serviceName']),
                                                                                      Text(this.items[index]['serviceSaleSellingPrice']),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                    padding: const EdgeInsets.only(
                                                                                      left: 50.0,
                                                                                    ),
                                                                                    child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                                                                      TextButton(
                                                                                          child: Row(
                                                                                            children: [
                                                                                              Text("ADD", style: TextStyle(color: Colors.purple)),
                                                                                              Icon(Icons.add),
                                                                                            ],
                                                                                          ),
                                                                                          style: ButtonStyle(padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)), foregroundColor: MaterialStateProperty.all<Color>(Colors.red), shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: Colors.purple)))),
                                                                                          onPressed: () => {setSelectedItems(this.items[index])}),
                                                                                    ])),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ])));
                                                                      },
                                                                      separatorBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return Divider();
                                                                      });
                                                            });
                                                      },
                                                      textColor: Colors.purple,
                                                      color:
                                                          Colors.purple.shade50,
                                                      child: Text(
                                                        'Add Items',
                                                        style: TextStyle(
                                                            fontSize: 20),
                                                      )),
                                                ],
                                              ));
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                            right: 15.0,
                                            top: 15.0,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Icon(
                                                Icons.add,
                                                color:
                                                    Colors.tealAccent.shade700,
                                              ),
                                              Text(
                                                'Items',
                                                style: TextStyle(
                                                    color: Colors
                                                        .tealAccent.shade700),
                                              ),
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
                                        itemBuilder:
                                            (BuildContext ctxt, int index) {
                                          var name =
                                              selectedItems[index]['name'];
                                          var rate =
                                              selectedItems[index]['rate'];
                                          var quantity =
                                              selectedItems[index]['quantity'];
                                          var totalAmounts =
                                              int.parse(rate) * quantity;
                                          return Container(
                                            padding: const EdgeInsets.only(
                                                right: 15.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(name),
                                                          Text(rate +
                                                              ' x ' +
                                                              quantity
                                                                  .toString()),
                                                        ],
                                                      ),
                                                      Text(totalAmounts
                                                          .toString()),
                                                    ]),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('Sub Total'),
                                                      Text(amount.toString()),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return Divider();
                                        }),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          right: 15.0, top: 100.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                bottom: 20.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Total Amount'),
                                                Text(amount.toString()),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 165.0,
                                            child: RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  //  borderRadius: BorderRadius.circular(28.0),
                                                  ),
                                              onPressed: () {},
                                              child: Row(
                                                children: [
                                                  Container(
                                                      child: Text(
                                                    ' Generate Bill',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18.0),
                                                  ))
                                                ],
                                              ),
                                              color: Colors.tealAccent.shade700,
                                              //elevation: 0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                              )
                            : Container(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15.0, bottom: 15.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    FlatButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 15.0,
                                                              left: 15.0,
                                                              right: 15.0),
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
                                                          icon: Icon(
                                                              Icons.arrow_back),
                                                          labelText:
                                                              ' Search..',
                                                          // hintText: 'Enter Party Name',
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                        child:
                                                            ListView.separated(
                                                                itemCount: items
                                                                    .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  return Container(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            15.0,
                                                                        top:
                                                                            15.0),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(5.0),
                                                                          child:
                                                                              Container(
                                                                            color:
                                                                                Colors.red,
                                                                            width:
                                                                                50,
                                                                            height:
                                                                                50,
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          padding:
                                                                              const EdgeInsets.only(
                                                                            right:
                                                                                90.0,
                                                                          ),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(this.items[index]['serviceName']),
                                                                              Text(this.items[index]['serviceSaleSellingPrice']),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          padding:
                                                                              const EdgeInsets.only(
                                                                            right:
                                                                                15.0,
                                                                          ),
                                                                          child: TextButton(
                                                                              child: Row(
                                                                                children: [
                                                                                  Text("ADD", style: TextStyle(color: Colors.purple)),
                                                                                  Icon(Icons.add),
                                                                                ],
                                                                              ),
                                                                              style: ButtonStyle(padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)), foregroundColor: MaterialStateProperty.all<Color>(Colors.red), shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: Colors.purple)))),
                                                                              onPressed: () => {
                                                                                    setSelectedItems(this.items[index]),
                                                                                  
                                                                                  }),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                                separatorBuilder:
                                                                    (context,
                                                                        index) {
                                                                  return Divider();
                                                                }))
                                                  ],
                                                );
                                              });
                                        },
                                        textColor: Colors.white,
                                        color: Colors.tealAccent.shade700,
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
