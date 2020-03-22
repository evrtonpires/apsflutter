import 'dart:convert';
import 'package:aps_5p/models/search_meta_data/search_meta_data_model.dart';
import 'package:aps_5p/models/status_es/status_es_model.dart';
import 'package:http/http.dart' as http;
import 'package:aps_5p/models/twitter/twitter_model.dart';
import 'package:twitter_api/twitter_api.dart';

class Api {
  Future<Twitter> search(String search) async {
    // Setting placeholder api keys
    String consumerApiKey = "RULaduPYdprfBBjuZh0m1QCRO";
    String consumerApiSecret =
        "9QbvAbQDVzjgNv8qnVz7iD218lbYnEWwiol4GBBFYliGijYVA6";
    String accessToken = "4519870007-TLTIXoee5VZ1gAyBKD4XPoZSV8ivS88jr8FsDkZ";
    String accessTokenSecret = "NcUoyrIR1Lj48boqHfAYnJSTKoW0JXbjhBiWeBOBF61s3";

    // Creating the twitterApi Object with the secret and public keys
    // These keys are generated from the twitter developer page
    // Dont share the keys with anyone
    final _twitterOauth = new twitterApi(
        consumerKey: consumerApiKey,
        consumerSecret: consumerApiSecret,
        token: accessToken,
        tokenSecret: accessTokenSecret);

    // Make the request to twitter
    Future<dynamic> twitterRequest = _twitterOauth.getTwitterRequest(
        // Http Method
        "GET",
        // Endpoint you are trying to reach
        "search/tweets.json",
        // The options for the request
        options: {
          "q": "$search",
          "result_type": "mixed",
//          "lang": "pt",
          "count": "100",
        },
        timeout: 30);

    // Wait for the future to finish
    var res = await twitterRequest;

    return decode(res);
    // Print off the response
  }

  Twitter decode(http.Response res) {
    Twitter twitter = Twitter.padrao();
    if (res.statusCode == 200) {
      var tweets = json.decode(res.body);

      twitter.statuses = tweets["statuses"].map<Statuses>((stat) {
        return Statuses.fromJson(stat);
      }).toList();

      twitter.searchMetadata =
          SearchMetadata.fromJson(tweets["search_metadata"]);
      return twitter;
    }
  }
}
