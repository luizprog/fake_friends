import 'package:flutter/material.dart';
import 'expansion_tile_sample.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'finrecexpansiontilesample.dart';

String _searchText = "";

Icon _searchIcon = new Icon(Icons.search);

Widget _appBarTitle = new Text("Sample Example");

class FinanceiroRec extends StatefulWidget {
  @override
  _MenuFinanceiroRecPageState createState() =>
      new _MenuFinanceiroRecPageState();
}

class _MenuFinanceiroRecPageState extends State<FinanceiroRec>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: new Text("CRK - Financeiro Receber"),
            backgroundColor: Colors.blue,
            actions: <Widget>[
              IconButton(
                  icon: _searchIcon,
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(),
                    );
                  })
            ], //actions
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
                child: FinRecExpansionTileSample(),
              ),
              Container(
                child: FinRecExpansionTileSample(),
              ),
              Container(
                child: FinRecExpansionTileSample(),
              ),
              Container(
                child: FinRecExpansionTileSample(),
              ),
            ],
          )),
    );
  }
}

////////////////
class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }

    //Add the search term to the searchBloc.
    //The Bloc will then handle the searching and add the results to the searchResults stream.
    //This is the equivalent of submitting the search term to whatever search service you are using
    // InheritedBlocs.of(context).searchBloc.searchTerm.add(query);

    return Column(
      children: <Widget>[
        //Build the results based on the searchResults stream in the searchBloc
        //StreamBuilder(
        //stream: InheritedBlocs.of(context).searchBloc.searchResults,
        // builder: (context, AsyncSnapshot<List<Result>> snapshot) {
        /*if (!snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(child: CircularProgressIndicator()),
                ],
              );
            } else if (snapshot.data.length == 0) {
              return Column(
                children: <Widget>[
                  Text(
                    "No Results Found.",
                  ),
                ],
              );
            } else {
              var results = snapshot.data;
              return ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  var result = results[index];
                  return ListTile(
                    title: Text(result.title),
                  );
                },
              );
            }*/
        // },
        //),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    return Column();
  }
}
