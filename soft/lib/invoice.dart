import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:soft/config/upload_url.dart';
import 'package:http/http.dart' as http;
import 'package:soft/invoice_add.dart';
import 'package:soft/invoice_details.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Invoice extends StatefulWidget {
  Invoice({this.argument});
  final Map argument;
  @override
  _InvoiceState createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  List invoiceList;
  List fullinvoiceList;
  List _invoice;
  Map values;

  getData() async {
    var response = await http.get(
        Uri.parse(BaseUrl.invoice),
        headers: {"Accept": "application/json"});
    setState(() {
      final invoiceData = json.decode(response.body);
      invoiceList = invoiceData['data'];
      fullinvoiceList = invoiceData['data'];
    });
  }

  removeInvoice(index, id) async {
    setState(() {
      invoiceList.removeAt(index);
    });
    var response = await http.delete(Uri.parse(BaseUrl.addInvoice + id),
        headers: {"Accept": "application/json"});
    print(response);
  }

  @override
  void initState() {
    setState(() {
      this.values = this.widget.argument['values'];
    });
    super.initState();
    getData();
  }

  String chosenValue;
  String drop = 'All Invoice ';
  String formattedDate;

  setOverdue(data) {
    var expiry = dateFormat(data);
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MMM-dd').format(now);

    if (expiry.compareTo(formattedDate.toString()) < 0) {
      return Text(
        'OverDue',
        style: TextStyle(
          color: Colors.red,
        ),
      );
    } else {
      return Text('Pending', style: TextStyle(
          color: Colors.green,
        ),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: DropdownButtonHideUnderline(
            child: DropdownButton(
              dropdownColor: Colors.white,
              value: chosenValue,
              style:
                  TextStyle(color: Colors.white, decorationColor: Colors.white,fontWeight: FontWeight.bold),
              items: [
                'All Invoice',
                'Draft',
                'Pending',
                'Paid',
              ].map((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      color: Colors.tealAccent.shade700,
                      fontSize: 20.0,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String value) {
                drop = value;
                if (value == 'All Invoice') {
                  setState(() {
                    invoiceList = fullinvoiceList;
                  });
                } else {
                  _invoice = fullinvoiceList
                      .where((i) => i['status'] == value)
                      .toList();
                  setState(() {
                    invoiceList = _invoice;
                  });
                }
              },
              hint: Text(this.drop.toString(),
                  style: TextStyle(
                    color: Colors.black,fontSize: 20.0,
                    fontWeight: FontWeight.bold
                  )),
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
              ),
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: invoiceList == null
            ? Container(
                child: Center(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                        padding:
                            const EdgeInsets.only(left: 280.0, bottom: 10.0),
                        child: SizedBox(
                          width: 60.0,
                          child: FloatingActionButton(
                            backgroundColor: Colors.tealAccent.shade700,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InvoiceAdd()));
                            },
                            child: Icon(Icons.add),
                          ),
                        )),
                  ),
                ),
              )
            : Stack(children: [
                ListView.separated(
                  itemCount: this.invoiceList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Slidable(
                      actionPane: new SlidableBehindActionPane(),
                      actionExtentRatio: 0.25,
                      child: new Container(
                        //color: Colors.white,
                        child: ListTile(
                          title: Container(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => InvoiceDetails(
                                              name: this.invoiceList[index],
                                            )));
                              },
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(top:8.0),
                                  child: Row( mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(crossAxisAlignment:CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            (this.invoiceList[index]['invoice']).toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          if (this.invoiceList[index]['expiryDate'] ==null)
                                        Text((dateFormat(this.invoiceList[index]
                                                ['recurringstartDate']) +' - ' +
                                            dateFormat(this.invoiceList[index]
                                                ['recurringendDate'])), style: TextStyle(color: Colors.grey,
                     fontWeight: FontWeight.bold),)
                                      else
                                        Text((dateFormat(this.invoiceList[index]
                                                ['invoiceDate']) +' - ' +
                                            dateFormat(this.invoiceList[index]
                                                ['expiryDate'])), style: TextStyle(color: Colors.grey,
                     fontWeight: FontWeight.bold),),
                                      setOverdue(this.invoiceList[index]['expiryDate'])
                                        ],
                                      ),
                                      
                                      Text(
                                            '??? ' +
                                                (this.invoiceList[index]
                                                        ['totalAmount'])
                                                    .toString(),
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      secondaryActions: <Widget>[
                        new IconSlideAction(
                            caption: 'Edit',
                            color: Colors.grey,
                            icon: Icons.more_horiz,
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InvoiceAdd(
                                          prod: invoiceList[index],
                                        )))),
                        new IconSlideAction(
                          caption: 'Delete',
                          color: Colors.tealAccent.shade700,
                          icon: Icons.delete,
                          onTap: () async {
                            await showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                      title: Text('Do you want Delete'),
                                      actions: [
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop(true);
                                            },
                                            child: Text(
                                              'No',
                                              style: TextStyle(
                                                color:
                                                    Colors.tealAccent.shade700,
                                              ),
                                            )),
                                        FlatButton(
                                            onPressed: () {
                                              removeInvoice(
                                                  index,
                                                  this.invoiceList[index]
                                                      ['_id']);
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop(true);
                                            },
                                            child: Text(
                                              'Yes',
                                              style: TextStyle(
                                                color:
                                                    Colors.tealAccent.shade700,
                                              ),
                                            ))
                                      ],
                                    ));
                          },
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                      padding: const EdgeInsets.only(left: 280.0, bottom: 10.0),
                      child: SizedBox(
                        width: 60.0,
                        child: FloatingActionButton(
                          backgroundColor: Colors.tealAccent.shade700,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InvoiceAdd()));
                          },
                          child: Icon(Icons.add),
                        ),
                      )),
                ),
              ]));
  }
}

dateFormat(dateFormat) {
  return DateUtil().formattedDate(DateTime.parse(dateFormat));
}

class DateUtil {
  static const DATE_FORMAT = 'yyyy-MMM-dd';
  String formattedDate(DateTime dateTime) {
    return DateFormat(DATE_FORMAT).format(dateTime.toLocal());
  }
}
