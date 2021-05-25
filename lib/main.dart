import 'package:flutter/material.dart';

void main() {
  var items = [
    Item("Password", Icon(Icons.vpn_key)),
    Item("Name", Icon(Icons.person)),
    Item("Nickname", Icon(Icons.error)), // TODO: add icon
  ];
  items.sort((a, b) => a.title.compareTo(b.title));

  runApp(MyApp(items));
}

class Item {
  String title;
  Icon icon;

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
        body: Center(child: Text("Hello, my first myself developed app")),
      ),
    );
  }
}
