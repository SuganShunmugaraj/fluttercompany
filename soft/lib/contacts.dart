import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:soft/config/upload_url.dart';
import 'package:soft/edit.dart';

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

  @override
  void initState() {
   getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('Contacts')),
      body: Stack(
        children: [
          contacts == null
              ? Container(
                  child: Center(child: CircularProgressIndicator()),
                ):ListView.separated(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return Container( 
            child:GestureDetector(
                                onTap: (){
                                   Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>Edit(
                                  prod: contacts[index],
                                  )));
                                },
                                  child: Container(
                                  
                                padding: const EdgeInsets.only(top:15.0),
                                   
                                    child: Column(
                                      children: [
                                       Text(contacts[index]['userName']['firstName'])
                                      ],
                                    ),
                                  ),
                                ),
          );
        },separatorBuilder: (context, index) {
                  return Divider();
                },
        ),
        ]) 
    );
  }
}