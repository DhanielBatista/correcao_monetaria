import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map> controleApi(String moedasParaComparacao) async {
  moedasParaComparacao =
      moedasParaComparacao.isEmpty ? 'USD-BRL' : moedasParaComparacao;
  String apiUrl =
      'https://economia.awesomeapi.com.br/last/$moedasParaComparacao';

  http.Response response = await http.get(Uri.parse(apiUrl));
  print(response);
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('falhou');
  }
}
