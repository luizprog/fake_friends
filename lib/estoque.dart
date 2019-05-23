import 'package:flutter/material.dart';
import 'expansion_tile_sample.dart';

class Estoque extends StatefulWidget {
  @override
  _MenuEstoquePageState createState() => new _MenuEstoquePageState();
}

class _MenuEstoquePageState extends State<Estoque>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: new Text("CRK - Estoque"),
            backgroundColor: Colors.blue,
            bottom: PreferredSize(
                child: TabBar(
                    isScrollable: true,
                    unselectedLabelColor: Colors.white.withOpacity(0.3),
                    indicatorColor: Colors.white,
                    tabs: [
                      Tab(
                        child: Text('Movimento de estoque'),
                      ),
                      Tab(
                        child: Text('Produtos'),
                      ),
                      Tab(
                        child: Text('Ficha tecnica'),
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
