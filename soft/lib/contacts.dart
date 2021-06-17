import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:soft/config/upload_url.dart';
import 'package:soft/edit.dart';
import 'package:soft/contact_detail.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Contacts extends StatefulWidget {
    
  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List contacts;
  Future getData() async {
    var response = await http.get(Uri.parse(BaseUrl.contacts),
        headers: {"Accept": "application/json"});
    this.setState(() {
   var contactsData = json.decode(response.body);
      contacts = contactsData['data'];
    });
   
  }
removeContacts(index,id)async{
 setState(() {
    contacts.remove(index);
    });
    var response = await http.delete(Uri.parse(BaseUrl.contacts + id),
        headers: {"Accept": "application/json"});
        print(response);
}

  @override
  void initState() {
   getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          contacts == null
              ? Container(
                  child: Center(child: CircularProgressIndicator()),
                ):Stack(
                   children: [
                      Column(
                        children: [
                          Container( padding: const EdgeInsets.only(top:40.0,left: 15.0,right: 15.0,bottom: 15.0),
                           child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text('Contacts',style: TextStyle(
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
      Container(padding: const EdgeInsets.only(top: 120.0),
        child: ListView.separated(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return  Slidable(
  actionPane: new SlidableBehindActionPane(),
  actionExtentRatio: 0.25,
  child: new Container(
    color: Colors.white,
    child:  
    ListTile(
          title: Container( 
                  child:GestureDetector(
                   onTap: (){
                    Navigator.push(context,
                     MaterialPageRoute(builder: (context) =>ContactDetailPage(
                     prod: contacts[index],
                     )));
                   },
                  child:Container( 
                   child: Row(
                   children: [
                   Column(crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                   Text(contacts[index]['userName']['firstName'],
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0),),
                   Text(contacts[index]['phone']['primaryContact'],
                    style: TextStyle(color: Colors.grey,
                   fontWeight: FontWeight.bold),)
                   ],
                    ),
                    ],
                 ),
                 ),
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
        context, MaterialPageRoute(
        builder: (context) => Edit(prod: contacts[index], )))
    ),
    new IconSlideAction(
      caption: 'Delete',
      color: Colors.tealAccent.shade700,
      icon: Icons.delete,
      onTap: ()async{
        await showDialog(context: context,builder:(_) => AlertDialog(
                 title: Text( 'Do you want Delete'),
                 actions: [
                  FlatButton(
                     onPressed:() {
                      Navigator.of(context, rootNavigator: true).pop(true);
                         }, child: Text('No',
                         style:TextStyle(
                           color:  Colors.tealAccent.shade700,
                                ),
                                                  )),
                            FlatButton(
                               onPressed:() {
                                    removeContacts(index,this.contacts[index]['_id']);
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
                                    builder: (context) => Edit(
                                        prod: null,
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