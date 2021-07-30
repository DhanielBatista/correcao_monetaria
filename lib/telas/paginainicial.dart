import 'package:correcao_monetaria/telas/selecionarmoedas.dart';
import 'package:flutter/material.dart';
import 'package:correcao_monetaria/controller/controle_api.dart' as api;

class PaginaInicial extends StatefulWidget {
  const PaginaInicial({Key? key}) : super(key: key);

  @override
  _PaginaInicialState createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  String _moedaSelecionada = '';

  Future _abrirNovaTela(BuildContext context) async {
    Map? resultado = await Navigator.of(context)
        .push(new MaterialPageRoute<Map>(builder: (BuildContext context) {
      return new SelecionarMoedas();
    }));
    if (resultado != null && resultado.containsKey('moedasParaComparacao')) {
      setState(() {
        _moedaSelecionada = resultado['moedasParaComparacao'];
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Moedinha Felas',
          style: titlestyle(),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () => _abrirNovaTela(context),
              icon: Icon(
                Icons.attach_money,
                color: Colors.grey.shade400,
              ))
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Image.asset('assets/planeta.jpg',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover),
          ),
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.all(30.0),
            child: Image.asset(
              'assets/moneyIcon.png',
              color: Colors.green,
              width: 100.0,
              height: 100.0,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text('${_moedaSelecionada.toString()}'),
          ),
          mostrarValoresWidget(_moedaSelecionada)
        ],
      ),
    );
  }

  Widget mostrarValoresWidget(String moedasParaComparacao) {
    var futureBuilder = FutureBuilder(
      future: api.controleApi(moedasParaComparacao),
      builder: ((BuildContext context, AsyncSnapshot<Map> snapshot) {
        if (snapshot.hasData) {
          Map? conteudo = snapshot.data;
          var moeda = conteudo!.values.first;
          return Container(
            margin: EdgeInsets.fromLTRB(0, 300, 30, 50),
            child: Text(
              'Moeda: ${moeda['name'].toString()} \n'
              'Codigo: ${moeda['code'].toString()} \n'
              'maior em 24hrs:${moeda['ask'].toString()} \n'
              'menor em 24hrs:${moeda['bid'].toString()} \n',
              style: estifoInfoMoeda(),
            ),
          );
        } else {
          return Container(
            child: Text('Falhou!'),
          );
        }
      }),
    );
    return futureBuilder;
  }

  titlestyle() {
    return TextStyle(color: Colors.grey.shade400);
  }

  estifoInfoMoeda() {
    return TextStyle(
      color: Colors.grey.shade400,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.bold,
      fontSize: 30.0,
    );
  }
}
