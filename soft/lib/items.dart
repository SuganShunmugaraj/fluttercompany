import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:soft/category.dart';
import 'package:soft/config/upload_url.dart';
import 'package:soft/create_items.dart';
import 'package:http/http.dart' as http;
import 'package:soft/edit_items.dart';

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
    final response = await http.put(Uri.parse(BaseUrl.category+id),
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
      body: Stack(
              children: [ 
                 Column(
                        children: [
                          Container( padding: const EdgeInsets.only(top:40.0,left: 15.0,right: 15.0,bottom: 15.0),
                                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text('Items',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 17.0
                                                     ),),
                                                     Stack(
    children: [
      Container(
  width: 30,
  height: 30,
  child:
   Stack(
    children: [
      Icon(
        Icons.notifications,
        color: Colors.grey,
        size: 30,
      ),
      Container(
        width: 30,
        height: 30,
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(top: 2),
        child: Container(
          width: 9,
          height: 9,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
             // border: Border.all(color: Colors.white, width: 1)
             ),
         
        ),
      ),
    ],
  ),)
                 ],
  ),
                
                                                  ],
                                                ),
                                              ),
                                          Container(
                                           height: 40.0,
                                           width: 330.0,

   
  decoration: BoxDecoration(
    border: Border.all(color: Colors.grey
    ),
    borderRadius: BorderRadius.all(
        Radius.circular(5.0) 
    ),
  ),child: Row(mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(padding: const EdgeInsets.only(right: 5.0),
        child: Icon(Icons.search))
    ],
  ),),
                                 
                        ],
                      ),  
                    Container(padding: const EdgeInsets.only(top:120.0),
                      child: ListView.separated(
                                      itemCount: service.length,
                                      itemBuilder: (context, index) {
                                        return  SingleChildScrollView(
                  child: 
                        Container(
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                                 Container( padding: const EdgeInsets.only(top:15.0,left: 10.0),
                                   child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Container(
                  color: Colors.grey.shade500,
                  width: 50,
                  height: 50,
  ),
                ),
                                 ), 
                            
                               Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(service[index]['serviceName']),
                                      Text(service[index]['serviceSaleSellingPrice']),
                                     // Text('₹ 220')
                                    ],
                                ),
                            
             Container(padding: const EdgeInsets.only(left:70.0),
               child: IconButton(icon: Icon(Icons.edit), onPressed: (){
                                         Navigator.push(context,
                                      MaterialPageRoute(builder: (context) =>EditItems(
                                        items: this.service[index],
                                      )));
                                      }),
             ),
                                     IconButton(icon: Icon(Icons.delete), 
                                     onPressed: ()async{
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
                        ),
                       
                        // Container(
                        //    child: Column(
                        //      children: [
                        //        Text('Add Multiple items at once'),
                        //        GestureDetector(
                        //             onTap: (){

                        //             },
                        //             child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        //               children: [
                        //                 Icon(Icons.add,color: Colors.purple,),
                        //                 Text('Add Bulk Items',style: TextStyle(color:Colors.purple),)
                        //               ],
                        //             ),
                        //        ),
                        //      ],
                        //    ),
                        // ),
                      
                
                                      );
                                      }, separatorBuilder: (context, index) {
                                        return Divider();
                                       } 
                                       ),
                    ),
            
               Container(
                child: 
                Align(
                  alignment: Alignment.bottomLeft,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(padding: const EdgeInsets.only(left: 15.0),
                    child: SizedBox( 
                        child: RaisedButton(
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
                              color: Colors.tealAccent.shade700,
                              size: 20,
                            ),
                            Container(padding: const EdgeInsets.only(left:20.0,right:40.0),
                              child: Text(' Item',style: TextStyle(color: Colors.tealAccent.shade700,fontSize: 18.0),))
                          ],
                        ),
                        color: Colors.white,
                        //elevation: 0,
                      ),
                    ),
                  ),
                   
                   Container(padding: const EdgeInsets.only(right: 15.0),
                     child: SizedBox(
                       width: 165.0,
                        child: RaisedButton(
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
                              size: 20,
                            ),
                            Container(padding: const EdgeInsets.only(left:17.0),
                              child: Text('Category',
                              style: TextStyle(color: Colors.white,fontSize: 18.0,),
                              ),
                            )
                          ],
                        ),
                        color: Colors.tealAccent.shade700,
                        //elevation: 0,
                  ),
                     ),
                   ),
                ],
              ),
            ),
          ),
           ])     
         
    );
  }
}