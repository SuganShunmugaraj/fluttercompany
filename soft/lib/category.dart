import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:soft/config/upload_url.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List category = [];
  List subCategory=[];
  bool displayCategory = false;
  Map clientDetail;
  Map subDetail;
  bool statusFAB = true;

  removeContacts(index, id) async {
    setState(() {
      this.category.removeAt(index);
    });
    var response = await http.delete(Uri.parse(BaseUrl.category + id),
        headers: {"Accept": "application/json"});
    print(response);
  }


  removeCategory(index, id) async {
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

editSubCategory(subcategoryDropDownId,subcategoryName, subcategoryDescription,id) async {
    setState(() {
      this.subDetail={
         'subcategoryCategory':{'_id': subcategoryDropDownId},
        'subcategoryName':subcategoryName,
        'subcategoryDescription':subcategoryDescription,
        '_id':id,
      };
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
saveSubCategory(subcategoryDropDownId,subcategoryName, subcategoryDescription) async {
    setState(() {
    this.subDetail={
      'subcategoryName':subcategoryName,
      'subcategoryDescription':subcategoryDescription,
       'subcategoryCategory': subcategoryDropDownId,
    };

    Map mockSubcategoryForUI = {
      'subcategoryName':subcategoryName,
      'subcategoryDescription':subcategoryDescription,
       'subcategoryCategory': {
         '_id': subcategoryDropDownId,
         'categoryName': this.subcategoryDropDownName   
       },
    };
    print(mockSubcategoryForUI);
   subCategory.add(mockSubcategoryForUI);
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
      this.subcategoryDropDownName = datas['subcategoryCategory']['categoryName'];
      this.subcategoryName.text = datas['subcategoryName'];
      this.subcategoryDescription.text = datas['subcategoryDescription'];
      this.subcategoryid.text = datas['_id'];
    } 
    // else {
    //   this.subcategoryName.text = '';
    //   this.subcategoryDescription.text = '';
    //   this.subcategoryid.text = '';
    // }
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
           height: 50.0,
           padding:const EdgeInsets.only(left: 15.0,right: 15.0,top: 5.0),
           child: TextField(
           decoration:InputDecoration(
            border:OutlineInputBorder(),
            labelText:'Name',
             ),
          controller: subcategoryName,
           ),
            ),
           Container(
           padding:const EdgeInsets.only(left:15.0,right:15.0,top:20.0),
            child: Text('Description')),
            Container(
              padding:const EdgeInsets.only(left: 15.0,right: 15.0,top: 5.0),
              child: TextField(
              maxLines: null,
               keyboardType:TextInputType.multiline,
                decoration:InputDecoration(
                border:OutlineInputBorder(),
                labelText:' Description',
                hintText:'Description',
                ),
                controller: subcategoryDescription,
              ),
              ),
         Container(
           padding: const EdgeInsets.only(top: 15.0,bottom: 15.0),
            child: Center(
              child: Container(padding: const EdgeInsets.only(left: 15.0,),
               height: 40.0,
               width: 330.0,
                decoration: BoxDecoration(
                 border: Border.all(color: Colors.grey,),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
             ),
             child: Row(
              children: [
             DropdownButtonHideUnderline(
             child: DropdownButton(
             dropdownColor:Colors.tealAccent.shade700,
             style: TextStyle(
              color: Colors .white,
            decorationColor:Colors.white),
              items: this.subCategory.map((value) { 
        return DropdownMenuItem(
              value: value['_id'],
              child: SizedBox(
              width: 280.0,
              child: Text( value['subcategoryCategory']['categoryName'],
              style:TextStyle(
              color: Colors.white,
              fontSize: 20.0,
         ),
        ),
        ),
        );
        }).toList(),
        onChanged: (value) {
        setState(() { 
          List selectedcatagory;
          selectedcatagory =  this.subCategory.where((subcat) => subcat['_id']== value).toList();
           this.subcategoryDropDownId  = selectedcatagory[0]['subcategoryCategory']['_id'];
           this.subcategoryDropDownName  = selectedcatagory[0]['subcategoryCategory']['categoryName'];
                            });
        },
         hint: Text(this.subcategoryDropDownName.toString(),
         style:TextStyle(
             fontSize:16.0,
           )),
            icon: Icon(Icons.arrow_drop_down,),
         ),
       ),
       
       ],
       )),
       ),
       ),
      Align(
       alignment: Alignment.bottomLeft,
        child: Container(padding: const EdgeInsets.only(left: 180.0,right:15.0),
         child: SizedBox(
         width: 165.0,
         child:RaisedButton(
           onPressed:() {
            if (types == "CREATES") {
             saveSubCategory(
             subcategoryDropDownId.toString(),
             subcategoryName.text,
             subcategoryDescription.text,
             );
             }else  if (types == "EDITS"){
             editSubCategory(
             subcategoryDropDownId.toString(),
             subcategoryName.text,
             subcategoryDescription.text,
             datas['_id'],);
             }
             subcategoryName.clear();
             subcategoryDescription.clear();
             subcategoryDropDownName='Select Category';
             Navigator.pop(context);
             },
             child:Text("Save",),
              color: Colors.tealAccent.shade700,
              textColor:Colors.white,
              )),
             )),
             ],
            ),
           ),
         );
                                                
  }

  createModal(context, type, data) {
    if (type == "EDIT") {
      this.categoryName.text = data['categoryName'];
      this.categoryDescription.text = data['categoryDescription'];
      this.categoryid.text = data['_id'];
    }
     else {
      this.categoryName.text='';
      this.categoryDescription.text='';
      this.categoryid.text='';
    }

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.only(left: 15.0,right: 15.0,),
                child: Text('Category Name')),
            Container(
              height: 50.0,
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
                controller: categoryName,
              ),
            ),
            Container(
                padding:const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
                child: Text('Description')),
            Container(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0,bottom: 15.0),
              child: TextField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: ' Description',
                  hintText: 'Description',
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
                        color: Colors.tealAccent.shade700,
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
  }

  Future getSubCategory() async {
    var response = await http.get(Uri.parse(BaseUrl.subCategory),
        headers: {"Accept": "application/json"});
    this.setState(() {
      var subCategoryData = json.decode(response.body);
      subCategory = subCategoryData['data'];
    });
  }

  @override
  void initState() {
    getData();
    getSubCategory();
    super.initState();
  }

  String subcategoryDropDownId = 'Select Category ';
  String subcategoryDropDownName = 'Select Category ';
  List fullinvoiceList;

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
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
        ),
        leading: IconButton(icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ), onPressed: (){
          Navigator.pop(context);
        })
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
                          indicatorColor: Colors.tealAccent.shade700,
                          isScrollable: true,
                          unselectedLabelColor: Colors.black,
                          labelColor: Colors.tealAccent.shade700,
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
                                  padding: const EdgeInsets.only(bottom: 30.0,top: 15.0),
                                  child: ListView.separated(
                                    itemCount: category.length,
                                    itemBuilder: (context, index) {
                   return GestureDetector(
                   onTap: ()async {
          await showModalBottomSheet(
          context: context,isScrollControlled: true,
          builder: (BuildContext context) {
             return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
          return this.createModal(context,'EDIT', this.category[index]);
         });});
       },
                   child: Slidable(
                  actionPane: new SlidableBehindActionPane(),
                  actionExtentRatio: 0.25,
                 child: new Container(
                 //color: Colors.white,
                     child: ListTile(
               title:SingleChildScrollView(
             child: Container(
                 child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                 Text("${category[index]['categoryName'][0].toUpperCase()}${category[index]['categoryName'].substring(1)}"),
                  Text("${category[index]['categoryDescription'][0].toUpperCase()}${category[index]['categoryDescription'].substring(1)}"),
                     ],
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
      onTap: ()async {
          await showModalBottomSheet(
          context: context,isScrollControlled: true,
          builder: (BuildContext context) {
             return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return this.createModal(context,'EDIT', this.category[index]);
         });});
       }
    ),
    new IconSlideAction(
      caption: 'Delete',
      color: Colors.tealAccent.shade700,
      icon: Icons.delete,
      onTap: () async {
      await showDialog(
       context: context,
        builder:(_) => AlertDialog(
         title: Text('Do you want Delete'),
          actions: [
           FlatButton(
            onPressed:() {
             Navigator.of(context, rootNavigator: true).pop(true);
            },
             child:Text('No',style:TextStyle(
                color: Colors.tealAccent.shade700,
              ),
              )),
              FlatButton(
                onPressed:() {
                     removeContacts(index,this.category[index]['_id']);
                      Navigator.of(context, rootNavigator: true).pop(true);
                },
                child:Text('Yes', style: TextStyle(
                  color:Colors.tealAccent.shade700,
                 ),
                 ))
                 ],
                 ));
                }),
   
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
              child: Container(padding: const EdgeInsets.only(left: 280.0, bottom: 10.0),
                child: SizedBox(
                  width: 60.0,
                   child: FloatingActionButton(
                    backgroundColor: Colors.tealAccent.shade700,
                     onPressed: () {
                     showModalBottomSheet(
                      context: context,isScrollControlled: true,
                      builder:(BuildContext context) {
             return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                       return this.createModal(context, 'CREATE', null);
                     });});
                      },
                      child: Icon(Icons.add),
                       ),
                      )),
                    ),
                       ]),
               Stack(children: [
                Container(padding: const EdgeInsets.only(top: 15.0),
                 child: ListView.separated(
                  itemCount: subCategory.length,
                  itemBuilder: (context, index) {
                   return GestureDetector(
                     onTap: ()async {
      await showModalBottomSheet(
         context: context,isScrollControlled: true,
         builder: (BuildContext context) {
             return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
         return this.createSubModal(context,'EDITS', this.subCategory[index]);
       }
        );});
       },
                      child: Slidable(
                       actionPane: new SlidableBehindActionPane(),
                       actionExtentRatio: 0.25,
                       child: new Container(
                       //color: Colors.white,
                       child: ListTile(
                       title:SingleChildScrollView(
                       child:  Container(
                         child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [ 
                        Text("${subCategory[index]['subcategoryName'][0].toUpperCase()}${subCategory[index]['subcategoryName'].substring(1)}"),
                        Text("${subCategory[index]['subcategoryCategory']['categoryName'][0].toUpperCase()}${subCategory[index]['subcategoryCategory']['categoryName'].substring(1)}"),
                        ],
                      ),
                  ),),
                ),
    ),
    secondaryActions: <Widget>[
    new IconSlideAction(
      caption: 'Edit',
      color: Colors.grey,
      icon: Icons.more_horiz,
      onTap: ()async {
      await showModalBottomSheet(
         context: context,isScrollControlled: true,
         builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
         return this.createSubModal(context,'EDITS', this.subCategory[index]);
       }
        );});
       }
    ),
    new IconSlideAction(
      caption: 'Delete',
      color: Colors.tealAccent.shade700,
      icon: Icons.delete,
      onTap: () async {
        await showDialog(
         context: context,
         builder:(_) => AlertDialog(
         title: Text('Do you want Delete'),
         actions: [
          FlatButton(
          onPressed:() {
          Navigator.of(context, rootNavigator: true).pop(true);
           },
           child:Text('No',style:TextStyle(
             color:Colors.tealAccent.shade700,
           ),
          )),
           FlatButton(
           onPressed:() {
            removeCategory(index,this.subCategory[index]['_id']);
             Navigator.of(context, rootNavigator: true).pop(true);
           },
             child:Text('Yes',style:TextStyle(
              color:Colors.tealAccent.shade700,
              ),
            ))
            ],
            ));
            } 
             ),  
  ], ),
                   );
          },
          separatorBuilder: (context, index) {
           return Divider();
         },
         ),
           ),
         Align(
          alignment: Alignment.bottomLeft,
          child: Container(padding: const EdgeInsets.only(left: 280.0, bottom: 10.0),
          child: SizedBox(
            width: 60.0,
          child: FloatingActionButton(
           backgroundColor: Colors.tealAccent.shade700,
           onPressed: () {
           showModalBottomSheet(
           context: context,isScrollControlled: true,
           builder: (BuildContext context) {
             return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
           return this.createSubModal(context, 'CREATES', null);
              });
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
