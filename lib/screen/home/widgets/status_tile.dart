import 'package:aps_5p/models/status_es/status_es_model.dart';
import 'package:aps_5p/screen/home/home_screen.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatusTile extends StatelessWidget {
  final Statuses status;
  final BuildContext contextHome;
  final int index;

  StatusTile(
      {@required this.status,
      @required this.contextHome,
      @required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ExpansionTile(
        title: Text("Usuário - ${status.user.name}"),
        leading: Container(
            height: 50,
            width: 50,
            child: FlareActor("assets/passarotwi.flr",
                alignment: Alignment.center,
                fit: BoxFit.contain,
                animation: "voar")),
//        backgroundColor: Colors.lightBlueAccent,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                child: Text("URL Post", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  showDialog(
                      context: contextHome,
                      builder: (contextHome) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 50,
                          backgroundColor: corAzul.withOpacity(0.95),
                          title: Text("Informação URL",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic)),
                          content: Container(
                            height: 40,
                            child: Text(
                                "${status.entities.urls.length > 0
                                    ? status.entities.urls[0].url
                                    : "Sem URL de Post"}"),
                          ),
                        );
                      });
                },
                color: corAzul,
              ),
              RaisedButton(
                child:
                    Text("Usuário Post", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  showDialog(
                      context: contextHome,
                      builder: (contextHome) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 50,
                          backgroundColor: corAzul.withOpacity(0.95),
                          title: Text("Informação Usuário",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic)),
                          content: Container(
//                            height: 60,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(children: <Widget>[
                                  Text("Nome: ",
                                      style: TextStyle(color: Colors.white)),
                                  Flexible(child: Text("${status.user.name}"))
                                ]),
                                Row(children: <Widget>[
                                  Text("Nome de Tela: ",
                                      style: TextStyle(color: Colors.white)),
                                  Flexible(
                                      child: Text("${status.user.screenName}"))
                                ]),
                                SizedBox(height: 20),
                                Row(children: <Widget>[
                                  Text("Cidade | País: ",
                                      style: TextStyle(color: Colors.white)),
                                  Flexible(
                                      child: Text("${status.user.location}"))
                                ]),
                              ],
                            ),
                          ),
                        );
                      });
                },
                color: corAzul,
              ),
            ],
          ),
          Stack(
            children: <Widget>[
              Card(
                  elevation: 10,
                  color: corAzul.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Post\n",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Center(
                            child: Text(
                          "${status.text}",
                          textAlign: TextAlign.center,
                        )),
                        Text(
                          "\n${status.createdAt.substring(0, 20)}",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  )),
              Align(
                  alignment: Alignment(-0.8, 0.0),
                  child: Text(
                    "\nLinguagem: ${status.lang}",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                    textAlign: TextAlign.center,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
