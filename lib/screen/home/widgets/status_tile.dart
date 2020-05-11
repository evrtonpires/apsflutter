import 'package:aps_5p/api_dados/api.dart';
import 'package:aps_5p/blocs/twitter_bloc.dart';
import 'package:aps_5p/models/sentiment/sentiment_model.dart';
import 'package:aps_5p/models/status_es/status_es_model.dart';
import 'package:aps_5p/screen/home/home_screen.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StatusTile extends StatefulWidget {
  final Statuses status;
  final BuildContext contextHome;
  final int index;

  StatusTile({@required this.status,
    @required this.contextHome,
    @required this.index});

  @override
  _StatusTileState createState() =>
      _StatusTileState(contextHome: contextHome, index: index, status: status);
}

class _StatusTileState extends State<StatusTile> {
  final Statuses status;
  final BuildContext contextHome;
  final int index;

  _StatusTileState({@required this.status,
    @required this.contextHome,
    @required this.index});

  final TwitterBloc blocTwitter =
  BlocProvider.tag('twitter').getBloc<TwitterBloc>();

  List<Sentiment> listSentiment = [];
  Api api;
  var postCortado;

  @override
  void initState() {
    super.initState();
    api = Api();
    postCortado = status.text.split('https');
  }

  sentimentos(post) async {
    Sentiment sent = Sentiment();
    sent = await api.emocao(post: post);
    blocTwitter.inSentiments.add(sent);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 120,
                  width: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(status.user.profileImageUrl),
                          fit: BoxFit.contain)),
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Usuário",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("${status.user.name}\n"),
                        Text(
                          "Descrição",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("${status.user.description}"),
                      ],
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  child: Text("URL Post",
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    sentimentos(status.text);
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
                                height: 200,
                                child: Column(
                                  children: <Widget>[
                                    status.entities.urls.length > 0
                                        ? GestureDetector(
                                      onTap: () {
                                        _lauchInBrowser(status
                                            .entities.urls[0].url);
                                      },
                                      child: Text(
                                        "${status.entities.urls[0].url}",
                                        style: TextStyle(
                                            decoration: TextDecoration
                                                .underline,
                                            color: Colors.white),
                                      ),
                                    )
                                        : Text("Sem URL de Post"),
                                    StreamBuilder<Sentiment>(
                                      stream: blocTwitter.outSentiments,
                                      builder: (context, snapshot) {
                                        return snapshot.data != null
                                            ? Column(
                                          children: <Widget>[
                                            Icon(
                                              snapshot.data.label ==
                                                  "POSITIVE"
                                                  ? Icons.done_outline
                                                  : snapshot.data
                                                  .label ==
                                                  "NEGATIVE"
                                                  ? Icons.clear
                                                  : Icons
                                                  .do_not_disturb_on,
                                              color: snapshot.data
                                                  .label ==
                                                  "POSITIVE"
                                                  ? Colors.green
                                                  : snapshot.data
                                                  .label ==
                                                  "NEGATIVE"
                                                  ? Colors.red
                                                  : Colors.orange,
                                              size: 100,
                                            ),
                                            Text(
                                                "${snapshot.data.score}"),
                                            Text(
                                                "${snapshot.data.label}")
                                          ],
                                        )
                                            : SizedBox();
                                      },
                                    ),
                                  ],
                                )),
                          );
                        });
                  },
                  color: corAzul,
                ),
                RaisedButton(
                  child: Text("Usuário Post",
                      style: TextStyle(color: Colors.white)),
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
                                        style:
                                        TextStyle(color: Colors.white)),
                                    Flexible(
                                        child: Text("${status.user.name}"))
                                  ]),
                                  Row(children: <Widget>[
                                    Text("Nome de Tela: ",
                                        style:
                                        TextStyle(color: Colors.white)),
                                    Flexible(
                                        child: Text(
                                            "${status.user.screenName}"))
                                  ]),
                                  SizedBox(height: 20),
                                  Row(children: <Widget>[
                                    Text("Cidade | País: ",
                                        style:
                                        TextStyle(color: Colors.white)),
                                    Flexible(
                                        child:
                                        Text("${status.user.location}"))
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
                    color: corAzul,
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
                                "${postCortado[0]}",
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
            ),
//    sentimentos(postCortado[0]);
          ],
        ));
  }

  Future<void> _lauchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url,
          forceSafariVC: false,
          forceWebView: true,
          headers: <String, String>{'header_key': 'header_value'});
    } else {
      throw 'Cold not launch $url';
    }
  }
}
