import 'package:flutter/material.dart';
import 'package:soft/edit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_mailer/flutter_mailer.dart';

class ContactDetailPage extends StatefulWidget {
    ContactDetailPage({
    this.prod,
  });
  
  final Map prod;
  @override
  _ContactDetailPageState createState() => _ContactDetailPageState();
}

class _ContactDetailPageState extends State<ContactDetailPage> {

 void mobileContact() async {
    String url = "tel://" + this.widget.prod['phone']['primaryContact'];
    if (await canLaunch(url)) {
    await launch(url);
    } else {
    throw 'Could not call $url';
    }
  }
  void phoneContact() async {
    String url = "tel://" + this.widget.prod['phone']['secondarycontact'];
    if (await canLaunch(url)) {
    await launch(url);
    } else {
    throw 'Could not call $url';
    }
  }
   void emailContact() async {
    final url = "mailto:" + this.widget.prod['contactEmail'];
    if (await canLaunch(url)) {
    await launch(url);
    } else {
    throw 'Could not call $url';
    }
  }
  @override
  void initState() {
    super.initState();print(this.widget.prod['otherDetails']);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(color: Colors.tealAccent.shade700,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top:30.0,),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(icon: Icon(Icons.arrow_back,color: Colors.white), onPressed: (){
                          Navigator.pop(context);

                        }),
                        Container(padding: const EdgeInsets.only(right:180.0,),
                          child: Text('Hysas',style: TextStyle(
                            color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0
                          ),)),
                        IconButton(icon: Icon(Icons.edit,color: Colors.white), onPressed: (){
                                Navigator.push( 
        context, MaterialPageRoute(
        builder: (context) => Edit(prod: this.widget.prod)));
                        }),
                      ],
                    ),
                  ),
              
              Container(padding: const EdgeInsets.only(right: 15.0,left: 15.0,top: 50.0,bottom: 20.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Outstanding',style: TextStyle(
                            color: Colors.white,fontWeight: FontWeight.bold
                          ),),
                        
                        Container(padding: const EdgeInsets.only(top: 10.0),
                          child: Text('??? 96,000',style: TextStyle(
                            color: Colors.white,fontWeight: FontWeight.bold,fontSize: 28.0
                          ),),
                        )
                      ],
                    ),
                    VerticalDivider(color: Colors.white,
            thickness: 2, width: 20,
            indent: 50,
            endIndent: 50,),
                 Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Unusedcreadit',style: TextStyle(
                            color: Colors.white,fontWeight: FontWeight.bold
                          ),),
                        Container(padding: const EdgeInsets.only(top: 10.0),
                          child: Text('??? 96,000',style: TextStyle(
                            color: Colors.white,fontWeight: FontWeight.bold,fontSize: 28.0
                          ),),
                        )
                        
                      ],
                    )
                 
                  ],
                ),

              ),
               ],
              ),
            ),
            Container(
              child:  
               DefaultTabController(
                  length: 2,
                 child: Column(
                 children: [
                  TabBar(
                   indicatorColor: Colors.tealAccent.shade700,
                    unselectedLabelColor: Colors.black,
                     labelColor: Colors.tealAccent.shade700,
                     tabs: [
                      Tab(text: 'TRANSACTION'),
                       Tab(text: 'DETAILS'),
                       ],
                     ),
                    Container(
                            height: 400.0,
                            child: TabBarView(children: [
                              Container(
                                child: Text('dfghj'),
                               ),
                    SingleChildScrollView(
                     child: Container(padding: const EdgeInsets.only(top:30.0),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Container(padding: const EdgeInsets.only(bottom:30.0),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                       Column(
                        children: [
                        RawMaterialButton(
  onPressed: () {
    mobileContact();
  },
  elevation: 2.0,
  fillColor: Colors.tealAccent.shade700,
  child: Icon(
    Icons.send_to_mobile,color: Colors.white,
    size: 35.0,
  ),
  padding: EdgeInsets.all(15.0),
  shape: CircleBorder(),
),
Container(padding: const EdgeInsets.only(top:10.0),
  child: Text('Mobile',style: TextStyle(
    color: Colors.tealAccent.shade700
  ),))
           ],
 ),
  Column(
 children: [
  RawMaterialButton(
  onPressed: () {
    phoneContact();
  },
  elevation: 2.0,
  fillColor: Colors.tealAccent.shade700,
  child: Icon(
    Icons.phone,
    color: Colors.white,
    size: 35.0,
  ),
  padding: EdgeInsets.all(15.0),
  shape: CircleBorder(),
),
Container(padding: const EdgeInsets.only(top:10.0),
  child: Text('Work Phone',style: TextStyle(
    color: Colors.tealAccent.shade700
  ),))
  ],
 ),
 Column(
 children: [
 RawMaterialButton(
  onPressed: () {
    emailContact();
  },
  elevation: 2.0,
  fillColor: Colors.tealAccent.shade700,
  child: Icon(
    Icons.email,color: Colors.white,
    size: 35.0,
  ),
  padding: EdgeInsets.all(15.0),
  shape: CircleBorder(),
),Container(padding: const EdgeInsets.only(top:10.0),
  child: Text('Email',style: TextStyle(
    color: Colors.tealAccent.shade700
  ),))
  ],
),
 ],
 ),
 ),
  Divider(),
                                    Container(padding: const EdgeInsets.only(left: 15.0,top: 15.0),
                                      child: Text('Address',style: TextStyle(
                                        fontWeight: FontWeight.bold
                                      ),),
                                    ),
                                    Container(
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(padding: const EdgeInsets.only(top: 20.0,left: 15.0),
                                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(padding: const EdgeInsets.only(bottom: 5.0,right: 5.0),
                                                  child: Text('Billing Address',style: TextStyle(
                                        color: Colors.grey,fontWeight: FontWeight.bold
                                      ),),
                                                ),
                                                Text(this.widget.prod['userName']['salutation']['name']+''+
                                                this.widget.prod['userName']['firstName']+ ' '+
                                                this.widget.prod['userName']['lastName'].toString()),
                                      Text(this.widget.prod['billingAddress']['Street1']!=null?this.widget.prod['billingAddress']['Street1'].toString():''),
                                      Text(this.widget.prod['billingAddress']['city']!=null?this.widget.prod['billingAddress']['city'].toString():''),
                                       Text(this.widget.prod['billingAddress']['state']!=null?this.widget.prod['billingAddress']['state'].toString():''),
                                      Text(this.widget.prod['billingAddress']['zipCode']!=null?this.widget.prod['billingAddress']['zipCode'].toString():''),
                                       Text(this.widget.prod['billingAddress']['phone1']!=null?this.widget.prod['billingAddress']['phone1'].toString():''),
                                      Text(this.widget.prod['billingAddress']['countryRegion']!=null?this.widget.prod['billingAddress']['countryRegion'].toString():'')
                                              ],
                                            ),
                                          ),
                                          
                                          Container(padding: const EdgeInsets.only(right: 15.0,),
                                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            Container(padding: const EdgeInsets.only(bottom: 5.0,right: 5.0),
                                              child: Text('Others Details',
                                              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                                            ),
                                       
                                     Text(this.widget.prod['userName']['salutation']['name']+''+
                                                this.widget.prod['userName']['firstName']+ ' '+
                                                this.widget.prod['userName']['lastName'].toString()),
                                       Text(this.widget.prod['otherDetails']['currency']!=null?'currency : '+this.widget.prod['otherDetails']['currency'].toString():''),
                                        Text(this.widget.prod['otherDetails']['openingBalance']!=''?'Opening Balance : '+this.widget.prod['otherDetails']['openingBalance'].toString():''),
                                      Text(this.widget.prod['otherDetails']['portalLanguage']!=null?'Language : '+this.widget.prod['otherDetails']['portalLanguage'].toString():''),
                                        Text(this.widget.prod['otherDetails']['facebook']!=''?'Facebook : '+this.widget.prod['otherDetails']['facebook'].toString():''),
                                       Text(this.widget.prod['otherDetails']['twitter']!=''?'Twitter : '+this.widget.prod['otherDetails']['twitter'].toString():''),
                                        ],
                                      ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Divider(),
                                    // Container(padding: const EdgeInsets.only(left: 15.0,top: 15.0),
                                    //   child: 

                                    // ),

                                    ],
                                  ),
                                ),
                              ),
                            ]),
                          ),
                       
                        ])),
                  
            )
          ],
        ),
      ),
      
      
    );
  }
}