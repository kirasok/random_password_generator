import 'package:flutter/material.dart';

void main() {
  var _items = [
    Item("Password", Icons.vpn_key),
    Item("Name", Icons.person),
    Item("Nickname", Icons.error), // TODO: add icon
  ];
  _items.sort((a, b) => a.title.compareTo(b.title));

  runApp(MyApp(_items));
}

class Item {
  String title;
  IconData icon;

  Item(this.title, this.icon);
}

class MyApp extends StatelessWidget {
  final List _items;

  MyApp(this._items);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Values Generator',
      theme: ThemeData(
          primarySwatch: Colors.lightBlue, accentColor: Colors.amberAccent),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Random Values Generator"),
        ),
        body: ValuesList(_items),
      ),
    );
  }
}

class ValuesList extends StatefulWidget {
  final List _items;

  const ValuesList(this._items, {Key key}) : super(key: key);

  @override
  _ValuesListState createState() => _ValuesListState(_items);
}

class _ValuesListState extends State<ValuesList> {

  final List _items;
  _ValuesListState(this._items);

  Widget _buildRow(Item item) => ListTile(
    title: Text(item.title),
    trailing: Icon(item.icon),
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: _items.length + 2,
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        final index = i ~/ 2;
        return _buildRow(_items[index]);
      },
    );
  }
}

