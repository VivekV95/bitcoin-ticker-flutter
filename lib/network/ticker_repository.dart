import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart' as http;

class TickerRepository {
  static const String baseUrl =
      'https://apiv2.bitcoinaverage.com/indices/global/ticker/';

  Future<Map<String, String>> getCoinPrices(String currency) async {
    Map<String, String> coinMap = {'BTC': '', 'ETH': '', 'LTC': ''};

    http.Response response = await http.get('${baseUrl}BTC$currency');
    coinMap['BTC'] = getLastPrice(response);

    response = await http.get('${baseUrl}ETH$currency');
    coinMap['ETH'] = getLastPrice(response);

    response = await http.get('${baseUrl}LTC$currency');
    coinMap['LTC'] = getLastPrice(response);

    return coinMap;
  }

  String getLastPrice(http.Response response) {
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['last'].toString();
    } else
      return '';
  }
}
