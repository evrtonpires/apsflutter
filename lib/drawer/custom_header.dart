import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        UserAccountsDrawerHeader(
          // decoration: BoxDecoration(color: Colors.black),
          accountName: Text("Everton Pires"),
          accountEmail: Text("RA: N31496-2"),
          currentAccountPicture:
              CircleAvatar(child: Image.asset("assets/developer.PNG")),
        ),
        Positioned(
          child: Container(
              child: Column(
            children: <Widget>[
              Text(
                "Developer",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: Text(
                  "Mobile",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              )
            ],
          )),
          top: 70,
          left: 140,
        )
      ],
    );
  }
}
