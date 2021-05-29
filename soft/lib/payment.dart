import 'package:flutter/material.dart';


class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
       appBar:AppBar(backgroundColor: Colors.white,
        title: Text('Add Received Payment',style: TextStyle(color: Colors.black
        ),),
        leading: Icon(Icons.arrow_back,color: Colors.black,),
        ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Container( 
            
            child: Column(
              children: [
                Padding(
                     padding: const EdgeInsets.only(top:10.0),
                     child: Container(  color: Colors.white,
                       child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left:15.0,top: 15.0,bottom: 15.0),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text('Received Payment #4', style: TextStyle(color: Colors.purple),),
                              Container(padding: const EdgeInsets.only(top:7.0),
                                child: Text('21 May 2021',style: TextStyle(color: Colors.grey.shade500),))
                            ],
                            ),
                          ),
                          Container(padding: const EdgeInsets.only(right:15.0),
                           child: Text('Edit',style: TextStyle(color: Colors.purple),),
                          ),
                          
                        ],
                  ),
                     ),
                   ),
                    Padding(
                     padding: const EdgeInsets.only(top:10.0),
                     child: Container(  
                      
                       color: Colors.white,
                       child: Container(padding: const EdgeInsets.only(left:15.0,right: 15.0,top: 10.0),
                         child: Column(
                           children: [
                             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                     Text('PARTY NAME',style: TextStyle(
                               fontWeight:FontWeight.bold
                             ), ),
                                      Container( padding: const EdgeInsets.only(left: 80.0),
                                        child: Text('Current Balence: ',style: TextStyle(color: Colors.grey.shade500),)),
                                  Text('₹ 12124',style: TextStyle(color: Colors.green),)
                              ],
                  ),
Container(height: 60.0,
  padding: const EdgeInsets.only(top: 10.0,bottom: 15.0),
                  child:TextField( 
                     decoration: InputDecoration(  
                        filled: true,
                    fillColor: Colors.grey.shade200,
                                           border:  InputBorder.none, 
                                         prefixIcon: Icon(Icons.person_outline),
                                           labelText: 'Name',
                                           hintText: 'Enter Name',  
                      ),  
                    ), ), 
                           ],
                         ),
                       ),
                     ),
                   ),
              
                Padding(
                     padding: const EdgeInsets.only(top:10.0),
                     child: Container(  
                      
                       color: Colors.white,
                       child: Container(padding: const EdgeInsets.only(left:15.0,right: 15.0,top: 10.0,bottom: 10.0),
                         child:
                             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                     Text('AMOUNT',style: TextStyle(
                               fontWeight:FontWeight.bold
                             ), ),
                                      Container(width: 250.0,
                                      height: 45.0,
                                        child: TextField( 
                     decoration: InputDecoration(  
                        //filled: true,
                   // fillColor: Colors.grey.shade200,
                                             border:  OutlineInputBorder(), 
                                           //prefixIcon: Icon(Icons.person_outline),
                                             labelText: '₹',
                                             hintText: 'Enter Amount',  
                      ),  
                    ),
                                      ),
                           ],
                         ),
                       ),
                     ),
                   ),

                  Padding(
                     padding: const EdgeInsets.only(top:10.0),
                     child: Container( 
                       color: Colors.white,
                       child: Container(padding: const EdgeInsets.only(left:15.0,right: 15.0,top: 10.0,bottom: 10.0),
                         child:Column(crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text('Invoice',style: TextStyle(
                               fontWeight:FontWeight.bold
                             ),),
                             Text('Settle outstanding Invoice with the above Payment',style: TextStyle(
                               color: Colors.grey.shade500
                             ),),
                             Container(padding: const EdgeInsets.only(top: 15.0,),
                               child: Row(
                                 children: [
                                   Container(
  height: 15,
  width: 15,
  decoration: BoxDecoration(
    border: Border.all(
      color: Colors.blue,
    ),
    borderRadius: BorderRadius.circular(2.0),
  ),
  // child: Center(
  //   child: Text('mrflutter.com'),
  // ),
),
                                
                                Container(padding: const EdgeInsets.only(left:15.0,),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('#H4'),
                                      Text('16 May 2021',style: TextStyle(color: Colors.grey.shade500),)
                                    ],
                                  ),
                                ),
                                Container(padding: const EdgeInsets.only(left:97.0,),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text('₹ 200'),
                                      Text('₹ 200 setted',style: TextStyle(color: Colors.green),),
                                      Text('₹ 20075 Remaining',style: TextStyle(color: Colors.red),)
                                    ],
                                  ),
                                )
                                
                                 ],
                               ),
                            
                             ),
                              Container(padding: const EdgeInsets.only(top: 15.0,),
                               child: Row(
                                 children: [
                                   Container(
  height: 15,
  width: 15,
  decoration: BoxDecoration(
    border: Border.all(
      color: Colors.purple,
    ),
    borderRadius: BorderRadius.circular(2.0),
  ),
  // child: Center(
  //   child: Text('mrflutter.com'),
  // ),
),
                                
                                Container(padding: const EdgeInsets.only(left:15.0,),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('#H4'),
                                      Text('16 May 2021',style: TextStyle(color: Colors.grey.shade500),)
                                    ],
                                  ),
                                ),
                                Container(padding: const EdgeInsets.only(left:97.0,),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text('₹ 200'),
                                      Text('₹ 200 setted',style: TextStyle(color: Colors.green),),
                                      Text('₹ 20075 Remaining',style: TextStyle(color: Colors.red),)
                                    ],
                                  ),
                                )
                                
                                 ],
                               ),
                            
                             ),
                             
                             
                           ],
                         )
                            
                       ),
                     ),
                   ),  
              
                 Padding(
                     padding: const EdgeInsets.only(top:10.0),
                     child: Container(  
                      
                       color: Colors.white,
                       child: Container(padding: const EdgeInsets.only(left:15.0,right: 15.0,top: 10.0,bottom: 10.0),
                         child:Column(crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text('PAYMENT MODE',style: TextStyle(
                               fontWeight:FontWeight.bold
                             ),),
                             Container(
                               padding: const EdgeInsets.only(top: 10.0,),
                               child: Row(
                                 children: [
                                    Container(height: 25.0,width: 70.0,
                                      child: FlatButton(
                                  shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
        ),
                                  color: Colors.grey.shade300,
                                  onPressed: (){}, child: Text('Cash',)),
                                    ),
                                   Container(height: 25.0,width: 90.0,
                                     padding: const EdgeInsets.only(left:5.0,),
                                     child: FlatButton(
                                  shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
        ),
                                  color: Colors.grey.shade300,
                                  onPressed: (){}, child: Text('Cheque',)),
                                   ),
                                   Container(height: 25.0,width: 80.0,
                                     padding: const EdgeInsets.only(left:5.0,),
                                     child: FlatButton(
                                  shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
        ),
                                  color: Colors.grey.shade300,
                                  onPressed: (){}, child: Text('Online',)),
                                   ),
                                 ],
                               ),
                             ),
                             Container(  padding: const EdgeInsets.only(top: 10.0,),
                               child: Row(
                                 children: [
                                   Icon(Icons.add_circle,color: Colors.purple,),
                                   Text('  Add Node/Description',style: TextStyle(
                               color: Colors.purple
                             ),)
                                 ],
                               ),
                             ),
                             Divider(),
                           ],
                         )
                             
                       ),
                     ),
                   ),
              ],
            ),
          ),
        ),
         Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            height: 60,
            width: double.infinity,
            color: Colors.white,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container( padding: const EdgeInsets.only(top:10.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('New Party Balence'),
                      Text('₹  13145',style: TextStyle(color: Colors.green),),
                    ],
                  )
                ),
               Container(
                   padding: const EdgeInsets.only(left:15.0),
                   child:
              SizedBox(
                width: 165.0,
                child: RaisedButton(onPressed: () {},child: Text("Save",),color: Colors.purple,textColor: Colors.white,)),
           
        )
                    
         
              ],
            ),
          ),
        ),
      ],),
    );
  }
}