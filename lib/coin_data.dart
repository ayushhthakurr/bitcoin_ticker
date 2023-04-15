import 'package:http/http.dart' as http;
import 'dart:convert';
import 'price_screen.dart';
import 'constants.dart';

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
  'RUP',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'DOG',
];


class LivePrice {

  PriceScreen priceScreen = PriceScreen();

  Future getLivePrice(String selectedCurrency) async {
    Map<String,String> cryptoPrices = {};
    for (String crypto in cryptoList)
    {
      http.Response livePriceFromApi = await http.get(Uri.parse('$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey'));
      if (livePriceFromApi.statusCode == 200 )
      {
        var dataFromApi = jsonDecode(livePriceFromApi.body);
//here hkr
        var collectedLiveData =dataFromApi['rate'];
        cryptoPrices[crypto] = collectedLiveData.toStringAsFixed(0);

      }
      else {
        print(livePriceFromApi.statusCode);
        throw ' Problem with your request ';
      }
    }
    return cryptoPrices;
  }
}


// https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=1783B0F4-8133-4359-8C19-D2D3D3121A83