import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';

// E736773C-754D-4E8B-861D-70F96C1F5604
// A46231B5-C4CF-4466-BD7A-E57B1051451C

const apiKey = 'E736773C-754D-4E8B-861D-70F96C1F5604';
const apiKey1 = 'A46231B5-C4CF-4466-BD7A-E57B1051451C';
const openWeatherMapUrl = 'https://rest.coinapi.io/v1/exchangerate/';

const List<String> currenciesList = [
  'USD',
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
  'ZAR',
  'NGN'
];

// Todo: Uncomment the two lines here
const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  /// Fetch the information from the server and return it as a json String
  Future<dynamic> fetchData(String url) async {
    dynamic res;
    try {
      // Check if there's internet connectivity
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // If the request is successful
        String body = response.body;

        res = jsonDecode(body);
        log(res.toString());
      } else {
        log(response.statusCode.toString());
        res = 'Bad response';
      }
      return res;
    } catch (e) {
      return;
    }
  }

  getBitcoin({required String currency, required String crypto}) async {
    var url = '$openWeatherMapUrl$crypto/$currency?apikey=$apiKey1';
    return await fetchData(url);
  }
}

// https://rest.coinapi.io/v1/exchangerate/BTC/CNY?apikey=E736773C-754D-4E8B-861D-70F96C1F5604
