import 'package:aps_5p/api_dados/api.dart';
import 'package:aps_5p/models/sentiment/sentiment_model.dart';
import 'package:aps_5p/models/status_es/status_es_model.dart';
import 'package:aps_5p/models/tendencia/tendencia_model.dart';
import 'package:aps_5p/models/trends/trends_model.dart';
import 'package:aps_5p/models/twitter/twitter_model.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:connectivity/connectivity.dart';

const String BASE_URL = 'https://apsservice.herokuapp.com';

class TwitterBloc extends BlocBase {
  Api api;
  Dio dio;
  List<Statuses> listStatuses;
  List<Sentiment> listSentiments;

  final BehaviorSubject<List<Statuses>> _statusesController =
  BehaviorSubject<List<Statuses>>();

  Stream<List<Statuses>> get outStatuses => _statusesController.stream;

  final BehaviorSubject<String> _searchController = BehaviorSubject<String>();

  Stream<String> get outSearch => _searchController.stream;

  Sink<String> get inSearch => _searchController.sink;

  final BehaviorSubject<Sentiment> _sentimentsController = BehaviorSubject<
      Sentiment>();

  Stream<Sentiment> get outSentiments => _sentimentsController.stream;

  Sink<Sentiment> get inSentiments => _sentimentsController.sink;

  String get valorSearch => _searchController.value;

  Sentiment get getListSentiment => _sentimentsController.value;

  final BehaviorSubject<Tendencia> _trendsController =
  BehaviorSubject<Tendencia>();

  Stream<Tendencia> get outTendencia => _trendsController.stream;

  TwitterBloc() {
    api = Api();
    dio = Dio();
    tendencia();
    dio.options.baseUrl = BASE_URL;
    dio.options.receiveTimeout = 60000;
    _searchController.stream.listen(_search);
  }

  void tendencia() async {
    Tendencia tendencia = Tendencia.padrao();
//    _trendsController.sink.add(tendencia);
    tendencia = await api.trends("Brazil");

    if (tendencia != null) {
      _trendsController.sink.add(tendencia);
    }
  }
  void _search(String search) async {
    Twitter twitter = Twitter.padrao();
    if (search != null && search.isNotEmpty) {
      _statusesController.sink.add([]);

      twitter = await api.search(search);
      listStatuses = twitter.statuses;

      listStatuses.forEach((post) {
        if (post.text.isNotEmpty) {
          var postCortado = post.text.split('https');
          dio.post("/posts", data: {"post": postCortado[0]});
        }
      });
    }
    _statusesController.sink.add(listStatuses);
  }

  Future<bool> verificarConexao(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.SCALE,
          tittle: 'Sem Conexão',
          body: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              children: <Widget>[
                Center(
                  child: Text("PROBLEMA DE CONEXÃO",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
                Center(
                  child: Text(
                    "\nPor favor, verifique sua conexão com a internet.",
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          btnOkOnPress: () {
            verificarConexao(context);
          }).show();
      return false;
    }
  }

  @override
  void dispose() {
    _statusesController.close();
    _searchController.close();
    _trendsController.close();
    _sentimentsController.close();
    super.dispose();
  }
}
