import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:soft/config/upload_url.dart';

class CreateItems extends StatefulWidget {
  CreateItems({
    this.items,
  });

  final Map items;

  @override
  _CreateItemsState createState() => _CreateItemsState();
}

class _CreateItemsState extends State<CreateItems> {
  String _chosenValue;
  Map subDetail ;
  List service ;
  List category;
  List subCategory;

  Future getData() async {
    var response = await http.get(Uri.parse(BaseUrl.service),
        headers: {"Accept": "application/json"});
    this.setState(() {
      var categoryData = json.decode(response.body);
      service = categoryData['data'];
    });
  }

  editContact(
    categoryDropDownId,
    subCategoryDropDownId,
    categoryDescription,
    serviceName,
    serviceSaleSellingPrice,
    _id,
  ) async {
    setState(() {
      
      this.widget.items['serviceCategory']['_id'] = categoryDropDownId;
      this.widget.items['serviceSubCategory']['_id'] = subCategoryDropDownId;
      this.widget.items['serviceSaleDescription'] = categoryDescription;
       this.widget.items['serviceName'] = serviceName;
        this.widget.items['serviceSaleSellingPrice'] = serviceSaleSellingPrice;
      this.widget.items['_id'] = _id;
    });
    
   // print( this.widget);
    print(categoryDropDownId);
    final response = await http.put(Uri.parse(BaseUrl.service + _id),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode( this.widget.items));
    var res = response.body;
    if (response.statusCode == 200) {
      print('sucess');
    } else {
      print("Error :" + res);
    }
  }

  addContact(
    categoryDescription,
    categoryDropDownId,
    serviceName,
    serviceSaleSellingPrice,
    subCategoryDropDownId,
  ) async {
   
    setState(() {
      this.subDetail = {
     'serviceCategory': { '_id': categoryDropDownId, },
        'serviceName': serviceName,
        'serviceSaleSellingPrice': serviceSaleSellingPrice,
        'serviceSaleDescription':categoryDescription,
      'serviceSubCategory': { '_id': subCategoryDropDownId, },
      };
      service.add(this.subDetail);
      print(this.subDetail);
    });
    final response = await http.post(Uri.parse(BaseUrl.service),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(this.subDetail));
    var res = response.body;

    if (response.statusCode == 200) {
      print('sucess');
    } else {
      print("Error :" + res);
    }
  }

  Future getCategory() async {
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
    if (this.widget.items != null) {
      setState(() {
        categoryDropDownName = this.widget.items['serviceCategory']['categoryName'].toString();
        subCategoryDropDownName = this.widget.items['serviceSubCategory']['subcategoryName'].toString();
        serviceName.text = this.widget.items['serviceName'];
        serviceSaleSellingPrice.text =this.widget.items['serviceSaleSellingPrice'];
        categoryDescription.text =this.widget.items['serviceSaleDescription'];
      });
    }

    getData();
    getCategory();
    getSubCategory();
    super.initState();
  }

  final categoryName = TextEditingController();
  final categoryDescription = TextEditingController();
  final subcategoryName = TextEditingController();
  final categoryid = TextEditingController();
  final serviceName = TextEditingController();
  final serviceSaleSellingPrice = TextEditingController();
  String categoryDropDownName = 'Select Category ';
   String categoryDropDownId = 'Select Category ';
   String subCategoryDropDownName = 'Select Category ';
   String subCategoryDropDownId = 'Select Category ';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Create New Item',
          style: TextStyle(color: Colors.black),
        ),
        leading:IconButton(
          icon: Icon(Icons.arrow_back,
          color: Colors.black,), 
          onPressed: (){
          Navigator.pop(context);
        })
      ),
      body: Stack(children: [
        SingleChildScrollView(
            child: Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                child: Text('Service Name')),
            Container(
              height: 40.0,
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: ' Service Name',
                ),
                controller: serviceName,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 15.0,
              ),
              child: Center(
                child: Container(
                    padding: const EdgeInsets.only( left: 15.0,),
                    height: 40.0,
                    width: 330.0,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Row(
                      children: [ 
                        DropdownButtonHideUnderline(
                          child: DropdownButton(
                            dropdownColor: Colors.tealAccent.shade700,
                            value: _chosenValue,
                            style: TextStyle(
                                color: Colors.white,
                                decorationColor: Colors.white),
                            items: this.category.map((pageon) {
                              return DropdownMenuItem(
                                value: pageon['_id'],
                                child: SizedBox(
                                  width: 280.0,
                                  child: Text(
                                    pageon['categoryName'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (values) {
                             
                            setState(() { 
                              List selectedcatagory;
                              selectedcatagory =  this.category.where((cat) => cat['_id'] == values).toList();
                            print(selectedcatagory[0]['categoryName']);
                              this.categoryDropDownName  = selectedcatagory[0]['categoryName'];
                              this.categoryDropDownId  = selectedcatagory[0]['_id'];
                            });
                            },
                            hint: Text(this.categoryDropDownName.toString(),
                                style: TextStyle(fontSize: 16.0,)),
                            icon: Icon(
                              Icons.arrow_drop_down,
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 15.0,
              ),
              child: Center(
                child: Container(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                    ),
                    height: 40.0,
                    width: 330.0,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Row(
                      children: [
                        DropdownButtonHideUnderline(
                          child: DropdownButton(
                            dropdownColor: Colors.tealAccent.shade700,
                            style: TextStyle(
                                color: Colors.white,
                                decorationColor: Colors.white),
                            items: this.subCategory.map((pagesubCategory) {
                              return DropdownMenuItem(
                                value: pagesubCategory['_id'],
                                child: SizedBox(
                                  width: 280.0,
                                  child: Text(
                                    pagesubCategory['subcategoryName'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                               List selectedSubcatagory;
                              selectedSubcatagory =  this.subCategory.where((subcat) => subcat['_id'] == value).toList();
                              this.subCategoryDropDownName  = selectedSubcatagory[0]['subcategoryName'];
                              this.subCategoryDropDownId  = selectedSubcatagory[0]['_id'];
                              });
                            },
                            hint: Text(this.subCategoryDropDownName.toString(),
                                style: TextStyle(
                                  fontSize: 16.0,
                                )),
                            icon: Icon(
                              Icons.arrow_drop_down,
                            ),
                          ),
                        ),
                      ],
                    )),
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
                  labelText: ' Description',
                  hintText: 'Description',
                ),
                controller: categoryDescription,
              ),
            ),
            DefaultTabController(
              length: 1,
              initialIndex: 0,
              child: Column(
                children: [
                  TabBar(
                    indicatorColor: Colors.tealAccent.shade700,
                    isScrollable: true,
                    unselectedLabelColor: Colors.black,
                    labelColor: Colors.tealAccent.shade700,
                    tabs: [
                      Tab(text: 'Pricing'),
                    ],
                  ),
                  Container(
                    height: 550,
                    child: TabBarView(children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15.0,
                                ),
                                child: Text('Sales Price')),
                            Container(
                              height: 40.0,
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0, top: 5.0),
                              child: TextField(
                                controller: serviceSaleSellingPrice,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  suffixIcon: Container(
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        focusColor: Colors.white,
                                        value: _chosenValue,
                                        //elevation: 5,
                                        style: TextStyle(color: Colors.blue),
                                        iconEnabledColor: Colors.black,
                                        items: <String>[
                                          'Android',
                                          'IOS',
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          );
                                        }).toList(),
                                        hint: Text(
                                          "Add Unit",
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
                                  ),
                                  labelText: ' ₹',
                                  hintText: 'Enter price',
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                left: 15.0,
                                right: 15.0,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Colors.tealAccent.shade700,
                                    size: 18,
                                  ),
                                  Text(
                                    'Add GST & Tax Details',
                                    style: TextStyle(
                                        color: Colors.tealAccent.shade700),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ]),
        )),
        Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                      width: 165.0,
                      child: RaisedButton(
                        onPressed: () {
                          if (this.widget.items != null) {
                            editContact(
                              categoryDropDownId,
                              subCategoryDropDownId,
                              categoryDescription.text,
                              serviceName.text,
                              serviceSaleSellingPrice.text,
                              this.widget.items['_id'],
                            );
                          } else {
                            addContact(
                              categoryDescription.text,
                              categoryDropDownId.toString(),
                              serviceName.text,
                              serviceSaleSellingPrice.text,
                              subCategoryDropDownId.toString(),
                            );
                          }
                          Navigator.pop(context);
                        },
                        child: Text("Save"),
                        color: Colors.tealAccent.shade700,
                        textColor: Colors.white,
                      )),
                ],
              ),
            )),
      ]),
    );
  }
}
