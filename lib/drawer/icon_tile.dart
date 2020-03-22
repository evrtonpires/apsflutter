import 'package:flutter/material.dart';

class IconTile extends StatelessWidget {
  const IconTile(
      {@required this.iconData,
      @required this.text,
      @required this.highLighted,
      @required this.onTap,
      this.isSair = false});

  final String text;
  final IconData iconData;
  final VoidCallback onTap;
  final bool highLighted;
  final bool isSair;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            text,
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          leading:
              Icon(iconData, size: 30, color: Theme.of(context).primaryColor),
          onTap: onTap,
        ),
        isSair
            ? SizedBox()
            : Divider(
                height: 20,
                thickness: 0.5,
                color: Theme.of(context).primaryColor.withOpacity(0.7),
                indent: 32,
                endIndent: 32,
              )
      ],
    );
  }
}
