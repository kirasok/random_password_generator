import 'package:flutter/material.dart';

void main() {
  var items = [
    Item("Password", Icons.vpn_key),
    Item("Name", Icons.person),
    Item("Nickname", Icons.error), // TODO: add icon
  ];
  items.sort((a, b) => a.title.compareTo(b.title));

  runApp(MyApp(items));
}

class Item {
  String title;
  IconData icon;

  Item(this.title, this.icon);
}

class MyApp extends StatelessWidget {
  final List items;

  MyApp(this.items);

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
        body: ValuesList(items),
      ),
    );
  }
}

class ValuesList extends StatefulWidget {
  final List items;

  const ValuesList(this.items, {Key key}) : super(key: key);

  @override
  _ValuesListState createState() => _ValuesListState(items);
}

class _ValuesListState extends State<ValuesList> {

  final List items;
  _ValuesListState(this.items);

  Widget buildRow(Item item) => ListTile(
    title: Text(item.title),
    trailing: Icon(item.icon),
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: items.length + 2,
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        final index = i ~/ 2;
        return buildRow(items[index]);
      },
    );
  }
}

