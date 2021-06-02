import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:soft/config/upload_url.dart';
import 'package:soft/payment.dart';
import 'package:intl/intl.dart';
class PaymentList extends StatefulWidget {
  @override
  _PaymentListState createState() => _PaymentListState();
}

class _PaymentListState extends State<PaymentList> {
  List payment;
  dynamic totalAmount;
  Future getData() async {
    var response = await http.get(Uri.parse(BaseUrl.payment),
        headers: {"Accept": "application/json"});
    this.setState(() {
   var paymentList = json.decode(response.body);
      payment = paymentList['data'];
    });
  }

addAmount(account){
    var amount=0;
     account.forEach((element) {
      amount += element['paymentAmount'];
    });
   totalAmount =amount.toString();
   return Text(totalAmount,style: TextStyle(color: Colors.red),);
}
 @override
  void initState() {
    getData();
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('Payment'),backgroundColor: Colors.tealAccent.shade700,),
      body: Stack(
        children: [
          payment == null
              ? Container(
                  child: Center(child: CircularProgressIndicator()),
                ):Stack(
                   children: [
             ListView.separated(
        itemCount: payment.length,
        itemBuilder: (context, index) {
          return Container( 
            child:GestureDetector(
                                  onTap: (){
                                     Navigator.push(context,
                                    MaterialPageRoute(builder: (context) =>Payment(
                                   
                                    )));
                                  },
                                    child: Container(
                                    
                                  padding: const EdgeInsets.only(top:15.0,right: 15.0),
                                     
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(padding: const EdgeInsets.only(left:15.0),
                                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                               Text(payment[index]['accountCompanyName']),
                                               Text(dateFormat(payment[index]['createdAt']))
                                              ],
                                            ),
                                          ),
                                          addAmount(payment[index]['accounts'])

                                        ],
                                      ),
                                    ),
                                  ),
          );
        },separatorBuilder: (context, index) {
                    return Divider();
                  },
        ),
          ]),
        ]) 
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