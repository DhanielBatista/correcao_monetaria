import 'package:flutter/material.dart';

class SelecionarMoedas extends StatefulWidget {
  @override
  _SelecionarMoedasState createState() => _SelecionarMoedasState();
}

class _SelecionarMoedasState extends State<SelecionarMoedas> {
  var _moedaInserida = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text('Selecionar moeda felas',
            style: TextStyle(color: Colors.grey.shade400)),
      ),
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/planeta2.jpg',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.all(70.0),
            child: Text(
              'Insira uma Moeda para Conversão',
              style: textoStyle(),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(150, 150, 150, 50),
            child: TextField(
                controller: _moedaInserida,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: 'USD-BRL',
                    hintStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.green,
                    filled: true,
                    border: InputBorder.none)),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(130, 250, 80, 80),
            child: TextButton(
                onPressed: () {
                  Navigator.pop(
                      context, {'moedasParaComparacao': _moedaInserida.text});
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green)),
                child: Text(
                  'Selecionar Moeda',
                  style: textoStyle(),
                )),
          )
        ],
      ),
    );
  }

  textoStyle() {
    return TextStyle(
        color: Colors.white, fontWeight: FontWeight.w900, fontSize: 15.0);
  }
}
