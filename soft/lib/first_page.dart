import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:soft/config/upload_url.dart';
import 'package:soft/dashboard.dart';
import 'package:soft/items.dart';
import 'package:soft/payment.dart';
import 'package:soft/payment_list.dart';
import 'package:soft/contact_detail.dart';
import 'package:soft/string.dart';
import 'package:soft/contacts.dart';
import 'package:http/http.dart' as http;
import 'package:soft/signin.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:soft/upload.dart';


class FirstPage extends StatefulWidget {
  FirstPage(this.jwt, this.payload);

  factory FirstPage.fromBase64(String jwt) => FirstPage(
      jwt,
      json.decode(
          ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))));

  final String jwt;
  final Map<String, dynamic> payload;
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: SafeArea(
          child: ListView(
            children: [
              Row(
                children: [
                  Container(
                    child: FlatButton.icon(
                      label: Container(
                        child: Text('Upload'),
                      ),
                      icon: Icon(Icons.upload_file),
                      onPressed: () {
                        Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>ChartsDemo(
                                   
                                   
                                  )));
                      },
                    ),
                  )
                ],
              ),
              Divider(),
              Row(
                children: [
                  Container(
                    child: FlatButton.icon(
                      label: Container(
                        child: Text('Profile'),
                      ),
                      icon: Icon(Icons.person),
                      onPressed: () {
                          },
                    ),
                  )
                ],
              ),
              Divider(),
              Row(
                children: [
                  Container(
                    child: FlatButton.icon(
                        label: Container(
                          child: Text('LOG OUT'),
                        ),
                        icon: Icon(Icons.logout),
                        onPressed: () async {
                          storage.delete(key: "jwt");
                          var jwt = await storage.read(key: "jwt");
                          print(jwt);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Signin()));
                        }),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body:  
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
          
            Builder(
                builder: (context) =>  Container(
                  height:50.0,
                   padding: const EdgeInsets.only(top: 5.0,),
                        color: Colors.white,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                               Container(
                                child: Column(
                                    children: [
                                       GestureDetector(
                                onTap: (){
                                  Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>Dashboard(
                                   
                                  )));
                                 
                                },
                                    child: Container(
                                  
                                  child: Column(
                                    children: [
                                     Icon(Icons.dashboard,color: Colors.grey,),
                                     Text('Dashboard',
                                     style: TextStyle(color: Colors.grey),),
                                     
                                    ],
                                  ),
                                ),
                              ),
                                    ],
                                  ),
                              ),
                              Container(
                                child: Column(
                                    children: [
                                       GestureDetector(
                                onTap: (){
                                  Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>PaymentList(
                                   
                                  )));
                                 
                                },
                                    child: Container(
                                  
                                  child: Column(
                                    children: [
                                     Icon(Icons.account_balance,color: Colors.grey,),
                                     Text('Account',
                                     style: TextStyle(color: Colors.grey),),
                                     
                                    ],
                                  ),
                                ),
                              ),
                                    ],
                                  ),
                              ),
                            
                              GestureDetector(
                                onTap: (){
                                 Navigator.pushNamed(
                                                context, INVOICE_PAGE,
                                                  arguments: {
                                                  'values': this.widget.payload
                                                });
                                                
                                },
                                    child: Container(
                                  
                                  child: Column(
                                    children: [
                                     Icon(Icons.watch_later_rounded,color: Colors.grey,),
                                     Text('Invoice',
                                     style: TextStyle(color: Colors.grey),),
                                     
                                    ],
                                  ),
                                ),
                              ),
                               GestureDetector(
                                onTap: (){
                                  Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>Contacts(
                                   
                                  )));
                                 
                                },
                                    child: Container(
                                  
                                  child: Column(
                                    children: [
                                     Icon(Icons.person_outline,color: Colors.grey,),
                                     Text('Contacts',
                                     style: TextStyle(color: Colors.grey),),
                                     
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>Items(
                                   
                                  )));
                                 
                                },
                                    child: Container(
                                  
                                  child: Column(
                                    children: [
                                     Icon(Icons.grid_view,color: Colors.grey,),
                                     Text('Items',
                                     style: TextStyle(color: Colors.grey),),
                                     
                                    ],
                                  ),
                                ),
                              ),


                               GestureDetector(
                                onTap: (){
                                 Scaffold.of(context)
                                            .openEndDrawer();
                                },
                                    child: Container(
                                  
                                  child: Column(
                                    children: [
                                     Icon(Icons.settings,color: Colors.grey,),
                                     Text('Settings',
                                     style: TextStyle(color: Colors.grey),),
                                     
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
          ],
        ),
      // ]),
    );
  }
}
