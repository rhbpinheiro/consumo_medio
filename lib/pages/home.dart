import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../stores/consumo_list.dart';

final consumos = ConsumoList();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double consumo = 0;

  void _handleConsumoFiled(String text) {
    setState(() {
      if (text != "") {
        consumo = double.parse(text);
      } else {
        consumo = 0;
      }
    });
  }

  void _handleRegistraeButton() {
    if (consumo > 0) {
      consumos.addConsumo(consumo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Consumo Medio')),
        body: Observer(
            builder: (_) => Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                            hintText: 'Qual o consumo da viagem?'),
                        keyboardType: TextInputType.number,
                        onChanged: _handleConsumoFiled,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: _handleRegistraeButton,
                          child: Text('Registrar')),
                      SizedBox(height: 20),
                      Row(children: [
                        Expanded(
                            child: Column(children: [
                          Text('Consumos registrados'),
                          Text('${consumos.list.length}'),
                        ])),
                        Expanded(
                            child: Column(children: [
                          Text('Consumo médio geral'),
                          Text(consumos.mediaGeral),
                        ])),
                      ]),
                      Text("Registros"),
                      Container(
                        height: 200,
                        child: ListView.builder(
                          itemCount: consumos.list.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return Text('- ${consumos.list[index]}');
                          },
                        ),
                      ),
                    ],
                  ),
                )));
  }
}
