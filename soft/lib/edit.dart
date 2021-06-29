import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:soft/config/upload_url.dart';
import 'package:soft/string.dart';

class Edit extends StatefulWidget {
  Edit({
    this.prod,
  });

  final Map prod;

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  bool displayForm = false;
  List contactPersonList = [];
  String pageType;
  List addItems = [];
  Map createItems;

  removeContact(i) {
    setState(() {
      this.widget.prod['contactPerson'].removeAt(i);
    });
  }

  removeContacts(k) {
    setState(() {
      this.widget.prod['uploadDocument'].removeAt(k);
    });
  }

  textChange(){
    if(this.widget.prod!=null){
      return 'Update';
    }else{
      return 'Create';
    }
  }

  addContact(
    emailAddress,
    mobile,
  ) {
    setState(() {
      final value = {
        'emailAddress': emailAddress,
        'mobile': mobile,
      };
      if (this.widget.prod != null) {
        this.widget.prod['contactPerson'].add(value);
      }else{
         this.contactPersonList.add(value);
      }
    });
  }

  final salutation = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final companyName = TextEditingController();
  final contactEmail = TextEditingController();
  final primaryContact = TextEditingController();
  final secondarycontact = TextEditingController();
  final website = TextEditingController();
  final facebook = TextEditingController();
  final openingBalance = TextEditingController();
  final twitter = TextEditingController();
  final attention = TextEditingController();
  final countryRegion = TextEditingController();
  final street1 = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final zipCode = TextEditingController();
  final phone1 = TextEditingController();
  final fax = TextEditingController();
  final cfirstName = TextEditingController();
  final clastName = TextEditingController();
  final emailAddress = TextEditingController();
  final mobile = TextEditingController();
  final workPhone = TextEditingController();
  final remarkstext = TextEditingController();
  final name = TextEditingController();
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    setState(() {
      if (this.widget.prod != null) {
        this.selectName = this.widget.prod['userName']['salutation']['name'];
        this.firstName.text = this.widget.prod['userName']['firstName'];
        this.lastName.text = this.widget.prod['userName']['lastName'];
        this.companyName.text = this.widget.prod['companyName'];
        this.contactEmail.text = this.widget.prod['contactEmail'];
        this.primaryContact.text = this.widget.prod['phone']['primaryContact'];
        this.secondarycontact.text =
            this.widget.prod['phone']['secondarycontact'];
        this.website.text = this.widget.prod['website'];
        this.facebook.text = this.widget.prod['otherDetails']['facebook'];
        this.openingBalance.text =
            this.widget.prod['otherDetails']['openingBalance'];
        this.twitter.text = this.widget.prod['otherDetails']['twitter'];
        this.attention.text = this.widget.prod['billingAddress']['attention'];
        this.countryRegion.text =
            this.widget.prod['billingAddress']['countryRegion'];
        this.street1.text = this.widget.prod['billingAddress']['Street1'];
        this.city.text = this.widget.prod['billingAddress']['city'];
        this.state.text = this.widget.prod['billingAddress']['state'];
        this.zipCode.text = this.widget.prod['billingAddress']['zipCode'];
        this.phone1.text = this.widget.prod['billingAddress']['phone1'];
        this.fax.text = this.widget.prod['billingAddress']['fax'];
        this.remarkstext.text = this.widget.prod['remarks']['remarkstext'];
      }
    });
  }

  updateDetails(
      firstName,
      lastName,
      companyName,
      contactEmail,
      primaryContact,
      secondarycontact,
      website,
      facebook,
      openingBalance,
      twitter,
      attention,
      countryRegion,
      street1,
      city,
      state,
      zipCode,
      phone1,
      fax,
      remarkstext,
      _id) async {
    setState(() {
      this.widget.prod['userName']['firstName'] = firstName;
      this.widget.prod['userName']['lastName'] = lastName;
      this.widget.prod['companyName'] = companyName;
      this.widget.prod['phone']['secondarycontact'] = secondarycontact;
      this.widget.prod['website'] = website;
      this.widget.prod['otherDetails']['facebook'] = facebook;
      this.widget.prod['otherDetails']['openingBalance'] = openingBalance;
      this.widget.prod['otherDetails']['twitter'] = twitter;
      this.widget.prod['billingAddress']['attention'] = attention;
      this.widget.prod['billingAddress']['countryRegion'] = countryRegion;
      this.widget.prod['billingAddress']['Street1'] = street1;
      this.widget.prod['billingAddress']['city'] = city;
      this.widget.prod['billingAddress']['state'] = state;
      this.widget.prod['billingAddress']['zipCode'] = zipCode;
      this.widget.prod['billingAddress']['phone1'] = phone1;
      this.widget.prod['billingAddress']['fax'] = fax;
      this.widget.prod['remarks']['remarkstext'] = remarkstext;
      this.widget.prod["_id"] = _id;
    });
    final response = await http.put(Uri.parse(BaseUrl.contacts + _id),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(this.widget.prod));
    var res = response.body;
    if (response.statusCode == 200) {
      print('sucess');
    } else {
      print("Error :" + res);
    }
  }

  createDetails(
    firstName,
    lastName,
    companyName,
    contactEmail,
    primaryContact,
    secondarycontact,
    website,
    facebook,
    openingBalance,
    twitter,
    attention,
    countryRegion,
    street1,
    city,
    state,
    zipCode,
    phone1,
    fax,
    remarkstext,
  ) async {
    setState(() {
      this.createItems = {
        'userName': {
          "salutation": {"name": selectName},
          'firstName': firstName,
          'lastName': lastName
        },
        'companyName': companyName,
        'contactEmail': contactEmail,
        'phone': {
          'primaryContact': primaryContact,
          'secondarycontact': secondarycontact
        },
        'website': website,
        'otherDetails': {
          'facebook': facebook,
          'openingBalance': openingBalance,
          'twitter': twitter,
        },
        'billingAddress': {
          'attention': attention,
          'countryRegion': countryRegion,
          'Street1': street1,
          'city': city,
          'state': state,
          'zipCode': zipCode,
          'phone1': phone1,
          'fax':fax
        },
        'contactPerson': this.contactPersonList,
        'remarks': {'remarkstext': remarkstext},
      };
      addItems.add(this.createItems);
    });
    final response = await http.post(Uri.parse(BaseUrl.contacts),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(this.createItems));
    var res = response.body;
    if (response.statusCode == 200) {
      print('sucess');
    } else {
      print("Error :" + res);
    }
  }

  final formKey = GlobalKey<FormState>();
  final contactformKey = GlobalKey<FormState>();
  String selectName = 'Salutation';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.tealAccent.shade700,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_sharp),
              onPressed: () { 
                Navigator.pop(context);
              }),
          title: Text('Contacts'),
        ),
        body: Container(
            child: Stack(children: [
          SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                      key: formKey,
                      child: Column(children: [
                        Container(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Container(
                                child: Row(
                                  children: [
                                    DropdownButton<String>(
                                      underline: Container(
                                        height: 1,
                                        color: Colors.grey,
                                      ),
                                      items: <String>['Mr.', 'Mrs.']
                                          .map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: SizedBox(
                                              width: 296.0, child: Text(value)),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectName = value;
                                        });
                                      },
                                      hint: Text(selectName.toString()),
                                    ),
                                  ],
                                ),
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter something';
                                  } else if (RegExp(r'[a-zA-Z]+|\s')
                                      .hasMatch(value)) {
                                    return null;
                                  } else {
                                    return 'Enter valid Name';
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'First Name',
                                  labelText: 'First Name',
                                ),
                                controller: firstName,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter something';
                                  } else if (RegExp(r'[a-zA-Z]+|\s')
                                      .hasMatch(value)) {
                                    return null;
                                  } else {
                                    return 'Enter valid Name';
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'Last Name',
                                  labelText: 'Last Name',
                                ),
                                controller: lastName,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return null;
                                  } else if (RegExp(r'[a-zA-Z]+|\s')
                                      .hasMatch(value)) {
                                    return null;
                                  } else {
                                    return 'Enter valid Name';
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'Company Name',
                                  labelText: 'Company Name',
                                ),
                                controller: companyName,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter something';
                                  } else if (RegExp(
                                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                      .hasMatch(value)) {
                                    return null;
                                  } else {
                                    return 'Enter valid Email';
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'Contact Email',
                                  labelText: 'Contact Email',
                                ),
                                controller: contactEmail,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter something';
                                  } else if (RegExp(r'(^(?:[+0]9)?[0-9]{10}$)')
                                      .hasMatch(value)) {
                                    return null;
                                  } else {
                                    return 'Enter valid Number';
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'primary Contact',
                                  labelText: 'Primary Contact',
                                ),
                                controller: primaryContact,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return null;
                                  } else if (RegExp(r'(^(?:[+0]9)?[0-9]{10}$)')
                                      .hasMatch(value)) {
                                    return null;
                                  } else {
                                    return 'Enter valid Number';
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'Secondary Contact',
                                  labelText: 'Secondary Contact',
                                ),
                                controller: secondarycontact,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return null;
                                  } else if (RegExp(
                                          r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)')
                                      .hasMatch(value)) {
                                    return null;
                                  } else {
                                    return 'Enter valid Url';
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'Website',
                                  labelText: 'Website',
                                ),
                                controller: website,
                              ),
                            ])),
                        DefaultTabController(
                            length: 3,
                            initialIndex: 0,
                            child: Column(children: [
                              TabBar(
                                indicatorColor: Colors.tealAccent.shade700,
                                isScrollable: true,
                                unselectedLabelColor: Colors.black,
                                labelColor: Colors.tealAccent.shade700,
                                tabs: [
                                  Tab(text: 'Other Details'),
                                  Tab(text: 'Address'),
                                  Tab(text: 'Contact Persons'),
                                ],
                              ),
                              Container(
                                  height: 600,
                                  child: TabBarView(children: [
                                    Container(
                                        child: Column(children: [
                                      TextFormField(
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return null;
                                          } else if (RegExp(
                                                  r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)')
                                              .hasMatch(value)) {
                                            return null;
                                          } else {
                                            return 'Enter valid Url';
                                          }
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Facebook',
                                          labelText: 'Facebook ',
                                        ),
                                        controller: facebook,
                                      ),
                                      TextFormField(
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return null;
                                          } else if (RegExp(r'[0-9]')
                                              .hasMatch(value)) {
                                            return null;
                                          } else {
                                            return 'Enter Amount';
                                          }
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Opening Balance',
                                          labelText: 'OpeningBalance ',
                                        ),
                                        controller: openingBalance,
                                      ),
                                      TextFormField(
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return null;
                                          } else if (RegExp(
                                                  r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)')
                                              .hasMatch(value)) {
                                            return null;
                                          } else {
                                            return 'Enter valid Url';
                                          }
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Twitter',
                                          labelText: 'Twitter ',
                                        ),
                                        controller: twitter,
                                      ),
                                    ])),
                                    Container(
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return null;
                                                } else if (RegExp(
                                                        r'^[a-zA-Z0-9&%=]+$')
                                                    .hasMatch(value)) {
                                                  return null;
                                                } else {
                                                  return 'Enter valid Key';
                                                }
                                              },
                                              decoration: InputDecoration(
                                                hintText: 'Attention',
                                                labelText: 'Attention ',
                                              ),
                                              controller: attention,
                                            ),
                                            TextFormField(
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return null;
                                                } else if (RegExp(
                                                        r'^[a-zA-Z0-9&%=]+$')
                                                    .hasMatch(value)) {
                                                  return null;
                                                } else {
                                                  return 'Enter valid Details';
                                                }
                                              },
                                              decoration: InputDecoration(
                                                hintText: 'Country/Region',
                                                labelText: 'Country Region ',
                                              ),
                                              controller: countryRegion,
                                            ),
                                            TextFormField(
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return null;
                                                } else if (RegExp(
                                                        r'^[a-zA-Z0-9&%=]+$')
                                                    .hasMatch(value)) {
                                                  return null;
                                                } else {
                                                  return 'Enter valid Details';
                                                }
                                              },
                                              decoration: InputDecoration(
                                                hintText: 'Street1',
                                                labelText: 'Street1 ',
                                              ),
                                              controller: street1,
                                            ),
                                            TextFormField(
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return null;
                                                } else if (RegExp(
                                                        r'^[a-zA-Z0-9&%=]+$')
                                                    .hasMatch(value)) {
                                                  return null;
                                                } else {
                                                  return 'Enter valid Details';
                                                }
                                              },
                                              decoration: InputDecoration(
                                                hintText: 'City',
                                                labelText: 'City ',
                                              ),
                                              controller: city,
                                            ),
                                            TextFormField(
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return null;
                                                } else if (RegExp(
                                                        r'^[a-zA-Z0-9&%=]+$')
                                                    .hasMatch(value)) {
                                                  return null;
                                                } else {
                                                  return 'Enter valid Details';
                                                }
                                              },
                                              decoration: InputDecoration(
                                                hintText: 'State',
                                                labelText: 'State ',
                                              ),
                                              controller: state,
                                            ),
                                            TextFormField(
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return null;
                                                } else if (RegExp(
                                                        r'(^(?:[+0]9)?[0-9]{6}$)')
                                                    .hasMatch(value)) {
                                                  return null;
                                                } else {
                                                  return 'Enter valid Number';
                                                }
                                              },
                                              decoration: InputDecoration(
                                                hintText: 'Zip Code',
                                                labelText: 'Zip Code ',
                                              ),
                                              controller: zipCode,
                                            ),
                                            TextFormField(
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return null;
                                                } else if (RegExp(
                                                        r'(^(?:[+0]9)?[0-9]{10}$)')
                                                    .hasMatch(value)) {
                                                  return null;
                                                } else {
                                                  return 'Enter valid Number';
                                                }
                                              },
                                              decoration: InputDecoration(
                                                hintText: 'Phone',
                                                labelText: 'Phone ',
                                              ),
                                              controller: phone1,
                                            ),
                                            TextFormField(
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return null;
                                                } else if (RegExp(
                                                        r'(^(?:[+0]9)?[0-9]{6}$)')
                                                    .hasMatch(value)) {
                                                  return null;
                                                } else {
                                                  return 'Enter valid Number';
                                                }
                                              },
                                              decoration: InputDecoration(
                                                hintText: 'Fax',
                                                labelText: 'Fax',
                                              ),
                                              controller: fax,
                                            ),
                                          ],
                                        ),
                                      ),
                                  
                                    this.widget.prod != null
                                        ? Container(
                                            child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20.0),
                                                  child: Table(
                                                    columnWidths: {
                                                      0: FixedColumnWidth(40),
                                                      1: FlexColumnWidth(2),
                                                      2: FlexColumnWidth(2),
                                                      3: FlexColumnWidth()
                                                    },
                                                    children: [
                                                      TableRow(children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Text('No'),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(25.0),
                                                          child: Text('Phone'),
                                                        ),
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(25.0),
                                                            child:
                                                                Text('Email')),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: IconButton(
                                                              icon: Icon(
                                                                  Icons.delete),
                                                              onPressed: () {}),
                                                        ),
                                                      ]),
                                                      for (var i = 0;
                                                          i <
                                                              this
                                                                  .widget
                                                                  .prod[
                                                                      'contactPerson']
                                                                  .length;
                                                          i++)
                                                        TableRow(children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text((i + 1)
                                                                .toString()),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(this
                                                                            .widget
                                                                            .prod[
                                                                        'contactPerson'][i]
                                                                    [
                                                                    'mobile'] ??
                                                                '-'),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(this
                                                                        .widget
                                                                        .prod[
                                                                    'contactPerson'][i]
                                                                [
                                                                'emailAddress']),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: IconButton(
                                                                icon: Icon(Icons
                                                                    .delete),
                                                                onPressed:
                                                                    () async {
                                                                  await showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (_) =>
                                                                              AlertDialog(
                                                                                title: Text('Do you want Delete'),
                                                                                actions: [
                                                                                  FlatButton(
                                                                                      onPressed: () {
                                                                                        Navigator.of(context, rootNavigator: true).pop(true);
                                                                                      },
                                                                                      child: Text(
                                                                                        'No',
                                                                                        style: TextStyle(
                                                                                          color: Colors.tealAccent.shade700,
                                                                                        ),
                                                                                      )),
                                                                                  FlatButton(
                                                                                      onPressed: () {
                                                                                        removeContact(i);
                                                                                        Navigator.of(context, rootNavigator: true).pop(true);
                                                                                      },
                                                                                      child: Text(
                                                                                        'Yes',
                                                                                        style: TextStyle(
                                                                                          color: Colors.tealAccent.shade700,
                                                                                        ),
                                                                                      )),
                                                                                ],
                                                                              ));
                                                                }),
                                                          ),
                                                        ]),
                                                    ],
                                                    border: TableBorder.all(
                                                      width: 1,
                                                      color: Colors
                                                          .tealAccent.shade700,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 80.0),
                                                  child: Column(
                                                    children: [
                                                      IconButton(
                                                        icon: Icon(Icons.add),
                                                        onPressed: () async {
                                                          await showModalBottomSheet(
                                                              context: context,
                                                              builder:(BuildContext context) {
                                                                return SingleChildScrollView(
                                                                  child:Container(
                                                                    padding: const EdgeInsets.only(left:15.0,right:15.0,bottom:70.0),
                                                                    child: Column(
                                                                        children: [
                                                                          TextFormField(
                                                                            validator:
                                                                                (value) {
                                                                              if (value.isEmpty) {
                                                                                return 'Enter Email Address';
                                                                              } else if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                                                                                return null;
                                                                              } else {
                                                                                return 'Enter valid email';
                                                                              }
                                                                            },
                                                                            decoration:
                                                                                InputDecoration(labelText: 'Email'),
                                                                            controller:
                                                                                emailAddress,
                                                                          ),
                                                                          TextFormField(
                                                                            validator:
                                                                                (value) {
                                                                              if (value.isEmpty) {
                                                                                return 'Enter Phone Number';
                                                                              } else if (RegExp(r'(^(?:[+0]9)?[0-9]{10}$)').hasMatch(value)) {
                                                                                return null;
                                                                              } else {
                                                                                return 'Enter valid Number';
                                                                              }
                                                                            },
                                                                            decoration:
                                                                                InputDecoration(labelText: 'Phone'),
                                                                            controller:
                                                                                mobile,
                                                                          ),
                                                                          RaisedButton(
                                                                            child:
                                                                                Text(
                                                                              'Submit',
                                                                              style: TextStyle(color: Colors.tealAccent.shade700),
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              addContact(
                                                                                emailAddress.text,
                                                                                mobile.text,
                                                                              );
                                                                              Navigator.pop(context);
                                                                              emailAddress.clear();
                                                                              mobile.clear();
                                                                            },
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ]),
                                                                  ),
                                                                );
                                                              });
                                                        },
                                                        color: Colors.tealAccent
                                                            .shade700,
                                                      ),
                                                      Text(
                                                          'Add Contact Person'),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ))
                                        : Container(
                                            child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:const EdgeInsets.only(top: 20.0),
                                                  child: Table(
                                                    columnWidths: {
                                                      0: FixedColumnWidth(40),
                                                      1: FlexColumnWidth(2),
                                                      2: FlexColumnWidth(2),
                                                      3: FlexColumnWidth()
                                                    },
                                                    children: [
                                                      TableRow(children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Text('No'),
                                                        ),
                                                        Padding(
                                                          padding:const EdgeInsets.all(25.0),
                                                          child: Text('Phone'),
                                                        ),
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(25.0),
                                                            child:
                                                                Text('Email')),
                                                        Padding(
                                                          padding:const EdgeInsets.all(8.0),
                                                          child: IconButton(
                                                              icon: Icon( Icons.delete),
                                                              onPressed: () {}),
                                                        ),
                                                      ]),
                                                      for (var i = 0; i<this.contactPersonList.length; i++)
                                                        TableRow(children: [
                                                          Padding(
                                                            padding:const EdgeInsets.all(8.0),
                                                            child: Text((i + 1).toString()),
                                                          ),
                                                          Padding(
                                                            padding:const EdgeInsets.all(8.0),
                                                            child: Text(this.contactPersonList[i]['mobile'] ??'-'),
                                                          ),
                                                          Padding(
                                                            padding:const EdgeInsets.all(8.0),
                                                            child: Text(this.contactPersonList[i]['emailAddress']),
                                                          ),
                                                          Padding(
                                                            padding:const EdgeInsets.all(8.0),
                                                            child: IconButton(
                                                                icon: Icon(Icons.delete),
                                                                onPressed:
                                                                    () async {
                                                                  await showDialog(
                                                                      context: context,
                                                                      builder:
                                                                          (_) =>
                                                                              AlertDialog(
                                                                                title: Text('Do you want Delete'),
                                                                                actions: [
                                                                                  FlatButton(
                                                                                      onPressed: () {
                                                                                        Navigator.of(context, rootNavigator: true).pop(true);
                                                                                      },
                                                                                      child: Text(
                                                                                        'No',
                                                                                        style: TextStyle(
                                                                                          color: Colors.tealAccent.shade700,
                                                                                        ),
                                                                                      )),
                                                                                  FlatButton(
                                                                                      onPressed: () {
                                                                                        removeContact(i);
                                                                                        Navigator.of(context, rootNavigator: true).pop(true);
                                                                                      },
                                                                                      child: Text(
                                                                                        'Yes',
                                                                                        style: TextStyle(
                                                                                          color: Colors.tealAccent.shade700,
                                                                                        ),
                                                                                      )),
                                                                                ],
                                                                              ));
                                                                }),
                                                          ),
                                                        ]),
                                                    ],
                                                    border: TableBorder.all(
                                                      width: 1,
                                                      color: Colors
                                                          .tealAccent.shade700,
                                                    ),
                                                  ),
                                                ),
                                                if(displayForm==false)
                                                Text('No Data Found'),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 80.0),
                                                  child: Column(
                                                    children: [
                                                      IconButton(
                                                          icon: Icon(Icons.add,color: Colors.tealAccent.shade700,),
                                                          onPressed: ()async {
                                                          await showModalBottomSheet(
                                                              context: context,
                                                              builder:(BuildContext context) {
                                                                return  Form(
                                                                  key: contactformKey,
                                                         child: SingleChildScrollView(
                                                    child: Container(
                                                        padding:const EdgeInsets.only(left:15.0,right:15.0,bottom: 70.0),
                                                        child:Column(children: [
                                                          TextFormField(
                                                            validator: (value) {
                                                              if (value.isEmpty) {
                                                                  return 'Enter Email Address';
                                                              } else if (RegExp(
                                                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                                    .hasMatch(value)) {
                                                                  return null;
                                                              } else {
                                                                  return 'Enter valid email';
                                                              }
                                                            },
                                                            decoration:
                                                                  InputDecoration(labelText:'Email'),
                                                            controller:emailAddress,
                                                          ),
                                                          TextFormField(
                                                            validator: (value) {
                                                              if (value.isEmpty) {
                                                                  return 'Enter Phone Number';
                                                              } else if (RegExp(
                                                                        r'(^(?:[+0]9)?[0-9]{10}$)')
                                                                    .hasMatch(value)) {
                                                                  return null;
                                                              } else {
                                                                  return 'Enter valid Number';
                                                              }
                                                            },
                                                            decoration:InputDecoration(labelText:'Phone'),
                                                             controller: mobile,
                                                          ),
                                                          RaisedButton(
                                                              child: Text('Submit',style: TextStyle(color: Colors.tealAccent.shade700),),
                                                              onPressed: () {
                                                                if (contactformKey.currentState.validate()) {
                                                                    addContact(
                                                                      emailAddress.text,
                                                                      mobile.text,
                                                                    );Navigator.pop(context);
                                                                    emailAddress.clear();
                                                                    mobile.clear();
                                                                    displayForm=true;
                                                              }},color: Colors.white,
                                                              ),
                                                        ]),
                                                      ),
                                                  ),
                                                                );

                                                          });},
                                                          ),
                                                      Text(
                                                          'Add Contact Person'),
                                                    ],
                                                  ),
                                                ),
                                                 
                                              ],
                                            ),
                                          )),
                                  ]))
                            ]))
                      ])))),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(right: 15.0, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  RaisedButton(
                    color: Colors.white,
                    child: Text('Cancel',style: TextStyle(color: Colors.tealAccent.shade700),),
                    onPressed: (){
                        Navigator.pop(context);
                  }),
                  RaisedButton(
                      color: Colors.tealAccent.shade700,
                      child: Text(textChange(),
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          Navigator.pop(context);
                          if (this.widget.prod != null) {
                            updateDetails(
                              firstName.text,
                              lastName.text,
                              companyName.text,
                              contactEmail.text,
                              primaryContact.text,
                              secondarycontact.text,
                              website.text,
                              facebook.text,
                              openingBalance.text,
                              twitter.text,
                              attention.text,
                              countryRegion.text,
                              street1.text,
                              city.text,
                              state.text,
                              zipCode.text,
                              phone1.text,
                              fax.text,
                              remarkstext.text,
                              this.widget.prod['_id'],
                            );
                          } else {
                            createDetails(
                              firstName.text,
                              lastName.text,
                              companyName.text,
                              contactEmail.text,
                              primaryContact.text,
                              secondarycontact.text,
                              website.text,
                              facebook.text,
                              openingBalance.text,
                              twitter.text,
                              attention.text,
                              countryRegion.text,
                              street1.text,
                              city.text,
                              state.text,
                              zipCode.text,
                              phone1.text,
                              fax.text,
                              remarkstext.text,
                            );
                          }
                        }
                      })
                ],
              ),
            ),
          ),
        ])));
  }
}
