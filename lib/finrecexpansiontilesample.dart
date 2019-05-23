import 'dart:async';
import 'dart:convert'; //it allows us to convert our json to a list
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'compras.dart';
import 'vendas.dart';
import 'financeiropag.dart';
import 'financeirorec.dart';
import 'contabilidade.dart';
import 'estoque.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';

BuildContext contextoAtual;

class FinRecExpansionTileSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    contextoAtual = context;
    return MaterialApp(
      home: Scaffold(
        body: new Center(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) =>
                FinRecEntryItem(data[index]),
            itemCount: data.length,
          ),
        ),
      ),
    );
  }
}

// One entry in the multilevel list displayed by this app.
class FinRecEntry {
  FinRecEntry(this.title, [this.children = const <FinRecEntry>[]]);
  final String title;
  final List<FinRecEntry> children;
}

// The entire multilevel list displayed by this app.
final List<FinRecEntry> data = <FinRecEntry>[
  FinRecEntry(
    'Documento 0000001',
    <FinRecEntry>[
      FinRecEntry('Parcela: 0000001-A'),
      FinRecEntry('Parcela: 0000001-B'),
      FinRecEntry('Parcela: 0000001-C'),
    ],
  ),
  FinRecEntry(
    'Documento  0000002',
    <FinRecEntry>[
      FinRecEntry('Parcela: 0000002-A'),
      FinRecEntry('Parcela: 0000002-B'),
      FinRecEntry('Parcela: 0000002-C'),
    ],
  ),
  FinRecEntry(
    'Documento  0000003',
    <FinRecEntry>[
      FinRecEntry('Parcela: 0000003-A'),
      FinRecEntry('Parcela: 0000003-B'),
    ],
  ),
];

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class FinRecEntryItem extends StatelessWidget {
  const FinRecEntryItem(this.entry);

  final FinRecEntry entry;

  Widget _buildTiles(FinRecEntry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<FinRecEntry>(root),
      title: Text(root.title),
      backgroundColor: Colors.black26,
      children: root.children.map<Widget>(_buildTiles).toList(),
      leading: IconButton(
        onPressed: () {
          showDialog(
              context: contextoAtual,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return SimpleDialog(
                  title: const Text('Adicionar: '),
                  children: <Widget>[
                    SimpleDialogOption(
                      onPressed: () {},
                      child: const Text('Boleto para o documento'),
                    )
                  ],
                );
              });
        },
        icon: Icon(
          Icons.attach_money,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
