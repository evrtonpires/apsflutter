import 'package:aps_5p/api_dados/api.dart';
import 'package:aps_5p/blocs/twitter_bloc.dart';
import 'package:aps_5p/drawer/custom_drawer.dart';
import 'package:aps_5p/models/sentiment/sentiment_model.dart';
import 'package:aps_5p/models/status_es/status_es_model.dart';
import 'package:aps_5p/models/tendencia/tendencia_model.dart';
import 'package:aps_5p/screen/home/widgets/search_dialog.dart';
import 'package:aps_5p/screen/home/widgets/status_tile.dart';
import 'package:aps_5p/screen/home/widgets/tendencia_widget.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

Color corAzul = Color.fromARGB(255, 0, 191, 255);

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TwitterBloc blocTwitter =
      BlocProvider.tag('twitter').getBloc<TwitterBloc>();

  Api api;

  @override
  void initState() {
    super.initState();
    api = Api();
  }

  bool container0 = false;
  bool container1 = false;
  bool container2 = false;
  bool container3 = false;
  bool container4 = false;
  bool container5 = false;
  bool container6 = false;
  bool container7 = false;
  bool container8 = false;
  bool container9 = false;

  double tamanho0 = 150;
  double tamanho1 = 150;
  double tamanho2 = 150;
  double tamanho3 = 150;
  double tamanho4 = 150;
  double tamanho5 = 150;
  double tamanho6 = 150;
  double tamanho7 = 150;
  double tamanho8 = 150;
  double tamanho9 = 150;

  @override
  void didChangeDependencies() {
    blocTwitter.verificarConexao(context);
    super.didChangeDependencies();
  }

  final PageController controller = PageController(viewportFraction: 0.9);

  List<Sentiment> listSent = [];

  sentimentos(post) async {
    Sentiment sent = Sentiment();
    sent = await api.emocao(post: post);
    listSent.add(sent);
    blocTwitter.inListSentiments.add(listSent);
  }

  @override
  Widget build(BuildContext context) {
    _openSearch() async {
      bool isConnect = await blocTwitter.verificarConexao(context);
      if (isConnect) {
        final String valorPesquisado = await showDialog(
            context: context, builder: (context) => SearchDialog());

        if (valorPesquisado != null && valorPesquisado.isNotEmpty) {
          blocTwitter.inSearch.add(valorPesquisado);
        }
      }
    }

    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: corAzul,
        title: StreamBuilder<String>(
            stream: blocTwitter.outSearch,
            builder: (context, snapshot) {
              return Text(
                (snapshot.data == null || snapshot.data.isEmpty)
                    ? "Twitter"
                    : "${snapshot.data}",
                style: TextStyle(fontSize: 18, color: Colors.white),
              );
            }),
        centerTitle: true,
        actions: <Widget>[
          StreamBuilder<String>(
            stream: blocTwitter.outSearch,
            initialData: '',
            builder: (context, snapshot) {
              return IconButton(
                icon: (snapshot.data == null || snapshot.data.isEmpty)
                    ? Icon(Icons.search)
                    : Icon(Icons.close),
                onPressed: () {
                  if (snapshot.data == null || snapshot.data.isEmpty)
                    _openSearch();
                  else {
                    blocTwitter.inSearch.add('');
                    listSent = [];
                    blocTwitter.inListSentiments.add(listSent);
                    container0 = false;
                    container1 = false;
                    container2 = false;
                    container3 = false;
                    container4 = false;
                    container5 = false;
                    container6 = false;
                    container7 = false;
                    container8 = false;
                    container9 = false;
                  }
                },
                iconSize: 30,
                color: Colors.white,
              );
            },
          ),
//          IconButton(icon: Icon(Icons.search), onPressed: () => _openSearch())
        ],
      ),
      body: StreamBuilder<List<Statuses>>(
        stream: blocTwitter.outStatuses,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.done:
              return StreamBuilder<Tendencia>(
                  stream: blocTwitter.outTendencia,
                  builder: (context, snapshotTendencia) {
                    switch (snapshotTendencia.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.done:
                        return Center(child: CircularProgressIndicator());
                      case ConnectionState.active:
                        return RefreshIndicator(
                            child: TendenciaWidget(snapshotTendencia.data),
                            onRefresh: () async {
                              blocTwitter.tendencia();
                            });
                      default:
                        return Center(child: Text("Error"));
                    }
                  });
            case ConnectionState.active:
              if (blocTwitter.valorSearch.isEmpty) {
                return StreamBuilder<Tendencia>(
                    stream: blocTwitter.outTendencia,
                    builder: (context, snapshotTendencia) {
                      switch (snapshotTendencia.connectionState) {
                        case ConnectionState.waiting:
                        case ConnectionState.done:
                          return Center(child: CircularProgressIndicator());
                        case ConnectionState.active:
                          return RefreshIndicator(
                              child: TendenciaWidget(snapshotTendencia.data),
                              onRefresh: () async {
                                blocTwitter.tendencia();
                              });
                        default:
                          return Center(child: Text("Error"));
                      }
                    });
              }
              if (snapshot.data.length == 0) {
                return Center(
                    child: Container(
                        height: 100,
                        width: 100,
                        child: FlareActor("assets/engrenagem.flr",
                            alignment: Alignment.center,
                            fit: BoxFit.contain,
                            animation: "loading")));
              }
              return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.56,
                        child: PageView.builder(
                          controller: controller,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, int currentIndex) {
                            return StatusTile(
                              contextHome: context,
                              status: snapshot.data[currentIndex],
                              index: currentIndex,
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 50),
                      StreamBuilder<List<Sentiment>>(
                          stream: blocTwitter.outListSentiments,
                          builder: (context, snapshot1) {
                            return Container(
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.32,
                                alignment: Alignment(5, 1),
                                child: Row(
//                              mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        GestureDetector(
                                          child: Container(
                                              height: tamanho0,
                                              width: 35,
                                              margin: EdgeInsets.only(left: 5),
                                              padding: EdgeInsets.only(left: 5),
                                              color: Colors.cyanAccent,
                                              child: Center(
                                                child: snapshot1.data != null &&
                                                    snapshot1.data.length > 0
                                                    ? Text(
                                                    "${snapshot1.data[0]
                                                        .score}")
                                                    : Text(""),
                                              )),
                                          onTap: () {
                                            if (!container0) {
                                              sentimentos(
                                                  snapshot.data[0].text);
                                              container0 = true;
                                            }
                                          },
                                        ),
                                        snapshot1.data != null &&
                                            snapshot1.data.length > 0
                                            ? Text(
                                          "${snapshot1.data[0].label}",
                                          style: TextStyle(fontSize: 8),
                                        )
                                            : Text(""),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        GestureDetector(
                                          child: Container(
                                              height: 150,
                                              width: 35,
                                              margin: EdgeInsets.only(left: 5),
                                              padding: EdgeInsets.only(left: 5),
                                              color: Colors.grey,
                                              child: Center(
                                                child: snapshot1.data != null &&
                                                    snapshot1.data.length >= 2
                                                    ? Text(
                                                    "${snapshot1.data[1]
                                                        .score}")
                                                    : Text(""),
                                              )),
                                          onTap: () {
                                            if (!container1) {
                                              sentimentos(
                                                  snapshot.data[1].text);
                                              container1 = true;
                                            }
                                          },
                                        ),
                                        snapshot1.data != null &&
                                            snapshot1.data.length >= 2
                                            ? Text(
                                          "${snapshot1.data[1].label}",
                                          style: TextStyle(fontSize: 8),
                                        )
                                            : Text(""),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        GestureDetector(
                                          child: Container(
                                              height: 150,
                                              width: 35,
                                              margin: EdgeInsets.only(left: 5),
                                              padding: EdgeInsets.only(left: 5),
                                              color: Colors.red,
                                              child: Center(
                                                child: snapshot1.data != null &&
                                                    snapshot1.data.length >= 3
                                                    ? Text(
                                                    "${snapshot1.data[2]
                                                        .score}")
                                                    : Text(""),
                                              )),
                                          onTap: () {
                                            if (!container2) {
                                              sentimentos(
                                                  snapshot.data[2].text);
                                              container2 = true;
                                            }
                                          },
                                        ),
                                        snapshot1.data != null &&
                                            snapshot1.data.length >= 3
                                            ? Text(
                                          "${snapshot1.data[2].label}",
                                          style: TextStyle(fontSize: 8),
                                        )
                                            : Text(""),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        GestureDetector(
                                          child: Container(
                                              height: 150,
                                              width: 35,
                                              margin: EdgeInsets.only(left: 5),
                                              padding: EdgeInsets.only(left: 5),
                                              color: Colors.blue,
                                              child: Center(
                                                child: snapshot1.data != null &&
                                                    snapshot1.data.length >= 4
                                                    ? Text(
                                                    "${snapshot1.data[3]
                                                        .score}")
                                                    : Text(""),
                                              )),
                                          onTap: () {
                                            if (!container3) {
                                              sentimentos(
                                                  snapshot.data[3].text);
                                              container3 = true;
                                            }
                                          },
                                        ),
                                        snapshot1.data != null &&
                                            snapshot1.data.length >= 4
                                            ? Text(
                                          "${snapshot1.data[3].label}",
                                          style: TextStyle(fontSize: 8),
                                        )
                                            : Text(""),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        GestureDetector(
                                          child: Container(
                                              height: 150,
                                              width: 35,
                                              margin: EdgeInsets.only(left: 5),
                                              padding: EdgeInsets.only(left: 5),
                                              color: Colors.green,
                                              child: Center(
                                                child: snapshot1.data != null &&
                                                    snapshot1.data.length >= 5
                                                    ? Text(
                                                    "${snapshot1.data[4]
                                                        .score}")
                                                    : Text(""),
                                              )),
                                          onTap: () {
                                            if (!container4) {
                                              sentimentos(
                                                  snapshot.data[4].text);
                                              container4 = true;
                                            }
                                          },
                                        ),
                                        snapshot1.data != null &&
                                            snapshot1.data.length >= 5
                                            ? Text(
                                          "${snapshot1.data[4].label}",
                                          style: TextStyle(fontSize: 8),
                                        )
                                            : Text(""),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        GestureDetector(
                                          child: Container(
                                              height: 150,
                                              width: 35,
                                              margin: EdgeInsets.only(left: 5),
                                              padding: EdgeInsets.only(left: 5),
                                              color: Colors.pink,
                                              child: Center(
                                                child: snapshot1.data != null &&
                                                    snapshot1.data.length >= 6
                                                    ? Text(
                                                    "${snapshot1.data[5]
                                                        .score}")
                                                    : Text(""),
                                              )),
                                          onTap: () {
                                            if (!container5) {
                                              sentimentos(
                                                  snapshot.data[5].text);
                                              container5 = true;
                                            }
                                          },
                                        ),
                                        snapshot1.data != null &&
                                            snapshot1.data.length >= 6
                                            ? Text(
                                          "${snapshot1.data[5].label}",
                                          style: TextStyle(fontSize: 8),
                                        )
                                            : Text(""),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        GestureDetector(
                                          child: Container(
                                              height: 150,
                                              width: 35,
                                              margin: EdgeInsets.only(left: 5),
                                              padding: EdgeInsets.only(left: 5),
                                              color: Colors.orange,
                                              child: Center(
                                                child: snapshot1.data != null &&
                                                    snapshot1.data.length >= 7
                                                    ? Text(
                                                    "${snapshot1.data[6]
                                                        .score}")
                                                    : Text(""),
                                              )),
                                          onTap: () {
                                            if (!container6) {
                                              sentimentos(
                                                  snapshot.data[6].text);
                                              container6 = true;
                                            }
                                          },
                                        ),
                                        snapshot1.data != null &&
                                            snapshot1.data.length >= 7
                                            ? Text(
                                          "${snapshot1.data[6].label}",
                                          style: TextStyle(fontSize: 8),
                                        )
                                            : Text(""),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        GestureDetector(
                                          child: Container(
                                              height: 150,
                                              width: 35,
                                              margin: EdgeInsets.only(left: 5),
                                              padding: EdgeInsets.only(left: 5),
                                              color: Colors.blueAccent,
                                              child: Center(
                                                child: snapshot1.data != null &&
                                                    snapshot1.data.length >= 8
                                                    ? Text(
                                                    "${snapshot1.data[7]
                                                        .score}")
                                                    : Text(""),
                                              )),
                                          onTap: () {
                                            if (!container7) {
                                              sentimentos(
                                                  snapshot.data[7].text);
                                              container7 = true;
                                            }
                                          },
                                        ),
                                        snapshot1.data != null &&
                                            snapshot1.data.length >= 8
                                            ? Text(
                                          "${snapshot1.data[7].label}",
                                          style: TextStyle(fontSize: 8),
                                        )
                                            : Text(""),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        GestureDetector(
                                          child: Container(
                                              height: 150,
                                              width: 35,
                                              margin: EdgeInsets.only(left: 5),
                                              padding: EdgeInsets.only(left: 5),
                                              color: Colors.yellow,
                                              child: Center(
                                                child: snapshot1.data != null &&
                                                    snapshot1.data.length >= 9
                                                    ? Text(
                                                    "${snapshot1.data[8]
                                                        .score}")
                                                    : Text(""),
                                              )),
                                          onTap: () {
                                            if (!container8) {
                                              sentimentos(
                                                  snapshot.data[8].text);
                                              container8 = true;
                                            }
                                          },
                                        ),
                                        snapshot1.data != null &&
                                            snapshot1.data.length >= 9
                                            ? Text(
                                          "${snapshot1.data[8].label}",
                                          style: TextStyle(fontSize: 8),
                                        )
                                            : Text(""),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        GestureDetector(
                                          child: Container(
                                              height: 150,
                                              width: 35,
                                              margin: EdgeInsets.only(left: 5),
                                              padding: EdgeInsets.only(left: 5),
                                              color: Colors.grey,
                                              child: Center(
                                                child: snapshot1.data != null &&
                                                    snapshot1.data.length >= 10
                                                    ? Text(
                                                    "${snapshot1.data[9]
                                                        .score}")
                                                    : Text(""),
                                              )),
                                          onTap: () {
                                            if (!container9) {
                                              sentimentos(
                                                  snapshot.data[9].text);
                                              container9 = true;
                                            }
                                          },
                                        ),
                                        snapshot1.data != null &&
                                            snapshot1.data.length == 10
                                            ? Text(
                                          "${snapshot1.data[9].label}",
                                          style: TextStyle(fontSize: 8),
                                        )
                                            : Text(""),
                                      ],
                                    )
                                  ],
                                ));
                          })
                    ],
                  ));
            default:
              return Center(child: Text("Error"));
          }
        },
      ),
    );
  }
}
