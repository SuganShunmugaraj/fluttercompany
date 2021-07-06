import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:soft/config/upload_url.dart';

class InvoiceAdd extends StatefulWidget {
  InvoiceAdd({
    this.prod,
  });

  final Map prod;
  @override
  _InvoiceAddState createState() => _InvoiceAddState();
}

class _InvoiceAddState extends State<InvoiceAdd> {
  List customer = [];
  List items = [];
  List selectedItems = [];
  dynamic amount;
  dynamic test = 2;
  Map addEdit = {};
  Map addTotalEdit = {};
  String pageType;

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
      if (this.widget.prod != null) {
        var editSelectedItems = this.widget.prod['items'];
        List selectedData;
        itemsList['data'].forEach((datas) => {
              selectedData = editSelectedItems
                  .where((item) => item['itemdetails'] == datas['_id'])
                  .toList(),
              if (selectedData.length > 0)
                {datas['quantity'] = selectedData[0]['quantity']}
              else
                {
                  datas['quantity'] = 0,
                },
              items.add(datas)
            });
      }else{
           itemsList['data'].forEach((datas) => {
              datas['quantity'] = 0,
              items.add(datas)
            });
      }
    });
  }

  setSubtract(items) {
    int index = selectedItems.indexWhere((element) {
      return element['itemdetails'] == items['_id'];
    });
    if (index >= 0) {
      setState(() {
        selectedItems[index]['quantity'] -= 1;
      });
    }
    getTotal();
  }

  setSelectedItems(items) {
    var mockItem = {
      'itemdetails': items['_id'],
      'quantity': 1,
      'itemName': items['serviceName'],
      'rate': items['serviceSaleSellingPrice'],
      'discount': 0,
      'percentage': 0
    };
    int index = selectedItems.indexWhere((element) {
      return element['itemdetails'] == items['_id'];
    });

    if (index >= 0) {
      setState(() {
        selectedItems[index]['quantity'] += 1;
      });
    } else {
      setState(() {
        selectedItems.add(mockItem);
      });
    }
    getTotal();
  }

  getTotal() {
    var total = 0;
    selectedItems.forEach((element) {
      total += int.parse(element['rate']) * element['quantity'];
    });
    amount = total;
  }

  editTotalItems() {
    setState(() {
      this.addTotalEdit = {
        'adjust': "",
        'adjustValue': 0,
        'amountPaid': 0,
        'customerId': "",
        'customerName': invoiceDropDownId,
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
    });
  }

  onGenerateBill() async {
    Map billMockup = {
      "customerName": invoiceDropDownId,
      "customerId": "",
      "invoice": this.editInvoice['number'],
      "reference": "1234",
      "status": "Draft",
      "invoiceDate": this.editInvoice['startDate'],
      "expiryDate": this.editInvoice['endDate'],
      "recurringstartDate": null,
      "recurringendDate": null,
      "salesPerson": null,
      "projectName": null,
      "subject": "hiii inviove",
      "items": this.selectedItems,
      "totalAmount": amount,
      "customerNotes": "",
      "terms": "",
      "subTotal": amount,
      "total": "",
      "totalwords": "",
      "adjust": "",
      "recurringagreed": null,
      "repeat": "",
      "paymentterm": "",
      "customrepeat": "",
      "amountPaid": 0,
      "adjustValue": 0,
      "files": []
    };
    if (this.pageType == 'EDIT') {
      billMockup['_id'] = this.widget.prod['_id'];
      billMockup['customerName'] = this.widget.prod['customerName'];
      final response = await http.put(
          Uri.parse(BaseUrl.addInvoice + this.widget.prod['_id']),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode(billMockup));
      var res = response.body;
      if (response.statusCode == 200) {
        print('sucess');
      } else {
        print("Error :" + res);
      }
    } else if (this.pageType == 'CREATE') {
      print(billMockup);
      final response = await http.post(Uri.parse(BaseUrl.addInvoice),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode(billMockup));
      var res = response.body;
      if (response.statusCode == 200) {
        print('sucess create');
      } else {
        print("Error :" + res);
      }
    }
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

  Map editInvoice = {
    'startDate': dateFormat(DateTime.now()).toString(),
    'endDate': dateFormat(DateTime(2021, 06, 25)).toString(),
    'number': 'INV0123',
    'subject': 'Invoice Subject',
  };
  addItems() {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: Icon(Icons.record_voice_over),
                      icon: Icon(Icons.arrow_back),
                      labelText: ' Search..',
                    ),
                  ),
                ),
                Expanded(
                    child: ListView.separated(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                color: Colors.white,
                                child: ListTile(
                                  title: Container(
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          child: Container(
                                            color: Colors.tealAccent.shade700,
                                            width: 50,
                                            height: 50,
                                            child: Center(
                                                child: Text(
                                              '${this.items[index]['serviceName'].substring(0, 1)}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30.0,
                                                  color: Colors.white),
                                            )),
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(this.items[index]
                                                  ['serviceName']),
                                              Text(this.items[index]
                                                  ['serviceSaleSellingPrice']),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 250.0, right: 15.0, top: 15.0),
                                child: Align(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 20.0, top: 5.0, bottom: 5.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.tealAccent.shade700),
                                    child: Row(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              if (this.items[index]
                                                      ['quantity'] !=
                                                  0)
                                                setState(() {
                                                  this.items[index]
                                                      ['quantity'] -= 1;
                                                  setSubtract(
                                                      this.items[index]);
                                                });
                                            },
                                            child: Icon(
                                              Icons.remove,
                                              color: Colors.white,
                                              size: 16,
                                            )),
                                        Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 3),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 3, vertical: 2),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                color: Colors.white),
                                            child: Text(this
                                                .items[index]['quantity']
                                                .toString())),
                                        InkWell(
                                            onTap: () {
                                              setState(() {
                                                this.items[index]['quantity'] +=
                                                    1;
                                                //  this.test += 1;
                                                //  print(this.test);
                                                setSelectedItems(
                                                    this.items[index]);
                                              });
                                            },
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 16,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider();
                        }))
              ],
            );
          });
        });
  }

  heading() {
    if (this.widget.prod != null) {
      return 'Edit Bill/ Invoice';
    } else {
      return 'Create Bill/ Invoice';
    }
  }

  @override
  void initState() {
    super.initState();
    getItems();
    getCustomerData();
    setState(() {
      if (this.widget.prod != null) {
        this.pageType = 'EDIT';
        this.invoiceDropDownName = this
            .widget
            .prod['customerName']['userName']['firstName']
            .toString();
        this.editInvoice['number'] = this.widget.prod['invoice'];
        this.editInvoice['startDate'] =
            dateFormat(this.widget.prod['invoiceDate']);
        this.editInvoice['endDate'] =
            dateFormat(this.widget.prod['expiryDate']);
        this.selectedItems = this.widget.prod['items'];
        amount = this.widget.prod['totalAmount'];
        amount = this.widget.prod['subTotal'];
      } else {
        this.pageType = 'CREATE';
      }
    });

    invoiceDate.text = this.editInvoice['startDate'];
    expiryDate.text = this.editInvoice['endDate'];
    invoice.text = this.editInvoice['number'];
    subject.text = this.editInvoice['subject'];
  }

  String invoiceDropDownName = 'Customer Name';
  String invoiceDropDownId = 'Customer Name';

  final invoiceDate = TextEditingController();
  final expiryDate = TextEditingController();
  final invoice = TextEditingController();
  final subject = TextEditingController();
  final counter = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white, statusBarBrightness: Brightness.dark));
    return Scaffold(
        backgroundColor: Colors.white,
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
                        heading(),
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
                            invoice.text,
                            style: TextStyle(color: Colors.tealAccent.shade700),
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
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
                                                child: TextFormField(
                                                  controller: invoiceDate,
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText: "Invoice Date",
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

                                                    invoiceDate.text =
                                                        dateFormat(date)
                                                            .toString();
                                                  },
                                                )),
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
                                                child: TextFormField(
                                                  controller: expiryDate,
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText: "Invoice Date",
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

                                                    expiryDate.text =
                                                        dateFormat(date)
                                                            .toString();
                                                  },
                                                )),
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
                                                        backgroundColor: Colors
                                                            .tealAccent
                                                            .shade700,
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
                                                                  .tealAccent
                                                                  .shade700),
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
                                                          // hintText: 'Enter Number',
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
                                                          //hintText:'Enter Subject',
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
                                                                  Colors
                                                                      .tealAccent
                                                                      .shade700,
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
                                                                        .tealAccent
                                                                        .shade700),
                                                              )),
                                                        ],
                                                      )),
                                                  Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 140.0,
                                                        bottom: 15.0,
                                                      ),
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
                                                            subject.text);Navigator.pop(context);
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
                      Text(expiryDate.text),
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
                                        style: TextStyle(
                                            color: Colors.white,
                                            decorationColor: Colors.white),
                                        items: customer.map((value) {
                                          return DropdownMenuItem(
                                            value: value['_id'],
                                            child: SizedBox(
                                              width: 250.0,
                                              child: Text(
                                                value['userName']['firstName'],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          List setDropDown;
                                          setDropDown = customer
                                              .where((subcat) =>
                                                  subcat['_id'] == value)
                                              .toList();
                                          this.invoiceDropDownName =
                                              setDropDown[0]['userName']
                                                  ['firstName'];
                                          this.invoiceDropDownId =
                                              setDropDown[0]['_id'];
                                        },
                                        hint: Text(
                                            this.invoiceDropDownName.toString(),
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
                                      IconButton(
                                        icon: Icon(Icons.add),
                                        onPressed: () {
                                          addItems();
                                        },
                                      )
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
                                              selectedItems[index]['itemName'];
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
                                                          Text(name.toString()),
                                                          Text(rate.toString() +
                                                              ' x ' +
                                                              quantity
                                                                  .toString()),
                                                        ],
                                                      ),
                                                      Text(totalAmounts
                                                          .toString()),
                                                    ]),
                                              ],
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return Divider();
                                        }),
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                            top: 15.0, right: 15.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Sub Total'),
                                            Text(amount.toString()),
                                          ],
                                        ),
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
                                                  shape:
                                                      RoundedRectangleBorder(),
                                                  onPressed: () {
                                                    this.onGenerateBill();
                                                    Navigator.pop(context);
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
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
                                                  color: Colors
                                                      .tealAccent.shade700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
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
                                          addItems();
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
  return DateUtil().formattedDate(DateTime.parse(dateFormat.toString()));
}

class DateUtil {
  static const DATE_FORMAT = 'yyyy-MMM-dd';
  String formattedDate(DateTime dateTime) {
    return DateFormat(DATE_FORMAT).format(dateTime);
  }
}
