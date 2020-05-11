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
import 'package:fl_chart/fl_chart.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

Color corAzul = Color.fromARGB(255, 0, 191, 255);

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TwitterBloc blocTwitter =
      BlocProvider.tag('twitter').getBloc<TwitterBloc>();

  @override
  void didChangeDependencies() {
    blocTwitter.verificarConexao(context);
    super.didChangeDependencies();
  }

  final PageController controller = PageController(viewportFraction: 0.9);

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
