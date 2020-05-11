import 'package:aps_5p/models/tendencia/tendencia_model.dart';
import 'package:aps_5p/screen/home/home_screen.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TendenciaWidget extends StatelessWidget {
  final Tendencia tendencia;

  TendenciaWidget(this.tendencia);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: corAzul,
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                width: double.infinity,
                child: Card(
                    child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Tendencia da Região: ${tendencia.locations[0].name}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text("WOEID: ${tendencia.locations[0].woeid}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14))
                    ],
                  ),
                ))),
            Expanded(
                child: ListView.builder(
                    itemCount: tendencia.trends.length,
                    itemBuilder: (context, index) {
                      return Container(
                          padding: EdgeInsets.all(10),
                          child: Card(
                              child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                Row(children: <Widget>[
                                  Text(
                                    "ASSUNTO : ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(tendencia.trends[index].name),
                                ]),
                                SizedBox(height: 10),
                                Row(children: <Widget>[
                                  Text(
                                    "URL : ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Flexible(
                                      child: GestureDetector(
                                    onTap: () {
                                      _lauchInBrowser(
                                          tendencia.trends[index].url);
                                    },
                                    child: Text(
                                      "${tendencia.trends[index].url}",
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.blue),
                                    ),
                                  ))
                                ]),
                                SizedBox(height: 10),
                                Row(children: <Widget>[
                                  Text(
                                    "QUERY : ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Flexible(child: Text(
                                      tendencia.trends[index].query))
                                ]),
                                SizedBox(height: 10),
                                Row(children: <Widget>[
                                  Text(
                                    "TWEET_VOLUME : ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(tendencia.trends[index].tweetVolume
                                      .toString()),
                                ]),
                              ],
                            ),
                          )));
                    }))
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
