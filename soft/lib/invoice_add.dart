
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
class InvoiceAdd extends StatefulWidget {
  InvoiceAdd({
    this.name,
  });
  final Map name;
  @override
  _InvoiceAddState createState() => _InvoiceAddState();
}

class _InvoiceAddState extends State<InvoiceAdd> {
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
  String _chosenValue;

  @override
  Widget build(BuildContext context) {
   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
   statusBarColor:Colors.purple.shade50, // Color for Android
   statusBarBrightness: Brightness.dark // Dark == white status bar -- for IOS.
));
    return Scaffold(
     backgroundColor: Colors.purple.shade50,
      appBar: AppBar(backgroundColor: Colors.white,
        title: Text('Create Bill/ Invoice',style: TextStyle(color: Colors.black

        ),),
        leading: Icon(Icons.arrow_back,color: Colors.black,),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:15.0),
            child: Icon(Icons.save,color: Colors.black,),
          )
        ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:50.0),
                  child: Container(
                    color: Color(0xFFECEFF1),
                     padding: const EdgeInsets.all(15.0),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Invoice #H5'),
                              GestureDetector(
                                onTap: (){
                                  showModalBottomSheet(context: context, builder: (BuildContext context){
                                    return SingleChildScrollView(
                                    child: new Container(
                                       
                                       
                                       child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Container(
                                             padding: const EdgeInsets.all(15.0),
                                             child: Text('Edit Invoice Date & Number',
                                             style: TextStyle(fontWeight: FontWeight.bold),
                                             )
                                             ), 
                                             Container(padding: const EdgeInsets.only(left:15.0),
                                               child: Text('Invoice Date')),
                                            Container(
                                              height: 40.0,
                                              padding: const EdgeInsets.only(left:15.0,right: 15.0,top: 5.0),
                                              child: TextField(  
                                        obscureText: true,  
                                       decoration: InputDecoration(  
                                       border: OutlineInputBorder(), 
                                       suffixIcon: Icon(Icons.calendar_today_outlined),
                                       labelText: ' Invoice Date',
                                       hintText: 'Enter Invoice Date',  
                    ),  
                  ),
                                            ), Container(padding: const EdgeInsets.only(left:15.0,top: 15.0),
                                               child: Text('Due Date')),
                                            Container(
                                              height: 40.0,
                                              padding: const EdgeInsets.only(left:15.0,right: 15.0,top: 5.0),
                                              child: TextField(  
                                        obscureText: true,  
                                       decoration: InputDecoration(  
                                       border: OutlineInputBorder(), 
                                      
                                       labelText: ' Due Date',
                                       hintText: 'Enter Due Date',  
                    ),  
                  ),
                                            ),

                  Container(padding: const EdgeInsets.only(left:15.0,top: 15.0),
                  
                    child: Row(
                      children: [Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                    radius: 7.0,
                    backgroundColor: Colors.purple,
                    child: Icon(Icons.close, color: Colors.white,size: 9.0,),
                    ),
                ),
                                  Container(padding: const EdgeInsets.only(left:5.0),
                                      child: Text('Remove Due Date',style: TextStyle(color: Colors.purple),)),
                      ],
                    )),
                 
                       Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                         children: [
                           Column(crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                                Container(padding: const EdgeInsets.only(left:10.0,top: 15.0),
                    child: Text('Invoice Prefix')),
                               Container(
                                                      height: 40.0,
                                                      width: 170.0,
                                                      padding: const EdgeInsets.only(left:10.0,top: 5.0),
                                                      child: TextField(  
                                                obscureText: true,  
                                               decoration: InputDecoration(  
                                               border: OutlineInputBorder(), 
                                               labelText: ' Invoice ',
                                               hintText: 'Invoice ',  
                    ),  
                  ),
                                                    ),
                             ],
                           ),
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                                Container(padding: const EdgeInsets.only(top: 15.0),
                    child: Text('Invoice Number')),
                               Container(
                                                      height: 40.0,
                                                      width: 170.0,
                                                      padding: const EdgeInsets.only(right: 10.0,top: 5.0),
                                                      child: TextField(  
                                                obscureText: true,  
                                               decoration: InputDecoration(  
                                               border: OutlineInputBorder(), 
                                               labelText: ' Number',
                                               hintText: 'Enter Number',  
                    ),  
                  ),
                                                    ),
                             ],
                           ),
                         ],
                       ),
                      Container(padding: const EdgeInsets.only(top: 15.0),
                        child: Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(padding: const EdgeInsets.only(left: 15.0,bottom: 15.0),
                              child: Row(
                                children: [
                                   Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                    radius: 7.0,
                    backgroundColor: Colors.purple,
                    child: Icon(Icons.close, color: Colors.white,size: 9.0,),
                    ),
                ),
                                  Container(padding: const EdgeInsets.only(left:5.0),
                                      child: Text('Remove Prefix',style: TextStyle(color: Colors.purple),)),
                                ],
                              )),
                              Container(padding: const EdgeInsets.only(left: 160.0,bottom: 15.0),
                                child: Text('(ex:h5,h6)'))
                          ],
                        ),
                      ),
                      Container(padding: const EdgeInsets.only(left:15.0,right: 15.0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            RaisedButton(
                onPressed: () {},
                textColor: Colors.white,
                color: Colors.purple,
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 20),
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
                                 child:Text('Edit', 
                                 style: TextStyle(
                                   color: Colors.purple,fontWeight: FontWeight.bold),),
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
              padding: const EdgeInsets.only(top:15.0),
              child: Container(
                
                color: Color(0xFFECEFF1),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                          Container(
                            padding: const EdgeInsets.only(
                         left:15.0,top: 15.0,),
                            child: Text('PARTY NAME')),
                       Container( 
                         padding: const EdgeInsets.only(
                         left:15.0,right:15.0,top: 15.0,),
                    height: 60.0,
                          child: TextField(  
                    obscureText: true,  
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(), 
                      prefixIcon: Icon(Icons.person_outline),
                      labelText: ' Party Name',  
                      hintText: 'Enter Party Name',  
                    ),  
                  ),
                         ),
                         GestureDetector(
                                onTap: (){
                               
                                                
                                },
                                    child: Container(
                                  padding: const EdgeInsets.only(right: 15.0,
                         top: 15.0),
                                  child: Row(mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(Icons.add),
                                      Text('Mobile Number'),
                                     
                                    ],
                                  ),
                                ),
                              ),
                         
                       
                            Container(
                            padding: const EdgeInsets.only(top: 20.0,
                         left:15.0,),
                            child: Text('ITEMS')
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                         left:15.0,right: 15.0,bottom: 15.0),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  FlatButton(
                onPressed: () {
                  showModalBottomSheet(context: context, builder: (BuildContext context){
                                    return SingleChildScrollView(
                                    child: Container(
                                         child:  Column(
                                           children: [
                                             Container(
                                        padding: const EdgeInsets.only(
                         left:15.0,right:15.0,top: 15.0,),
                    height: 60.0,
                     child: TextField(  
                    obscureText: true,  
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(), 
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: Icon(Icons.record_voice_over),icon: Icon(Icons.arrow_back),
                      labelText: ' Search..',  
                      // hintText: 'Enter Party Name',  
                    ),  
                  ),
                  ),
                     Divider(),                    
                  Container(
                                      padding: const EdgeInsets.only(
                         left:15.0,right:15.0,top: 15.0,),
                    child: 
                    Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                         Container(
                          
                           child: DropdownButton<String>(
  focusColor:Colors.white,
  value: _chosenValue,
  //elevation: 5,
  style: TextStyle(color: Colors.blue),
  iconEnabledColor:Colors.black,
  items: <String>[
    'Android',
    'IOS',
    'Flutter',
    'Node',
    'Java',
    'Python',
    'PHP',
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value,style:TextStyle(color:Colors.black),),
    );
  }).toList(),
  hint:Text(
    "Add Category",
    style: TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w500),
  ),
  onChanged: (String value) {
    setState(() {
      _chosenValue = value;
    });
  },
),
                         ),
              GestureDetector(
                                onTap: (){
                               
                                                
                                },
                                    child: Container(
                                 
                                  child: Row(mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(Icons.add),
                                      Text('Mobile Number'),
                                     
                                    ],
                                  ),
                                ),
                              ),
            
                      ],
                    ),
                    
                  ),
                  Divider(),
                  Container(
                     child:
                         Row(
                           children: [
                             Container(  padding: const EdgeInsets.only(
                         left:15.0,),
                               child:  ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Container(
          color: Colors.red,
          width: 50,
          height: 50,
  ),
        ), 
  ),
    
                             Container( padding: const EdgeInsets.only(
                         left:15.0,),
                               child: Column(
                       children: [
                               Text('GsT'),
                               Container(child: DropdownButton<String>(
  focusColor:Colors.white,
  value: _chosenValue,
  //elevation: 5,
  style: TextStyle(color: Colors.blue),
  iconEnabledColor:Colors.black,
  items: <String>[
    'Android',
    'IOS',
    'Flutter',
    'Node',
    'Java',
    'Python',
    'PHP',
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value,style:TextStyle(color:Colors.black),),
    );
  }).toList(),
  hint:Text(
    "₹ 10",
    style: TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w500),
  ),
  onChanged: (String value) {
    setState(() {
      _chosenValue = value;
    });
  },
),),
                               Text('Stock'),

                           ],
                         ),
                             ),
                             Container(
                               padding: const EdgeInsets.only(
                         left:100.0,),
                                child:   Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    TextButton(
      child: Row(
        children: [
          Text(
            "ADD",
            style: TextStyle(color: Colors.purple)
          ),Icon(Icons.add),
        ],
      ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: Colors.purple)
          )
        )
      ),
      onPressed: () => null
    ),])
                             ),

                       ],
                     ),
                  ),

                Divider(),
                 Container(
                     child:
                         Row(
                           children: [
                             Container(  padding: const EdgeInsets.only(
                         left:15.0,),
                               child:  ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Container(
          color: Colors.red,
          width: 50,
          height: 50,
  ),
        ), 
  ),
    
                             Container( padding: const EdgeInsets.only(
                         left:15.0,),
                               child: Column(
                       children: [
                               Text('GsT'),
                               Container(child: DropdownButton<String>(
  focusColor:Colors.white,
  value: _chosenValue,
  //elevation: 5,
  style: TextStyle(color: Colors.blue),
  iconEnabledColor:Colors.black,
  items: <String>[
    'Android',
    'IOS',
    'Flutter',
    'Node',
    'Java',
    'Python',
    'PHP',
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value,style:TextStyle(color:Colors.black),),
    );
  }).toList(),
  hint:Text(
    "₹ 10",
    style: TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w500),
  ),
  onChanged: (String value) {
    setState(() {
      _chosenValue = value;
    });
  },
),),
                               Text('Stock'),

                           ],
                         ),
                             ),
                             Container(
                               padding: const EdgeInsets.only(
                         left:100.0,),
                                child:   Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    TextButton(
      child: Row(
        children: [
          Text(
            "ADD",
            style: TextStyle(color: Colors.purple )
          ),Icon(Icons.add),
        ],
      ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: Colors.purple)
          )
        )
      ),
      onPressed: () => null
    ),])
                             ),

                       ],
                     ),
                  ),

                                           ])));
                                    
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
                            
                            

                         
                    ],
                  ),
                
                
                ),
            ),
              ],
            ), 
        ),
        
        )

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
