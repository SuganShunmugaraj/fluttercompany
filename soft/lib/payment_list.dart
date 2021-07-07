import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:soft/config/upload_url.dart';
import 'package:soft/payment.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
   return Text('₹ '+totalAmount,style: TextStyle(fontWeight: FontWeight.bold),);
}
 @override
  void initState() {
  super.initState();
   getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
        title: Text('Transaction',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
      ),
      body: Stack(
        children: [
          payment == null
              ? Container(
                  child: Center(child: CircularProgressIndicator()),
                ):Stack(
                   children: [

                       Column(
                        children: [
  //                         Container( padding: const EdgeInsets.only(top:40.0,left: 15.0,right: 15.0,bottom: 15.0),
  //                                               child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                                 children: [
  //                                                   Text('Transaction',
  //                                                   style: TextStyle(
  //                                                     fontWeight: FontWeight.bold,),),
  // //                                                     
  // // Stack(
  // //   children: [
  // //     Container(
  // // width: 30,
  // // height: 30,
  // // child:
  // //  Stack(
  // //   children: [
  // //     Icon(
  // //       Icons.notifications,
  // //       color: Colors.grey,
  // //       size: 30,
  // //     ),
  // //     Container(
  // //       width: 30,
  // //       height: 30,
  // //       alignment: Alignment.topRight,
  // //       margin: EdgeInsets.only(top: 2),
  // //       child: Container(
  // //         width: 9,
  // //         height: 9,
  // //         decoration: BoxDecoration(
  // //             shape: BoxShape.circle,
  // //             color: Colors.red,
  // //            ),
         
  // //       ),
  // //     ),
  // //   ],
  // // ),)
  // //                  ],
  // // ),
                
  //                                                 ],
  //                                               ),
  //                                             ),
  
  //                                         Container(
  //                                          height: 40.0,
  //                                          width: 330.0,

   
  // decoration: BoxDecoration(
  //   border: Border.all(color: Colors.grey
  //   ),
  //   borderRadius: BorderRadius.all(
  //       Radius.circular(5.0) 
  //   ),
  // ),child: Row(
  //   children: [
  //     Container(padding: const EdgeInsets.only(left:5.0),
  //       child: Icon(Icons.search))
  //   ],
  // ),),
                                 
                        ],
                      ),         
             
             Container(padding: const EdgeInsets.only(top: 10.0),
               child: ListView.separated(
        itemCount: payment.length,
        itemBuilder: (context, index) {
           return  GestureDetector(
              onTap: (){
                                           Navigator.push(context,
                                          MaterialPageRoute(builder: (context) =>Payment(
                                         
                                          )));
                                        },
             child: Slidable(
  actionPane: new SlidableBehindActionPane(),
  actionExtentRatio: 0.25,
  child: new Container(
    //color: Colors.white,
    child: ListTile(
          title: Container(
                                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                    Text(payment[index]['accountCompanyName'],
                                                    style: TextStyle(fontWeight: FontWeight.bold),),
                                                    Text(dateFormat(payment[index]['createdAt']),
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      ),)
                                                    ],
                                                  ),
                                                ),
                                                addAmount(payment[index]['accounts'])

                                              ],
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
                                        builder: (context) => Payment(
                                            )))
    ),
    new IconSlideAction(
      caption: 'Delete',
      color: Colors.tealAccent.shade700,
      icon: Icons.delete,
      onTap: ()async{
        await showDialog(context: context,builder:
                        (_) => AlertDialog(
                     title: Text( 'Do you want Delete'),
                     actions: [
                      FlatButton(
                         onPressed:
                        () {
                          Navigator.of(context, rootNavigator: true).pop(true);
                             }, child: Text('No',
                             style:TextStyle(
                               color:  Colors.tealAccent.shade700,
                                    ),
                                                      )),
                                FlatButton(
                                   onPressed:
                                        () {
                                       
                                        Navigator.of(context, rootNavigator: true).pop(true);
                                         },
                                          child:Text('Yes',
                                          style:TextStyle(color:Colors.tealAccent.shade700,
                                                                                ),
                                                                              ))
                                                                        ],
                                                                      ));
                                         
      },
    ),
  ],
             ),
           );
          
       
        },separatorBuilder: (context, index) {
                      return Divider();
                    },
        ),
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
                                    builder: (context) => Payment(
                                        )));
                          },
                          child: Icon(Icons.add),
                        ),
                      )),
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