import 'package:flutter/material.dart';
import 'expansion_tile_sample.dart';

class Contabilidade extends StatefulWidget {
  @override
  _MenuContabilidadePageState createState() =>
      new _MenuContabilidadePageState();
}

class _MenuContabilidadePageState extends State<Contabilidade>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: new Text("CRK - Contabilidade"),
            backgroundColor: Colors.blue,
            bottom: PreferredSize(
                child: TabBar(
                    isScrollable: true,
                    unselectedLabelColor: Colors.white.withOpacity(0.3),
                    indicatorColor: Colors.white,
                    tabs: [
                      Tab(
                        child: Text('Eventos Contabeis'),
                      ),
                      Tab(
                        child: Text('Lancamentos contabeis'),
                      ),
                      Tab(
                        child: Text('Bloqueia/Desbloqueia Conta Contabil'),
                      ),
                      Tab(
                        child: Text('Bloqueia/Desbloqueia Centro Controle'),
                      ),
                      Tab(
                        child: Text('Implantacao de Saldo Anterior'),
                      ),
                      Tab(
                        child: Text('Relatorios'),
                      )
                    ] //tabs
                    ), //child - TabBar
                preferredSize: Size.fromHeight(30.0)), //bottom - PreferredSize
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(Icons.add_alert),
              ), //Padding
            ], //actions
          ), //appBar
          body: TabBarView(
            children: <Widget>[
              Container(
                child: Center(
                  child: Text('Tab 1'),
                ),
              ), //Container
              Container(
                child: ExpansionTileSample(),
              ), //Container
              Container(
                child: ExpansionTileSample(),
              ), //Container
              Container(
                child: ExpansionTileSample(),
              ), //Container
              Container(
                child: ExpansionTileSample(),
              ), //Container
              Container(
                child: ExpansionTileSample(),
              ), //Container
            ], //children
          ) //body - TabBarView
          ), //child - Scaffold
    ); // return DefaultTabController
  }
}
