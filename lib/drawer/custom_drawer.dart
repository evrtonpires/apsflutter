import 'package:aps_5p/drawer/custom_header.dart';
import 'package:aps_5p/drawer/icon_tile.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              CustomHeader(),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    IconTile(
                      text: "Home",
                      iconData: Icons.home,
                      highLighted: true,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              )),
            ],
          ),
        ],
      ),
    );
  }
}
