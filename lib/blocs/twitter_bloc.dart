import 'package:aps_5p/api_dados/api.dart';
import 'package:aps_5p/models/status_es/status_es_model.dart';
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

  final BehaviorSubject<List<Statuses>> _statusesController =
      BehaviorSubject<List<Statuses>>();

  Stream<List<Statuses>> get outStatuses => _statusesController.stream;

  final BehaviorSubject<String> _searchController = BehaviorSubject<String>();

  Stream<String> get outSearch => _searchController.stream;

  Sink<String> get inSearch => _searchController.sink;

  String get valorSearch => _searchController.value;

  TwitterBloc() {
    api = Api();
    dio = Dio();
    dio.options.baseUrl = BASE_URL;
    dio.options.receiveTimeout = 60000;
    _searchController.stream.listen(_search);
  }

  void _search(String search) async {
    Twitter twitter = Twitter.padrao();
    if (search != null && search.isNotEmpty) {
      _statusesController.sink.add([]);
      twitter = await api.search(search);
      listStatuses = twitter.statuses;
    }
    listStatuses.forEach((post) {
      if (!post.text.contains("...") &&
          listStatuses.length > 0 &&
          post.text != null &&
          post.text.isNotEmpty) {
        dio.post("/posts", data: {"post": post.text});
      }
    });
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
//             btnOkColor: btnOkColor,
          btnOkOnPress: () {
            verificarConexao(context);
          }).show();
      return false;
//      verificarConexao();
    }
  }

  @override
  void dispose() {
    _statusesController.close();
    _searchController.close();
  }
}
