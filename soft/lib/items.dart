import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:soft/category.dart';
import 'package:soft/config/upload_url.dart';
import 'package:soft/create_items.dart';
import 'package:http/http.dart' as http;

class Items extends StatefulWidget {
  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {


String _chosenValue;
List service;
Map clientDetail;


removeContacts(index, id) async {
    setState(() {
    service.remove(index);
    });
    var response = await http.delete(Uri.parse(BaseUrl.service + id),
        headers: {"Accept": "application/json"});
    print(response);
  }
  Future getData() async {                                 
    var response = await http.get(Uri.parse(BaseUrl.service),
        headers: {"Accept": "application/json"});
    this.setState(() {
      var categoryData = json.decode(response.body);
      service = categoryData['data'];
    });
  }

  editCategory(serviceName, serviceSaleSellingPrice,id) async {
    setState(() {
      this.clientDetail = {
        'serviceName': serviceName,
        'serviceSaleSellingPrice': serviceSaleSellingPrice,
      };
     
    });
    final response = await http.put(Uri.parse(BaseUrl.service+id),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(this.clientDetail));
    var res = response.body;

    if (response.statusCode == 200) {
      print('sucess');
    } else {
      print("Error :" + res);
    }
  }




 createModal(context, type, data) {
    print(data);

    if (type == "EDIT") {
      this.serviceName.text = data['serviceName'];
      this.serviceSaleSellingPrice.text = data['serviceSaleSellingPrice'];
      this.serviceId.text = data['_id'];
    } else {
      this.serviceName.text = '';
      this.serviceSaleSellingPrice.text = '';
      this.serviceId.text = '';
    }

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                ),
                child: Text('Category Name')),
            Container(
              height: 40.0,
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'Enter Name',
                ),
                controller: serviceName,
              ),
            ),
            Container(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
                child: Text('Description')),
            Container(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
              child: TextField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: ' Price',
                  hintText: 'Enter Price',
                ),
                controller: serviceSaleSellingPrice,
              ),
            ),
           
            Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: const EdgeInsets.only(left: 180.0, right: 15.0),
                  child: SizedBox(
                      width: 165.0,
                      child: RaisedButton(
                        onPressed: () {
                          if (type == "EDIT"){
                            editCategory(
                              serviceName.text,
                              serviceSaleSellingPrice.text,
                               data['_id'],
                            );
                          }

                          serviceName.clear();
                          serviceSaleSellingPrice.clear();
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Save",
                        ),
                        color: Colors.purple,
                        textColor: Colors.white,
                      )),
                )),
          ],
        ),
      ),
    );
  }

@override
  void initState() {
    getData();
    super.initState();
  }
  
 final serviceName = TextEditingController();
 final serviceSaleSellingPrice = TextEditingController();
final serviceId = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
        leading:  Container(padding: const EdgeInsets.only(left:15.0,top: 18.0),
          child: Text('Items',
          style: TextStyle(color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16.0
              ),),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:15.0),
            child: Row(
              children: [
                Icon(Icons.search,color: Colors.purple,),
                Icon(Icons.settings,color: Colors.purple,),
              ],
            ),
          )
        ],
        ),
        body: 
              Stack(
                              children: [
                               ListView.separated(
                                    itemCount: service.length,
                                    itemBuilder: (context, index) {
                                      return  SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FlatButton(
                                  shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
        ),
                                  color: Colors.grey.shade300,
                                  onPressed: (){}, child: Text('Low Stock')),
                             
                               Container(child:  DropdownButton<String>(
  focusColor:Colors.white,
  value: _chosenValue,
  //elevation: 5,
  style: TextStyle(color: Colors.blue),
  iconEnabledColor:Colors.black,
  items: <String>[
    '60a8e247fa336a24a0a2c456'
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value,style:TextStyle(color:Colors.black),),
    );
  }).toList(),
  hint:Text(
    "Select Category",
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
],
                          ),
                        ),
                      Divider(),

                      Container(
                        child: Row(
                          children: [
                              Container(  padding: const EdgeInsets.only(
                                   left:15.0,),
                                         child:  ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Container(
                  color: Colors.grey.shade500,
                  width: 50,
                  height: 50,
  ),
                ), ),
                            Container(padding: const EdgeInsets.only(left:8.0),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(service[index]['serviceName']),
                                    Text(service[index]['serviceSaleSellingPrice']),
                                   // Text('₹ 220')
                                  ],
                              ),
                            ),
                             Container(padding: const EdgeInsets.only(left:80.0,),
                              child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                   
                                  IconButton(icon: Icon(Icons.edit), onPressed: (){
                                     showModalBottomSheet(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return this.createModal(context,'EDIT', this.service[index]);
                                                        
                                                });
                                          
                                      
                                        
                                  }),
                                   IconButton(icon: Icon(Icons.delete), onPressed: ()async{
                                    await showDialog(context: context,builder:
                                                            (_) => AlertDialog(
                                                                  title: Text( 'Do you want Delete'),
                                                                  actions: [
                                                                    FlatButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context, rootNavigator: true)
                                                                              .pop(true);
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          'No',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.tealAccent.shade700,
                                                                          ),
                                                                        )),
                                                                    FlatButton(
                                                                        onPressed:
                                                                            () {
                                                                            removeContacts(index,this.service[index]['_id']);
                                                                          Navigator.of(context, rootNavigator: true)
                                                                              .pop(true);
                                                                               
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          'Yes',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.tealAccent.shade700,
                                                                          ),
                                                                        ))
                                                                  ],
                                                                ));
                                   
                                  }),
                                   
                                  ],
                              ),
                            )
                          ],
                        ),
                      ),
                     
                      Container(
                         child: Column(
                           children: [
                             Text('Add Multiple items at once'),
                             GestureDetector(
                                  onTap: (){

                                  },
                                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add,color: Colors.purple,),
                                      Text('Add Bulk Items',style: TextStyle(color:Colors.purple),)
                                    ],
                                  ),
                             ),
                           ],
                         ),
                      ),
                    
                      ],
                    ),
                  ),
                                    );
                                    }, separatorBuilder: (context, index) {
                                      return Divider();
                                     } 
                                     ),
            
               Container(
                child: 
                Align(
                  alignment: Alignment.bottomLeft,
            child: Container(
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                     shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
        ),
                    onPressed: () {
                    Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>CreateItems(
                                  )));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.add_circle,
                          color: Colors.white,
                          size: 18,
                        ),
                        Text('Create New Item',style: TextStyle(color: Colors.white),)
                      ],
                    ),
                    color: Colors.purple,
                    //elevation: 0,
                  ),
                   RaisedButton(
                     shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
        ),
                    onPressed: () {
                    Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>Category(
                                   
                                  )));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.add_circle,
                          color: Colors.white,
                          size: 18,
                        ),
                        Text('Create Category/Sub Category',
                        style: TextStyle(color: Colors.white,fontSize: 8.0,fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    color: Colors.purple,
                    //elevation: 0,
                  ),
                ],
              ),
            ),
          ),
              ),
      
                              ])     
         
    );
  }
}