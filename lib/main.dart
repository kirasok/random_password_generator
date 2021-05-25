import 'dart:math';
import 'dart:ui';

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
        body: DefaultTextStyle(
          style: TextStyle(),
          child: ValuesList(_items),
        ),
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
        onTap: () {
          switch (item.title) {
            case "Password":
              _navigateTo(PasswordPage());
              break;
            case "Name":
              _navigateTo(NamePage());
              break;
            case "Nickname":
              _navigateTo(NicknamePage());
              break;
          }
        },
      );

  void _navigateTo(Widget to) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => to));
  }

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

class PasswordPage extends StatefulWidget {
  const PasswordPage({Key key}) : super(key: key);

  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  double _currentPasswordLength = 4;
  bool isIncludeLowercase = true;
  bool isIncludeUppercase = true;
  bool isIncludeNumbers = true;
  bool isIncludeSymbols = true;
  bool isExcludeSimilar = false;
  bool isExcludeAmbiguous = false;
  String password = "";
  Color colorOfPasswordBackground = Colors.transparent;

  String _generatePassword() {
    // Arrays with characters
    // I swear I didn't write it myself
    var lowercase = [
      "a",
      "b",
      "c",
      "d",
      "e",
      "f",
      "g",
      "h",
      "i",
      "j",
      "k",
      "l",
      "m",
      "n",
      "o",
      "p",
      "q",
      "r",
      "s",
      "t",
      "u",
      "v",
      "w",
      "x",
      "y",
      "z",
    ];
    var uppercase = [
      "A",
      "B",
      "C",
      "D",
      "E",
      "F",
      "G",
      "H",
      "I",
      "J",
      "K",
      "L",
      "M",
      "N",
      "O",
      "P",
      "Q",
      "R",
      "S",
      "T",
      "U",
      "V",
      "W",
      "X",
      "Y",
      "Z",
    ];
    var numbers = [
      "0",
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
    ];
    var symbols = [
      "!",
      "#",
      "\$",
      "%",
      "&",
      "*",
      "+",
      "-",
      "?",
      "@",
      "\"",
      "'",
      "(",
      ")",
      ",",
      ".",
      "/",
      ":",
      ";",
      "<",
      "=",
      ">",
      "[",
      "\\",
      "]",
      "^",
      "_",
      "`",
      "{",
      "|",
      "}",
      "~",
    ];
    var similar = [
      "1",
      "i",
      "I",
      "l",
      "L",
      "|",
      "o",
      "O",
      "0",
    ];
    var ambiguous = [
      "\"",
      "'",
      "(",
      ")",
      ",",
      ".",
      "/",
      ":",
      ";",
      "<",
      "=",
      ">",
      "[",
      "\\",
      "]",
      "^",
      "_",
      "`",
      "{",
      "|",
      "}",
      "~",
    ];
    // We do not add ambiguous because we already use them in symbols
    // The ambiguous array necessary only to remove them
    var resultChars =
        lowercase + uppercase + numbers + symbols + similar;
    if (!isIncludeLowercase)
      resultChars.removeWhere((element) => lowercase.contains(element));
    if (!isIncludeUppercase)
      resultChars.removeWhere((element) => uppercase.contains(element));
    if (!isIncludeNumbers)
      resultChars.removeWhere((element) => numbers.contains(element));
    if (!isIncludeSymbols)
      resultChars.removeWhere((element) => symbols.contains(element));
    if (isExcludeSimilar)
      resultChars.removeWhere((element) => similar.contains(element));
    if (isExcludeAmbiguous)
      resultChars.removeWhere((element) => ambiguous.contains(element));

    if (resultChars.isNotEmpty) {
      colorOfPasswordBackground = Colors.grey.shade300;
      String result = "";
      var random = Random.secure();
      for (var a = 0; a < _currentPasswordLength; a++) {
        result += resultChars[random.nextInt(resultChars.length)];
      }
      return result;
    } else {
      colorOfPasswordBackground = Colors.white;
      return "";
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text("Password Generator"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: DefaultTextStyle(
        style: TextStyle(),
        child: ListView(
          children: [
            // TODO: make slider be log2
            Slider(
              value: _currentPasswordLength,
              min: 4,
              max: 256,
              divisions: 252,
              label: _currentPasswordLength.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentPasswordLength = value;
                });
              },
            ),
            CheckboxListTile(
              title: Text("Include Lowercase Characters"),
              value: isIncludeLowercase,
              onChanged: (bool a) {
                setState(() {
                  isIncludeLowercase = a;
                });
              },
            ),
            CheckboxListTile(
              title: Text("Include Uppercase Characters"),
              value: isIncludeUppercase,
              onChanged: (bool a) {
                setState(() {
                  isIncludeUppercase = a;
                });
              },
            ),
            CheckboxListTile(
              title: Text("Include Numbers"),
              value: isIncludeNumbers,
              onChanged: (bool a) {
                setState(() {
                  isIncludeNumbers = a;
                });
              },
            ),
            CheckboxListTile(
              title: Text("Include Symbols"),
              value: isIncludeSymbols,
              onChanged: (bool a) {
                setState(() {
                  isIncludeSymbols = a;
                });
              },
            ),
            CheckboxListTile(
              title: Text("Exclude Similar Characters"),
              value: isExcludeSimilar,
              onChanged: (bool a) {
                setState(() {
                  isExcludeSimilar = a;
                });
              },
            ),
            CheckboxListTile(
              title: Text("Exclude Ambiguous Characters"),
              value: isExcludeAmbiguous,
              onChanged: (bool a) {
                setState(() {
                  isExcludeAmbiguous = a;
                });
              },
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    password = _generatePassword();
                  });
                },
                style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
                child: Text("Generate Password"),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              color: colorOfPasswordBackground,
              child: Text(password,
                  softWrap: true,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontFeatures: [FontFeature.tabularFigures()],
                  )),
            ),
          ],
        ),
      ));
}

class NamePage extends StatefulWidget {
  const NamePage({Key key}) : super(key: key);

  @override
  _NamePageState createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Name Generator"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      );
}

class NicknamePage extends StatefulWidget {
  const NicknamePage({Key key}) : super(key: key);

  @override
  _NicknamePageState createState() => _NicknamePageState();
}

class _NicknamePageState extends State<NicknamePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Nickname Generator"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      );
}
