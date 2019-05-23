import 'package:flutter/material.dart';
import 'expansion_tile_sample.dart';

class FinanceiroPag extends StatefulWidget {
  @override
  _MenuFinanceiroPagPageState createState() =>
      new _MenuFinanceiroPagPageState();
}

class _MenuFinanceiroPagPageState extends State<FinanceiroPag>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: new Text("CRK - Financeiro Pagar"),
            backgroundColor: Colors.blue,
            bottom: PreferredSize(
                child: TabBar(
                    isScrollable: true,
                    unselectedLabelColor: Colors.white.withOpacity(0.3),
                    indicatorColor: Colors.white,
                    tabs: [
                      Tab(
                        child: Text('Documento financeiro'),
                      ),
                      Tab(
                        child: Text('Saldo contas'),
                      ),
                      Tab(
                        child: Text('Movimento bancario'),
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

////////////////
