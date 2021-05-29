import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:soft/config/upload_url.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List category = [];
  List subCategory;
  bool displayCategory = false;
  Map clientDetail;
  
  Map subDetail={};
  bool statusFAB = true;

  removeContacts(index, id) async {
    print(index);
    setState(() {
      this.category.removeAt(index);
    });
    var response = await http.delete(Uri.parse(BaseUrl.category + id),
        headers: {"Accept": "application/json"});
    print(response);
  }

  editContacts(index) async {
    print(index);
  }

  removeCategory(index, id) async {
    print(index);
    setState(() {
      this.subCategory.removeAt(index);
    });
    var response = await http.delete(Uri.parse(BaseUrl.subCategory + id),
        headers: {"Accept": "application/json"});
    print(response);
  }

  saveCategory(categoryName, categoryDescription) async {
    setState(() {
      this.clientDetail = {
        'categoryName': categoryName,
        'categoryDescription': categoryDescription,
      };
      category.add(clientDetail);
    });
    final response = await http.post(Uri.parse(BaseUrl.category),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(this.clientDetail));
    var res = response.body;

    if (response.statusCode == 200) {
      print('sucess');
    } else {
      print("Error :" + res);
    }
  }

editSubCategory(subcategoryName, subcategoryDescription,id) async {
    setState(() {
      this.subDetail['subcategoryName']=subcategoryName;
      this.subDetail['subcategoryDescription']=subcategoryDescription;
      
     
    });
    final response = await http.put(Uri.parse(BaseUrl.subCategory+id),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(this.subDetail));
    var res = response.body;

    if (response.statusCode == 200) {
      print('sucess');
    } else {
      print("Error :" + res);
    }
  }


editCategory(categoryName, categoryDescription,id) async {
    setState(() {
      this.clientDetail = {
        'categoryName': categoryName,
        'categoryDescription': categoryDescription,
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



  saveSubCategory(subcategoryName, subcategoryDescription) async {
    setState(() {
    this.subDetail['subcategoryName'] = subcategoryName;
    this.subDetail['subcategoryDescription']= subcategoryDescription;
   subCategory.add(subDetail);
       print('.................');
      print(subDetail);
      print(jsonEncode(this.subDetail));
      print('.................');
    });
    final response = await http.post(Uri.parse(BaseUrl.subCategory),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(this.subDetail));
    var res = response.body;

    if (response.statusCode == 200) {
      print('sucess');
    } else {
      print("Error :" + res);
    }
  }
  
  createSubModal(context,types,datas){
    if (types == "EDITS") {
      this.subcategoryName.text = datas['subcategoryName'];
      this.subcategoryDescription.text = datas['subcategoryDescription'];
      this.subcategoryid.text = datas['_id'];
    } else {
      this.subcategoryName.text = '';
      this.subcategoryDescription.text = '';
      this.subcategoryid.text = '';
    }
    return  SingleChildScrollView(
                    child: Container(
                                                      padding:const EdgeInsets.only(top: 15.0),
                                                      child: Column(
                                                        crossAxisAlignment:CrossAxisAlignment.start,
                                                        children: [
                                                          Container(
                                                              padding:const EdgeInsets.only(left: 15.0,right: 15.0,),
                                                              child: Text('Sub Category Name')),
                                                          Container(
                                                            height: 40.0,
                                                            padding:const EdgeInsets.only(left: 15.0,right: 15.0,top: 5.0),
                                                            child: TextField(
                                                              decoration:InputDecoration(
                                                                border:OutlineInputBorder(),
                                                                labelText:'Name',
                                                                hintText:'Enter Name',
                                                              ),
                                                              controller: subcategoryName,
                                                            ),
                                                          ),
                                                          Container(
                                                              padding:const EdgeInsets.only(left:15.0,right:15.0,top:20.0),
                                                              child: Text('Discription')),
                                                          Container(
                                                            padding:const EdgeInsets.only(left: 15.0,right: 15.0,top: 5.0),
                                                            child: TextField(
                                                              maxLines: null,
                                                              keyboardType:TextInputType.multiline,
                                                              decoration:InputDecoration(
                                                                border:OutlineInputBorder(),
                                                                labelText:' Discription',
                                                                hintText:'Discription',
                                                              ),
                                                              controller:
                                                                  subcategoryDescription,
                                                            ),
                                                          ),
                                                          Container(
                                                            child:DropdownButton(
                                                              dropdownColor:Colors.tealAccent.shade700,
                                                              value:_chosenValue,
                                                              style: TextStyle(
                                                                  color: Colors .white,
                                                                  decorationColor:Colors.white),
                                                              items: this.category.map((
                                                                  value) {                                                               return DropdownMenuItem(
                                                                  value: value['_id'],
                                                                  child: Text( value['categoryName'],
                                                                    style:TextStyle(
                                                                      color: Colors.white,
                                                                      fontSize: 20.0,
                                                                    ),
                                                                  ),
                                                                );
                                                              }).toList(),
                                                              onChanged: (value) {
                                                                print(this.subDetail);
                                                                this.subDetail['subcategoryCategory'] = value;
                                                                print(this.subDetail);
                                                              },
                                                              hint: Text(
                                                                  this.drop.toString(),
                                                                  style:TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize:20.0,
                                                                  )),
                                                              icon: Icon(
                                                                Icons.arrow_drop_down,
                                                                color: Colors.white,
                                                              ),
                                                            ),
                                                          ),
                                                          Align(
                                                              alignment: Alignment.bottomLeft,
                                                              child: Container(
                                                                padding: const EdgeInsets.only(left: 180.0,right:15.0),
                                                                child: SizedBox(
                                                                    width: 165.0,
                                                                    child:RaisedButton(
                                                                      onPressed:() {
                                                                         if (types == "CREATES") {
                                                                           saveSubCategory(
                                                                          subcategoryName.text,
                                                                          subcategoryDescription.text,
                                                                          
                                                                        );
                                                                        }else  if (types == "EDITS"){
                                                                            editSubCategory(
                                                                              subcategoryName.text,
                                                                          subcategoryDescription.text,
                                                                          datas['_id'],);
                                                                        }
                                                                        subcategoryName.clear();
                                                                        subcategoryDescription.clear();
                                                                        Navigator.pop(context);
                                                                      },
                                                                      child:
                                                                          Text("Save", ),
                                                                      color: Colors.purple,
                                                                      textColor:Colors.white,
                                                                    )),
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                
  }

  createModal(context, type, data) {
    print(data);

    if (type == "EDIT") {
      this.categoryName.text = data['categoryName'];
      this.categoryDescription.text = data['categoryDescription'];
      this.categoryid.text = data['_id'];
    } else {
      this.categoryName.text = '';
      this.categoryDescription.text = '';
      this.categoryid.text = '';
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
                controller: categoryName,
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
                  labelText: ' Discription',
                  hintText: 'Discription',
                ),
                controller: categoryDescription,
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
                          if (type == "CREATE") {
                            saveCategory(
                              categoryName.text,
                              categoryDescription.text,
                            );
                          }else  if (type == "EDIT"){
                            editCategory(
                              categoryName.text,
                              categoryDescription.text,
                               data['_id'],
                            );
                          }

                          categoryName.clear();
                          categoryDescription.clear();
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

  Future getData() async {
    var response = await http.get(Uri.parse(BaseUrl.category),
        headers: {"Accept": "application/json"});
    this.setState(() {
      var categoryData = json.decode(response.body);
      category = categoryData['data'];
    });
    print(category);
  }

  Future getSubCategory() async {
    var response = await http.get(Uri.parse(BaseUrl.subCategory),
        headers: {"Accept": "application/json"});
    this.setState(() {
      var subCategoryData = json.decode(response.body);
      subCategory = subCategoryData['data'];
    });
    print(subCategory);
  }

  @override
  void initState() {
    getData();
    getSubCategory();
    super.initState();
  }

  String _chosenValue;
  String drop = 'Select Category ';
  List fullinvoiceList;
  List _invoice;

  final categoryName = TextEditingController();
  final categoryDescription = TextEditingController();
  final subcategoryName = TextEditingController();
  final subcategoryDescription = TextEditingController();
  final categoryid = TextEditingController();
  final subcategoryid = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Category',
          style: TextStyle(color: Colors.black),
        ),
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(
              Icons.settings,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          category == null
              ? Container(
                  child: Center(child: CircularProgressIndicator()),
                )
              : SingleChildScrollView(
                  child: 
                  DefaultTabController(
                      length: 2,
                      initialIndex: 0,
                      child: Column(children: [
                        TabBar(
                          indicatorColor: Colors.purple,
                          isScrollable: true,
                          unselectedLabelColor: Colors.black,
                          labelColor: Colors.purple,
                          tabs: [
                            Tab(text: 'Category'),
                            Tab(text: 'Sub Category'),
                          ],
                        ),
                        Container(
                          height: 550,
                          child: TabBarView(
                            children: [
                              Stack(children: [
                                Container(
                                  padding: const EdgeInsets.only(bottom: 30.0,),
                                  child: ListView.separated(
                                    itemCount: category.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding: const EdgeInsets.only(bottom: 15.0, top: 10.0),
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    padding:const EdgeInsets.only(left: 15.0),
                                                    child: Text('Name : ' +(category[index]['categoryName']))),
                                                Container(
                                                    padding:const EdgeInsets.only(left: 15.0),
                                                    child: Text('Description : ' +category[index]['categoryDescription'])),
                                                    
                                              ],
                                            ),
                                            Padding(
                                              padding:const EdgeInsets.all(8.0),
                                              child: IconButton(
                                                  icon: Icon(Icons.delete),
                                                  onPressed: () async {
                                                    await showDialog(
                                                        context: context,
                                                        builder:
                                                            (_) => AlertDialog(
                                                                  title: Text(
                                                                      'Do you want Delete'),
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
                                                                          removeContacts(
                                                                              index,
                                                                              this.category[index]['_id']);
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
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: IconButton(
                                                  icon: Icon(Icons.edit),
                                                  onPressed: () async {
                                                    await showModalBottomSheet(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return this
                                                              .createModal(context,'EDIT', this.category[index]);
                                                        });
                                                  }),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return Divider();
                                    },
                                  ),
                                ),
                                //............................................................................
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 280.0, bottom: 10.0),
                                      child: SizedBox(
                                        width: 60.0,
                                        child: FloatingActionButton(
                                          backgroundColor: Colors.purple,
                                          onPressed: () {
                                            showModalBottomSheet(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return this.createModal(
                                                      context, 'CREATE', null);
                                                });
                                          },
                                          child: Icon(Icons.add),
                                        ),
                                      )),
                                ),
                              ]),
                              Stack(children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                    bottom: 30.0,
                                  ),
                                  child: ListView.separated(
                                    itemCount: subCategory.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding: const EdgeInsets.only(
                                            bottom: 15.0, top: 10.0),
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15.0),
                                                    child: Text('Name : ' +
                                                        (subCategory[index][
                                                            'subcategoryName']))),
                                                // Container(padding:const EdgeInsets.only(left: 15.0),
                                                //     child: Text('Description : ' +subCategory[index]['subcategoryDescription'])),
                                                     
                                                     Container(padding:const EdgeInsets.only(left: 15.0),
                                                    child: Text('Dropdown : ' + subCategory[index]['subcategoryCategory']['categoryName'])),
                                               
                                              ],
                                            ),
                                            Padding(padding:const EdgeInsets.all(8.0),
                                              child: IconButton(
                                                  icon: Icon(Icons.delete),
                                                  onPressed: () async {
                                                    await showDialog(
                                                        context: context,
                                                        builder:
                                                            (_) => AlertDialog(
                                                                  title: Text(
                                                                      'Do you want Delete'),
                                                                  actions: [
                                                                    FlatButton(
                                                                        onPressed:() {
                                                                          Navigator.of(context, rootNavigator: true).pop(true);
                                                                        },
                                                                        child:
                                                                            Text('No',
                                                                            style:TextStyle(color:Colors.tealAccent.shade700,
                                                                          ),
                                                                        )),
                                                                    FlatButton(
                                                                        onPressed:() {
                                                                          removeCategory(index,this.subCategory[index]['_id']);
                                                                          Navigator.of(context, rootNavigator: true).pop(true);
                                                                        },
                                                                        child:
                                                                            Text('Yes',style:
                                                                              TextStyle(
                                                                            color:Colors.tealAccent.shade700,
                                                                          ),
                                                                        ))
                                                                  ],
                                                                ));
                                                  }),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: IconButton(
                                                  icon: Icon(Icons.edit),
                                                  onPressed: () async {
                                                    await showModalBottomSheet(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return this
                                                              .createSubModal(context,'EDITS', this.subCategory[index]);
                                                        });
                                                  }),
                                            ),


                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
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
                                          backgroundColor: Colors.purple,
                                          onPressed: () {
                                            showModalBottomSheet(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return this.createSubModal(
                                                      context, 'CREATES', null);
                                                 
                                                });
                                          },
                                          child: Icon(Icons.add),
                                        ),
                                      )),
                                ),
                              ]),
                            ],
                          ),
                        ),
                      ])))
       
        ],
      ),
    );
  }
}
