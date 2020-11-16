import 'package:flutter/material.dart';
// Robin Holms Flutter-applikation.

void main() {
  runApp(MaterialApp(
    home: SecondWindow(),));}

class FirstWindow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.grey,
            leading: IconButton(icon:Icon(Icons.arrow_back_ios),
              onPressed:() => Navigator.pop(context),
            ),
            title: Text('TIG 169 TODO', style: TextStyle(color: Colors.black)),
          ),
          body: Center(
            child: Column(
                children: <Widget> [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2.0,
                          color: Colors.black,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('What are you going to do?', style: TextStyle(color: Colors.grey))
                        ),
                      ),
                    ),
                  ),
                  Text('+ ADD', style: TextStyle(fontWeight: FontWeight.bold)),
                ]
            ),
          )
      ),
    );
  }
}

class SecondWindow extends StatefulWidget {
  @override
  _SecondWindowState createState() => _SecondWindowState();
}

class _SecondWindowState extends State<SecondWindow> {

  bool _isChecked = false;
  bool _isChecked2 = false;
  bool _isChecked3 = false;
  var str = "List object";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.grey,
          title: Text('TIG 169 TODO', style: TextStyle(color: Colors.black)),
          actions: <Widget>[
            PopupMenuButton<String>(
              itemBuilder: (BuildContext context) {
                return {'All', 'Done', 'Undone'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: Center(
            child: ListView(
              children: <Widget>[
                Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          children: <Widget>[
                            Checkbox(
                              activeColor: Colors.grey,
                              checkColor: Colors.black,
                              value: _isChecked,
                              onChanged: (bool value) {
                                setState(() {
                                  _isChecked = value;
                                });
                              },
                            ),
                            Text('List object', style: TextStyle(fontSize: 25)),
                            Spacer(),
                            CloseButton(),
                          ]
                      ),
                    )
                ),
                Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          children: <Widget>[
                            Checkbox(
                              activeColor: Colors.grey,
                              checkColor: Colors.black,
                              value: _isChecked2,
                              onChanged: (bool value) {
                                setState(() {
                                  _isChecked2 = value;
                                });
                              },
                            ),
                            Text('List object', style: TextStyle(fontSize: 25)),
                            Spacer(),
                            CloseButton(),
                          ]
                      ),
                    )
                ),
                Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          children: <Widget>[
                            Checkbox(
                              activeColor: Colors.grey,
                              checkColor: Colors.black,
                              value: _isChecked3,
                              onChanged: (bool value) {
                                setState(() {
                                  _isChecked3 = value;
                                });
                              },
                            ),
                            Text('List object', style: TextStyle(fontSize: 25)),
                            Spacer(),
                            CloseButton(),
                          ]
                      ),
                    )
                ),
              ],
            )
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 4,
          backgroundColor: Colors.grey,
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return FirstWindow();
              }),
            );
          },
        ),
      ),
    );
  }
}