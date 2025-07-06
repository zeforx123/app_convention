import 'dart:convert';

import 'package:http/http.dart' as http;

class ExchangeRateService {
  final String apiKey = '5e6e439d6b1bdb8801d5e129';

  Future<double?> obtenerTipoCambioUsdAPen() async {
    final url =
        Uri.parse('https://v6.exchangerate-api.com/v6/$apiKey/latest/USD');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['conversion_rates'] != null) {
        return (data['conversion_rates']['PEN'] as num).toDouble();
      }
    }

    return null;
  }
}
