import 'package:flutter/material.dart';

class SearchDialog extends StatefulWidget {
  @override
  _SearchDialogState createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  _SearchDialogState() : _controller = TextEditingController();

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 2,
          left: 2,
          right: 2,
          child: Card(
            child: TextField(
              controller: _controller,
              textInputAction: TextInputAction.search,
              autofocus: true,
              cursorColor: Colors.lightBlueAccent,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                  border: InputBorder.none,
                  focusColor: Colors.red,
                  prefixIcon: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.lightBlueAccent),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  suffixIcon: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.lightBlueAccent,
                      ),
                      onPressed: () {
                        _controller.clear();
                      })),
              onSubmitted: (text) {
                Navigator.of(context).pop(text);
              },
            ),
          ),
        )
      ],
    );
  }
}
