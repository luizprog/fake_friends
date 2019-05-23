import 'package:flutter/material.dart';
import 'expansion_tile_sample.dart';

class Compras extends StatefulWidget {
  @override
  _MenuComprasPageState createState() => new _MenuComprasPageState();
}

class _MenuComprasPageState extends State<Compras>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: new Text("CRK - Compras"),
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
                      child: Text('Requisicoes de compra'),
                    ),
                    Tab(
                      child: Text('Requisicao de material'),
                    ),
                    Tab(
                      child: Text('Relatorios'),
                    )
                  ], //tabs
                ), //child - TabBar
                preferredSize: Size.fromHeight(30.0)), //bottom
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
          ) //body TabBarView
          ), //child - Scaffold
    ); // return DefaultTabController
  }
}
