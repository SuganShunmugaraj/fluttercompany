import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:soft/config/upload_url.dart';
import 'dart:convert';

class EditItems extends StatefulWidget {
  EditItems({
    this.items,
  });
  
  final Map items;
  @override
  _EditItemsState createState() => _EditItemsState();
}

class _EditItemsState extends State<EditItems> {
  String _chosenValue;
  Map subDetail={};
List category;
List subCategory;
editContacts(serviceName, serviceSaleSellingPrice,categoryDescription,subcategoryDescription,id)async{
   
    setState(() {
      this.subDetail={
        'serviceName': serviceName,
        'serviceSaleSellingPrice' : serviceSaleSellingPrice,
        'categoryDescription':categoryDescription,
        'subcategoryDescription' : subcategoryDescription,
 };
    
    }
    ); final response = await http.put(Uri.parse(BaseUrl.service+id),
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
  super.initState();
  this.drop=this.widget.items['serviceCategory']['categoryName'];
   this.title=this.widget.items['serviceSubCategory']['subcategoryName'];
  this.serviceName.text = this.widget.items['serviceName'];
  this.serviceSaleSellingPrice.text = this.widget.items['serviceSaleSellingPrice'];
  this.categoryDescription.text = this.widget.items['serviceCategory']['categoryDescription'];
  this.subcategoryDescription.text = this.widget.items['serviceSubCategory']['subcategoryDescription'];
  this.subcategoryid.text= this.widget.items['_id'];
  getCategory();
  getSubCategory();
   
  }
  final categoryName = TextEditingController();
  final categoryDescription = TextEditingController();
  final subcategoryName = TextEditingController();
  final subcategoryDescription = TextEditingController();
  final subcategoryid = TextEditingController();
  final serviceName = TextEditingController();
  final serviceSaleSellingPrice = TextEditingController();
 String drop = 'Select Category ';
 String title = 'Select Subcategory';
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar:AppBar(backgroundColor: Colors.white,
        title: Text('Edit Item',style: TextStyle(color: Colors.black

        ),),
        leading: Icon(Icons.arrow_back,color: Colors.black,),
        ),
        body: 
        Stack(
                  children:[ 
                    SingleChildScrollView(
            child: Container(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(padding: const EdgeInsets.only(left:15.0,top: 15.0),
                                                 child: Text('Service Name')),
                 Container(
                                                height: 40.0,
                                                padding: const EdgeInsets.only(left:15.0,right: 15.0,top: 5.0),
                                                child: TextField(
                                         decoration: InputDecoration(  
                                         border: OutlineInputBorder(),
                                         labelText: ' Service Name',
                      ),controller: serviceName,
                    ),   
                     ),
                 Container(
                   padding: const EdgeInsets.only(top: 15.0,),
                          child: Center(
                            child: Container(
                                padding: const EdgeInsets.only(
                                  left: 10.0,
                                ),
                                height: 40.0,
                                width: 330.0,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey,),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                                child: Row(
                                  children: [
                                  
                    DropdownButtonHideUnderline(
                       child: DropdownButton(
                         dropdownColor:Colors.tealAccent .shade700,
                            value:_chosenValue,
                              style: TextStyle( color: Colors.white,
                                decorationColor:Colors.white),
                              items:this.category.map((pageon) {
                                return DropdownMenuItem(
                                 value: pageon['categoryDescription'],
                                  child: SizedBox(
                                    width: 280.0,
                                    child: Text(pageon['categoryDescription'],
                                      style:TextStyle(color: Colors.white,
                                       fontSize:20.0,
                                    ),
                                    ),
                                  ),
                                  );
                                  }).toList(),
                                   onChanged: (value) {
                                    drop =value;            
                                     },
                                     hint: Text(
                                    this.drop.toString(),
                                      style:TextStyle(color: Colors.black,
                                       fontSize: 16.0,
                                       )),
                                        icon: Icon(Icons.arrow_drop_down,
                                       ),
                                      ),
                    ),
                                  ],
                                )),
                          ),
                        ),
                       Container(
                          padding: const EdgeInsets.only(top: 15.0,),
                          child: Center(
                            child: Container(
                                padding: const EdgeInsets.only(left: 10.0,),
                                height: 40.0,
                                width: 330.0,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey,),
                                  borderRadius:BorderRadius.all(Radius.circular(5.0)),
                                ),
                                child: Row(
                                  children: [
                                  DropdownButtonHideUnderline(
                               child: DropdownButton(dropdownColor:Colors.tealAccent.shade700,
                               value:_chosenValue,
                                style: TextStyle(color: Colors .white,
                                 decorationColor:Colors.white),
                                 items:this.subCategory.map((pagesubCategory) {
                                 return DropdownMenuItem(
                                 value: pagesubCategory['_id'],
                                 child: SizedBox(width: 280.0,
                                   child: Text(pagesubCategory['subcategoryName'],
                                     style:TextStyle(
                                    color: Colors.white,
                                    fontSize:20.0,
                                   ),
                                   ),
                                 ),
                                );
                              }).toList(),
                                onChanged: (value) {
                                  title =value;
                              },
                               hint: Text(this.title.toString(),
                               style:TextStyle(color: Colors.black,
                               fontSize: 16.0,
                                )),
                                 icon: Icon(Icons.arrow_drop_down,
                                ),
                                ),
                            ),
                         ],
                                )),
                          ),
                        ),
                        Container(
                padding:const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
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
           
            Container(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
                child: Text('Subcategory Description')),
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
                controller: subcategoryDescription,
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
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container( padding: const EdgeInsets.only(left:15.0,right: 15.0,),
                                                 child: Text('Sales Price')),
                                              Container(
                                                height: 40.0,
                                                padding: const EdgeInsets.only(left:15.0,right: 15.0,top: 5.0),
                                                child: TextField(  
                                         // obscureText: true,  
                                          controller: serviceSaleSellingPrice,
                                         decoration: InputDecoration(  
                                         border: OutlineInputBorder(), 
                                          suffixIcon:  Container(
                                            child: DropdownButtonHideUnderline(
                                       child: DropdownButton<String>(
  focusColor:Colors.white,
  value: _chosenValue,
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
                      ),  
                    ),    
                     ),
                     Container(padding: const EdgeInsets.only(left:15.0,right: 15.0,),
                       child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.tealAccent.shade700,
                          size: 18,
                        ),
                        Text('Add GST & Tax Details',style: TextStyle(color: Colors.tealAccent.shade700),)
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
            ),] ),
          )),
                   Align(
          alignment: Alignment.bottomLeft,
          child:Container( padding: const EdgeInsets.only(left:15.0,right: 15.0),
                   child:
          Row(mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(width: 165.0,
                 child: RaisedButton(onPressed: () {
                   editContacts(
                     serviceName.text, 
                     serviceSaleSellingPrice.text,
                     categoryDescription.text,
                     subcategoryDescription.text,
                     this.widget.items['_id']
                     );Navigator.pop(context);
                 },child: Text("Save"),color: Colors.tealAccent.shade700,textColor: Colors.white,)),
            ],
          ),
        )
          ),     
           ] ),
            );
  }
}

                                              