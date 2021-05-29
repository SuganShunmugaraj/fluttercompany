import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:soft/first_page.dart';
import 'package:soft/signin.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:soft/router.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(
      router: AppRouter(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter router;
  MyApp({Key key, this.router}) : super(key: key);
  final storage = FlutterSecureStorage();
  Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: "jwt");
    if (jwt == null) return "";
    return jwt;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
         fontFamily: 'Poppins',
       visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
     debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generateSettings,
      color: Colors.blue,
      home: FutureBuilder(
          future: jwtOrEmpty,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            if (snapshot.data != "") {
              var str = snapshot.data;
              var jwt = str.split(".");
              if (jwt.length != 3) {
                return Signin();
              } else {
                var payload = json.decode(
                    ascii.decode(base64.decode(base64.normalize(jwt[1]))));
                if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
                    .isAfter(DateTime.now())) {
                  return FirstPage(str, payload);
                } else {
                  return Signin();
                }
              }
            } else {
              return Signin();
            }
          }),
          
    );
  }
}
