import 'package:http/http.dart' as http;
import 'dart:convert';

const String apiKey = '876ED08B-39E6-4F75-A34E-2835A72E8E78';

class NetworkHelper{
   final String from;
   final String to;
  NetworkHelper(this.from, this.to);
  
  Future<double> getCurrencyData() async{
    http.Response response = await http.get('https://rest.coinapi.io/v1/exchangerate/$from/$to?apikey=$apiKey');
    var currData = jsonDecode(response.body);
    return currData['rate'];
  }
}