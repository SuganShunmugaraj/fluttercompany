
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.tealAccent.shade700,
        body:SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                            icon: Icon(Icons.arrow_back_sharp),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Text(
                          (this.widget.name['invoice']).toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:15.0),
                        child: Text(
                          (this.widget.name['invoice']).toString(),
                          style: TextStyle(color: Colors.white, fontSize: 15.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          (value != null) ? value : 'Pending',
                          style: TextStyle(color: Colors.white, fontSize: 15.0),
                        ),
                      )
                    ]),
                Padding(
                  padding: const EdgeInsets.only(left:15.0),
                  child: Text(
                    (this.widget.name['customerName']['companyName'])
                        .toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:15.0,top: 10.0),
                  child: Text(
                    '₹' + (this.widget.name['totalAmount']).toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:15.0,bottom: 5.0),
                  child: Text(
                    'BALANCE',
                    style: TextStyle(color: Colors.white, fontSize: 10.0),
                  ),
                ),
                Container(padding: const EdgeInsets.only(top: 5.0),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  if (this.widget.name['invoiceDate'] == null)
                                    Text(dateFormat(
                                        this.widget.name['recurringstartDate']))
                                  else
                                    Text(dateFormat(
                                        this.widget.name['invoiceDate'])),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 25.0),
                                    child: Text(
                                      'Invoice Date',
                                      style: TextStyle(
                                          color: Colors.tealAccent.shade700,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10.0),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  if (this.widget.name['expiryDate'] == null)
                                    Text(dateFormat(
                                        this.widget.name['recurringstartDate']))
                                  else
                                    Text(dateFormat(
                                        this.widget.name['expiryDate'])),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 30.0),
                                    child: Text(
                                      'Expiry Date',
                                      style: TextStyle(
                                          color: Colors.tealAccent.shade700,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10.0),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                      Container(padding: const EdgeInsets.only(bottom:15.0,top:15.0),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 275.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Reference#',
                                style: TextStyle(
                                    color: Colors.tealAccent.shade700,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.0),
                              ),
                              Text((this.widget.name['reference']).toString()),
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                      Container(
                      padding: const EdgeInsets.only(bottom:15.0,top:15.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 260.0),
                                child: Text(
                                  'Billing Address',
                                  style: TextStyle(
                                      color:Colors.tealAccent.shade700,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.0),
                                ),
                              ),
                              Padding(
                          padding: const EdgeInsets.only(left:15.0),
                                child: Text((this.widget.name['customerName']
                                        ['billingAddress']['Street1']) +
                                    ', ' +
                                    (this.widget.name['customerName']
                                        ['billingAddress']['Street2']) +
                                    ', ' +
                                    (this.widget.name['customerName']
                                        ['billingAddress']['attention']) +
                                    ', ' +
                                    (this.widget.name['customerName']
                                        ['billingAddress']['fax']) +
                                    ', ' +
                                    (this.widget.name['customerName']
                                        ['billingAddress']['city']) +
                                    ', ' +
                                    (this.widget.name['customerName']
                                        ['billingAddress']['state']) +
                                    ', ' +
                                    (this.widget.name['customerName']
                                        ['billingAddress']['countryRegion']) +
                                    ', ' +
                                    (this.widget.name['customerName']
                                        ['billingAddress']['phone1']) +
                                    ', ' +
                                    (this.widget.name['customerName']
                                            ['billingAddress']['zipCode'])
                                        .toString()),
                              ),
                            ],
                          ),
                        ),
                      
                    Container( 
                            color: Color(0xFFECEFF1),
                            height: 40.0,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:15.0),
                                    child: Text(
                                      'Items',
                                      style: TextStyle(
                                          color: Colors.tealAccent.shade700,
                                          fontWeight: FontWeight.bold,
                                         ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right:15.0),
                                    child: Text(
                                      'Amount',
                                      style: TextStyle(
                                          color: Colors.tealAccent.shade700,
                                          fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ]),
                          ),
                        
                      for (var k = 0; k < this.widget.name['items'].length; k++)
                        Container(
                          padding: const EdgeInsets.only(left:3.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: Text((this.widget.name['items'][k]
                                          ['itemdetails'])
                                      .toString()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text('₹' +
                                      (this.widget.name['items'][k]['amount'])
                                          .toString()),
                                ),
                              ]),
                        ),
                      Divider(),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 100.0),
                              child: Text(
                                'Sub Total',
                                style: TextStyle(
                                    color: Colors.tealAccent.shade700,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text('₹' +
                                  (this.widget.name['subTotal']).toString()),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 100.0),
                              child: Text(
                                'Total',
                                style: TextStyle(
                                    color: Colors.tealAccent.shade700,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text('₹' +
                                  (this.widget.name['totalAmount']).toString()),
                            ),
                          ],
                        ),
                      ),
                    ],
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
