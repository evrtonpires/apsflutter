import 'package:aps_5p/api_dados/api.dart';
import 'package:aps_5p/blocs/twitter_bloc.dart';
import 'package:aps_5p/drawer/custom_drawer.dart';
import 'package:aps_5p/models/status_es/status_es_model.dart';
import 'package:aps_5p/screen/home/widgets/search_dialog.dart';
import 'package:aps_5p/screen/home/widgets/status_tile.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
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
              return Stack(
                children: <Widget>[
                  Center(
                      child: Container(
                          height: 100,
                          width: 100,
                          child: FlareActor("assets/passarotwi.flr",
                              alignment: Alignment.center,
                              fit: BoxFit.contain,
                              animation: "voar"))),
                  Align(
                    alignment: Alignment(0.0, 0.3),
                    child: Text(
                      "REALIZE SUA PESQUISA",
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              );
            case ConnectionState.active:
              if (blocTwitter.valorSearch.isEmpty) {
                return Stack(
                  children: <Widget>[
                    Center(
                        child: Container(
                            height: 100,
                            width: 100,
                            child: FlareActor("assets/passarotwi.flr",
                                alignment: Alignment.center,
                                fit: BoxFit.contain,
                                animation: "voar"))),
                    Align(
                      alignment: Alignment(0.0, 0.2),
                      child: Text(
                        "Realize sua Pesquisa",
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                );
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
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return StatusTile(
                      status: snapshot.data[index],
                      contextHome: context,
                      index: index);
                },
              );
            default:
              return Center(child: Text("Error"));
          }
        },
      ),
    );
  }
}
