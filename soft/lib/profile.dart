import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:soft/items.dart';
import 'package:soft/signin.dart';

class Profile extends StatefulWidget {
   Profile({this.argument});
  final Map argument;
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map values;
  //  getPayload() async {
  //   final storage = FlutterSecureStorage();
  //   var jwt = await storage.read(key: "jwt");
  //   if (jwt != null) {
  //     var jwtoken = jwt.split(".");

  //     this.values = json
  //         .decode(ascii.decode(base64.decode(base64.normalize(jwtoken[1]))));
  //   }print(this.values);
  // }
 @override
  void initState() {
    setState(() {
      this.values = this.widget.argument['values'];
    });
    super.initState();
     //getPayload();
  }
   final storage = FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(padding: const EdgeInsets.only(top: 100.0),
              child:Column(
                  children: [
                         ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child:Container(
                    color: Colors.tealAccent.shade700,
                 width: 50,
                 height: 50,
                    child: Center(
                      child: Text('${this.values['companyName'].toUpperCase().substring(0, 1)}',
                      style: TextStyle(fontWeight:FontWeight.bold,
                      fontSize: 30.0,
                      color: Colors.white ),)),
                  ),
                ),
                    Text(this.values['companyName'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),),
                    Text(this.values['companyEmailId'],style: TextStyle(color: Colors.grey,),
                    ),
                    Container(padding: const EdgeInsets.only(top: 15.0,bottom: 30.0,left: 15.0,right: 15.0),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         Container(
                           decoration: BoxDecoration(
                             color: Colors.white,
                               boxShadow: [
          BoxShadow(
            color: Colors.indigo.shade50,
            offset: Offset(0, 0),
            blurRadius: 10.0,
            spreadRadius: 5.0,
          )
        ],
                           ),
                           padding: const EdgeInsets.only(left: 14.0),
                           height: 40.0,width: 120.0,
                           child: Center(child: Row(
                             children: [
                               Text('View Profile'),Icon(Icons.chevron_right,color: Colors.tealAccent.shade700,)
                             ],
                           )),
                         ),
                          Center(
                            child: Container(padding: const EdgeInsets.only(left: 18.0),
                             decoration: BoxDecoration(
                             color: Colors.white,
                               boxShadow: [
          BoxShadow(
            color: Colors.indigo.shade50,
            offset: Offset(0, 0),
            blurRadius: 10.0,
            spreadRadius: 5.0,
          )
        ],
                           ),
                              height: 40.0,width: 120.0,
                             child: Center(child: Row(
                               children: [
                                 Text('Edit Profile'),Icon(Icons.chevron_right,color: Colors.tealAccent.shade700,)
                               ],
                             )),
                         ),
                          )
                       ],
                      ),
                    ),
                   ],
                ),
              ),
             Padding(
                     padding: const EdgeInsets.only(top:10.0),
                     child: GestureDetector(
                       onTap: (){
                          Navigator.push(context,
                           MaterialPageRoute(builder: (context) =>Items(
                           )));
                       },
                       child: Container(
                         decoration: BoxDecoration(
                           color: Colors.white,
                             boxShadow: [
          BoxShadow(
            color: Colors.indigo.shade50,
            offset: Offset(0, 0),
            blurRadius: 10.0,
            spreadRadius: 5.0,
          )
        ],
                         ),
                         width: 315.0,
                           height: 50.0,
                         child: Container(
                           padding: const EdgeInsets.only(left:15.0,right: 15.0,top: 10.0,bottom: 10.0),
                           child:Row(
                             children: [
                               Icon(Icons.grid_view,color: Colors.green,),
                               Container(padding: const EdgeInsets.only(left: 15.0),
                                 child: Text('Items',style: TextStyle(fontWeight: FontWeight.bold))),
                                 Container(padding: const EdgeInsets.only(left: 180.0,),
                                   child: Icon(Icons.chevron_right,color: Colors.tealAccent.shade700,))
                             ],
                           ),
                                        
                         ),
                       ),
                     ),
                   ),
                    Padding(
                     padding: const EdgeInsets.only(top:20.0),
                     child: GestureDetector(
                        onTap: ()async {
                          storage.delete(key: "jwt");
                          var jwt = await storage.read(key: "jwt");
                          print(jwt);
                          Navigator.push(context,
                           MaterialPageRoute(builder: (context) =>Signin(
                           )));
                       },
                       child: Container(  
                          decoration: BoxDecoration(
                             color: Colors.white,
                               boxShadow: [
          BoxShadow(
            color: Colors.indigo.shade50,
            offset: Offset(0, 0),
            blurRadius: 10.0,
            spreadRadius: 5.0,
          )
        ],
                           ),
                        width: 315.0,
                           height: 50.0,
                         child: Container(padding: const EdgeInsets.only(left:15.0,right: 15.0,top: 10.0,bottom: 10.0),
                           child:Row(
                             children: [
                               Icon(Icons.lock,color: Colors.orange,),
                               Container(padding: const EdgeInsets.only(left: 15.0),
                                 child: Text('Logout',style: TextStyle(fontWeight: FontWeight.bold),)),
                                  Container(padding: const EdgeInsets.only(left: 170.0,),
                                   child: Icon(Icons.chevron_right,color: Colors.tealAccent.shade700,))
                             ],
                           )
                         ),
                       ),
                     ),
                   ),
          ],
        ),
      ),
      
    );
  }
}