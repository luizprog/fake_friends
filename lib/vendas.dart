import 'package:flutter/material.dart';
import 'expansion_tile_sample.dart';

class Vendas extends StatefulWidget {
  @override
  _MenuVendasPageState createState() => new _MenuVendasPageState();
}

class _MenuVendasPageState extends State<Vendas>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: new Text("CRK - Vendas"),
            backgroundColor: Colors.blue,
            bottom: PreferredSize(
                child: TabBar(
                    isScrollable: true,
                    unselectedLabelColor: Colors.white.withOpacity(0.3),
                    indicatorColor: Colors.white,
                    tabs: [
                      Tab(
                        child: Text('Pedidos'),
                      ),
                      Tab(
                        child: Text('Solicitacao de Verba'),
                      ),
                      Tab(
                        child: Text('Cadastro'),
                      ),
                      Tab(
                        child: Text('Relatorios'),
                      )
                    ]),
                preferredSize: Size.fromHeight(30.0)),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(Icons.add_alert),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              showDialog<String>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      title: const Text('Adicionar: '),
                      children: <Widget>[
                        SimpleDialogOption(
                          onPressed: () {},
                          child: const Text('Cobranca'),
                        ),
                        SimpleDialogOption(
                          onPressed: () {},
                          child: const Text('Retorno bancario'),
                        ),
                        SimpleDialogOption(
                          onPressed: () {},
                          child: const Text('Nota fiscal de servico'),
                        ),
                        SimpleDialogOption(
                          onPressed: () {},
                          child: const Text('Descontos'),
                        ),
                        SimpleDialogOption(
                          onPressed: () {},
                          child: const Text('Cliente'),
                        )
                      ],
                    );
                  });
            },
            icon: Icon(Icons.add),
            label: Text("Adicionar"),
          ),
          body: TabBarView(
            children: <Widget>[
              Container(
                child: ExpansionTileSample(),
              ),
              Container(
                child: ExpansionTileSample(),
              ),
              Container(
                child: ExpansionTileSample(),
              ),
              Container(
                child: ExpansionTileSample(),
              ),
            ],
          )),
    );
  }
}

////////////////
