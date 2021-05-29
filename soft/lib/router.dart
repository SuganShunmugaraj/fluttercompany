import 'package:flutter/material.dart';
import 'package:soft/string.dart';
import 'package:soft/edit.dart';
import 'package:soft/main.dart';
import 'package:soft/invoice.dart';

class AppRouter{

Route generateSettings(RouteSettings settings){
  switch(settings.name){
    case EDIT_PAGE:
    return MaterialPageRoute(builder: (_)=> Edit(prod: settings.arguments,));
    case INVOICE_PAGE:
    return MaterialPageRoute(builder: (_)=> Invoice(argument: settings.arguments,));
     case MYAPP_PAGE:
    return MaterialPageRoute(builder: (_)=>MyApp(router: AppRouter()));
    default:
    return null;

  }
}
  
}


