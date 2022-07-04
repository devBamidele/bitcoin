import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = 'E736773C-754D-4E8B-861D-70F96C1F5604';
const openWeatherMapUrl = 'http://api.openweathermap.org/data/2.5/weather';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  CoinData();

  final String url = '';

  Future<dynamic> getCoinData() async {
    dynamic res;
    try {
      // Check if there's internet connectivity
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // If the request is successful
        String body = response.body;

        res = jsonDecode(body);
      } else {
        log(response.statusCode.toString());
        res = 'Bad response';
      }
      return res;
    } catch (e) {
      return;
    }
  }
}
