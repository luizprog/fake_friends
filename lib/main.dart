/*
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(new MaterialApp(home: new HomePage()));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  List data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://10.0.0.13:8889/v1/pedcomp/TopPedComp/?id=10&empcod=01"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });

    // print(data[1]["item"]);

    return "Success!";
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Listviews"), backgroundColor: Colors.blue),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child: new Text(data[index]["item"]),
          );
        },
      ),
    );
  }
}
*/
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

List data;
List valueMap;
String dataGet;
var query;

List<Category> _categories = [
  Category('Compras', 'assets/images/buy.png'),
  Category('Vendas', 'assets/images/returnPurchase.png'),
  Category('FinanceiroRec', 'assets/images/money.png'),
  Category('FinanceiroPag', 'assets/images/money.png'),
  Category('Estoque', 'assets/images/product.png'),
  Category('Contabilidade', 'assets/images/coins.png'),
];

void main() {
  runApp(new MaterialApp(home: new HomePage()));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  //this async func will get data from the internet
  //when our func is done we return a string
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int _cIndex = 0;

  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("CRK - ERP - Apolo"), backgroundColor: Colors.blue),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                accountName: new Text("CRK - SSUARKLUIZ"),
                accountEmail: new Text("luiz@ssuark.com.br")),
            new ListTile(
              title: new Text("Compras"),
              onTap: () async {
                query =
                    "http://10.0.0.13:8889/v1/pedcomp/TopPedComp/?id=10&empcod=01";
                await getData();
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new ComprasPage()));
              },
            ),
            new ListTile(
              title: new Text("Vendas"),
              onTap: () async {
                query =
                    "http://10.0.0.13:8889/v1/pedvenda/TopPedVenda/?id=10&empcod=01";
                await getData();
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new VendasPage()));
              },
            ),
            new ListTile(
              title: new Text("Contabilidade"),
              onTap: () async {
                query =
                    "http://10.0.0.13:8889/v1/contablancamento/TopContabLancamento/?id=10&empcod=10";
                await getData();
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new ContabilidadePage()));
              },
            ),
            new ListTile(
              title: new Text("Financeiro"),
              onTap: () async {
                query =
                    "http://10.0.0.13:8889/v1/docfin/TopDocFin/?id=10&empcod=01";
                await getData();
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new FinanceiroPage()));
              },
            ),
            new ListTile(
              title: new Text("Estoque"),
              onTap: () async {
                query =
                    "http://10.0.0.13:8889/v1/movestq/TopMovEstq/?id=10&empcod=01";
                await getData();

                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new EstoquePage()));
              },
            ),
            new ListTile(
              title: new Text("Cotacao"),
              onTap: () async {
                //query =
                //   "http://10.0.0.13:8889/v1/cotaccomp/TopCotacComp/?id=10&empcod=01";
                //await getData();

                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new CotacaoCompraPage()));
              },
            )
          ],
        ),
      ),
      body: new Center(
        child: new GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 1.0,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
          children: List.generate(_categories.length, (index) {
            return Center(
                child: FlatButton(
              onPressed: () {
                goScene(_categories[index].name);
              },
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    new Container(
                      child: new Image.asset(
                        _categories[index].icon,
                        height: 60.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ));
          }),
        ),
      ),
    );
  }

  //pega dados de tabelas
  Future<String> getData() async {
    //we have to wait to get the data so we use 'await'
    http.Response response = await http.get(
        //Uri.encodeFull removes all the dashes or extra characters present in our Uri
        Uri.decodeFull(query), //encodeFull(query),
        headers: {
          //if your api require key then pass your key here as well e.g "key": "my-long-key"
          "Accept": "application/json"
        });
    data = json.decode(response.body);
  }

  //Muda para a tela do item clicado
  Future<String> goScene(String scene) async {
    if (scene == 'Compras') {
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) => new Compras()));
    }
    if (scene == 'Vendas') {
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) => new Vendas()));
    }
    if (scene == 'FinanceiroRec') {
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) => new FinanceiroRec()));
    }
    if (scene == 'FinanceiroPag') {
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) => new FinanceiroPag()));
    }
    if (scene == 'Estoque') {
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) => new Estoque()));
    }
    if (scene == 'Contabilidade') {
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) => new Contabilidade()));
    }
  }
}

class ComprasPage extends StatefulWidget {
  @override
  _ComprasPageState createState() => new _ComprasPageState();
}

class _ComprasPageState extends State<ComprasPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('CRK - Compras'),
      ),
      body: new Center(
        child: new ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) => new Column(
                children: <Widget>[
                  new Divider(
                    height: 10.0,
                  ),
                  new ListTile(
                    title: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          jsonDecode(jsonEncode(
                              data[index]['item']['empCod'].toString())),
                        ),
                        new Text(
                          jsonDecode(jsonEncode(
                              data[index]['item']['pedCompNum'].toString())),
                          style:
                              new TextStyle(color: Colors.grey, fontSize: 14.0),
                        ),
                      ],
                    ),
                    subtitle: new Container(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: new Text(
                        jsonDecode(jsonEncode(data[index]['item']['entCod'])),
                        style:
                            new TextStyle(color: Colors.grey, fontSize: 15.0),
                      ),
                    ),
                  )
                ],
              ),
        ),
      ),
    );
  }
}

class VendasPage extends StatefulWidget {
  @override
  _VendasPageState createState() => new _VendasPageState();
}

class _VendasPageState extends State<VendasPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('CRK - Vendas'),
      ),
      body: new Center(
        child: new ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) => new Column(
                children: <Widget>[
                  new Divider(
                    height: 10.0,
                  ),
                  new ListTile(
                    //leading: new CircleAvatar(
                    //  foregroundColor: Theme.of(context).primaryColor,
                    //  backgroundColor: Colors.grey,
                    //backgroundImage: new NetworkImage(dummyData[i].avatarUrl),
                    //),
                    title: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          jsonDecode(jsonEncode(
                              data[index]['item']['empCod'].toString())),
                        ),
                        new Text(
                          jsonDecode(jsonEncode(
                              data[index]['item']['pedVendaNum'].toString())),
                          style:
                              new TextStyle(color: Colors.grey, fontSize: 14.0),
                        ),
                      ],
                    ),
                    subtitle: new Container(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: new Text(
                        jsonDecode(jsonEncode(data[index]['item']['entCod'])),
                        style:
                            new TextStyle(color: Colors.grey, fontSize: 15.0),
                      ),
                    ),
                  )
                ],
              ),
        ),
      ),
    );
  }
}

class ContabilidadePage extends StatefulWidget {
  @override
  _ContabilidadePageState createState() => new _ContabilidadePageState();
}

class _ContabilidadePageState extends State<ContabilidadePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('CRK - Contabilidade'),
      ),
      body: new Center(
        child: new ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) => new Column(
                children: <Widget>[
                  new Divider(
                    height: 10.0,
                  ),
                  new ListTile(
                    //leading: new CircleAvatar(
                    //  foregroundColor: Theme.of(context).primaryColor,
                    //  backgroundColor: Colors.grey,
                    //backgroundImage: new NetworkImage(dummyData[i].avatarUrl),
                    //),
                    title: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          jsonDecode(jsonEncode(
                              data[index]['item']['empCod'].toString())),
                        ),
                        new Text(
                          jsonDecode(jsonEncode(
                              data[index]['item']['contabLancChv'].toString())),
                          style:
                              new TextStyle(color: Colors.grey, fontSize: 14.0),
                        ),
                      ],
                    ),
                    subtitle: new Container(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: new Text(
                        jsonDecode(jsonEncode(data[index]['item']['empCod'])),
                        style:
                            new TextStyle(color: Colors.grey, fontSize: 15.0),
                      ),
                    ),
                  )
                ],
              ),
        ),
      ),
    );
  }
}

class EstoquePage extends StatefulWidget {
  @override
  _EstoquePageState createState() => new _EstoquePageState();
}

class _EstoquePageState extends State<EstoquePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('CRK - Estoque'),
      ),
      body: new Center(
        child: new ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) => new Column(
                children: <Widget>[
                  new Divider(
                    height: 10.0,
                  ),
                  new ListTile(
                    //leading: new CircleAvatar(
                    //  foregroundColor: Theme.of(context).primaryColor,
                    //  backgroundColor: Colors.grey,
                    //backgroundImage: new NetworkImage(dummyData[i].avatarUrl),
                    //),
                    title: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          jsonDecode(jsonEncode(
                              data[index]['item']['empCod'].toString())),
                        ),
                        new Text(
                          jsonDecode(jsonEncode(
                              data[index]['item']['movEstqChv'].toString())),
                          style:
                              new TextStyle(color: Colors.grey, fontSize: 14.0),
                        ),
                      ],
                    ),
                    subtitle: new Container(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: new Text(
                        jsonDecode(jsonEncode(
                            data[index]['item']['movEstqDataEmissao'])),
                        style:
                            new TextStyle(color: Colors.grey, fontSize: 15.0),
                      ),
                    ),
                  )
                ],
              ),
        ),
      ),
    );
  }
}

class FinanceiroPage extends StatefulWidget {
  @override
  _FinanceiroPageState createState() => new _FinanceiroPageState();
}

class _FinanceiroPageState extends State<FinanceiroPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('CRK - Financeiro'),
      ),
      body: new Center(
        child: new ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) => new Column(
                children: <Widget>[
                  new Divider(
                    height: 10.0,
                  ),
                  new ListTile(
                    //leading: new CircleAvatar(
                    //  foregroundColor: Theme.of(context).primaryColor,
                    //  backgroundColor: Colors.grey,
                    //backgroundImage: new NetworkImage(dummyData[i].avatarUrl),
                    //),
                    title: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          jsonDecode(jsonEncode(
                              data[index]['item']['empCod'].toString())),
                        ),
                        new Text(
                          jsonDecode(jsonEncode(
                              data[index]['item']['docFinChv'].toString())),
                          style:
                              new TextStyle(color: Colors.grey, fontSize: 14.0),
                        ),
                      ],
                    ),
                    subtitle: new Container(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: new Text(
                        jsonDecode(
                            jsonEncode(data[index]['item']['docFinTipoLanc'])),
                        style:
                            new TextStyle(color: Colors.grey, fontSize: 15.0),
                      ),
                    ),
                  )
                ],
              ),
        ),
      ),
    );
  }
}

class CotacaoCompraPage extends StatefulWidget {
  @override
  _CotacaoCompraPageState createState() => new _CotacaoCompraPageState();
}

class _CotacaoCompraPageState extends State<CotacaoCompraPage> {
  @override
  Widget build(BuildContext context) {
    /*   return new Scaffold(
      appBar: new AppBar(
        title: new Text('CRK - Cotacao'),
      ),
      body: new Center(
        child: new ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) => new Column(
                children: <Widget>[
                  new Divider(
                    height: 10.0,
                  ),

                  /*new ListTile(
                    //leading: new CircleAvatar(
                    //  foregroundColor: Theme.of(context).primaryColor,
                    //  backgroundColor: Colors.grey,
                    //backgroundImage: new NetworkImage(dummyData[i].avatarUrl),
                    //),
                    title: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          jsonDecode(jsonEncode(
                              data[index]['item']['empCod'].toString())),
                        ),
                        new Text(
                          jsonDecode(jsonEncode(
                              data[index]['item']['cotCompNum'].toString())),
                          style:
                              new TextStyle(color: Colors.grey, fontSize: 14.0),
                        ),
                      ],
                    ),
                  )*/
                ],
              ),
       ),
      ),
   );
  }*/

    return Scaffold(
      appBar: new AppBar(
        title: new Text('CRK - Cotacao'),
      ),
      body: CustomScrollView(
        primary: false,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(20.0),
            sliver: SliverGrid.count(
              crossAxisSpacing: 10.0,
              crossAxisCount: 2,
              children: <Widget>[
                new ListTile(
                  subtitle: new Text('Pesquisar'),
                  title: new IconButton(
                    icon: new Icon(Icons.search),
                    onPressed: () async {
                      query =
                          "http://10.0.0.13:8889/v1/docfin/TopDocFin/?id=10&empcod=01";
                      await HomePageState().getData();
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new GetCotacaoPage()));
                    },
                  ),
                ),
                new ListTile(
                  subtitle: new Text('Adicionar'),
                  title: new IconButton(
                    icon: new Icon(Icons.add_box),
                    onPressed: null,
                  ),
                ),
                new ListTile(
                  subtitle: new Text('Enviar cotacoes'),
                  title: new IconButton(
                    icon: new Icon(Icons.email),
                    onPressed: null,
                  ),
                ),
                new ListTile(
                  subtitle: new Text('Importar cotacoes'),
                  title: new IconButton(
                    icon: new Icon(Icons.import_export),
                    onPressed: null,
                  ),
                ),
                new ListTile(
                  subtitle: new Text('Excluir cotacao'),
                  title: new IconButton(
                    icon: new Icon(Icons.delete),
                    onPressed: null,
                  ),
                ),
                new ListTile(
                  subtitle: new Text('Importacoes pendentes'),
                  title: new IconButton(
                    icon: new Icon(Icons.warning),
                    onPressed: null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GetCotacaoPage extends StatefulWidget {
  @override
  _GetCotacaoPageState createState() => new _GetCotacaoPageState();
}

class _GetCotacaoPageState extends State<GetCotacaoPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('CRK - Princiais cotacoes desta semana'),
      ),
      body: new Center(
        child: new ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) => new Column(
                children: <Widget>[
                  new Divider(
                    height: 10.0,
                  ),
                  new ListTile(
                    //leading: new CircleAvatar(
                    //  foregroundColor: Theme.of(context).primaryColor,
                    //  backgroundColor: Colors.grey,
                    //backgroundImage: new NetworkImage(dummyData[i].avatarUrl),
                    //),
                    title: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          jsonDecode(jsonEncode(
                              data[index]['item']['empCod'].toString())),
                        ),
                        new Text(
                          jsonDecode(jsonEncode(
                              data[index]['item']['docFinChv'].toString())),
                          style:
                              new TextStyle(color: Colors.grey, fontSize: 14.0),
                        ),
                      ],
                    ),
                    subtitle: new Container(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: new Text(
                        jsonDecode(
                            jsonEncode(data[index]['item']['docFinTipoLanc'])),
                        style:
                            new TextStyle(color: Colors.grey, fontSize: 15.0),
                      ),
                    ),
                  )
                ],
              ),
        ),
      ),
    );
  }
}

class Category {
  String name;
  String icon;

  Category(this.name, this.icon);
}

///
///
///
///
///
/*
List<Category> _categories = [
    Category('Sports', Icons.directions_run),
    Category('Politics', Icons.gavel),
    Category('Science', Icons.wb_sunny),
];


   children: <Widget>[
          Icon(_categories[index].icon),
          SizedBox(width: 20.0),
          Text(_categories[index].name),
        ],

 * */
