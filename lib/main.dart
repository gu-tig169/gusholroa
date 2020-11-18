import 'package:flutter/material.dart';
import './Item.dart';
import './Constants.dart';

void main() {
  runApp(MaterialApp(
    home: MyToDo(),));}

class MyToDo extends StatefulWidget {
  @override
  _MyToDoState createState() => _MyToDoState();
}

class _MyToDoState extends State<MyToDo> {

  List<dynamic> _toDoList = [];
  List<dynamic> _displayedList = [];
  final _myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _displayedList = _toDoList;
  }

  void _selectMenuItem(String choiceItem) {
    setState(() {
      switch(choiceItem){
        case "all": {
          setState(() {
            _displayedList = _toDoList;
          });
        }
        break;
        case "done": {
          setState(() {
            _displayedList = _toDoList.where((item) => item.isChecked).toList();
          });
        }
        break;
        case "undone": {
          setState(() {
            _displayedList = _toDoList.where((item) => !item.isChecked).toList();
          });
        }
        break;
      }
    });
  }

  void _createToDoItem() {
    if(_myController.text.length > 0) {
      setState(() {
        _toDoList.add(Item(_toDoList.length, _myController.text, false));
        _displayedList = _toDoList;
        _myController.clear();
        Navigator.pop(context);
      });
    }
  }

  void _renderToDoPage(){
    Navigator.of(context).push(
        new MaterialPageRoute(
            builder: (context) {
              return new Scaffold(
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
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: TextField(
                                        autofocus: true,
                                        controller: _myController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'What are you going to do?',
                                        )
                                    )
                                ),
                              ),
                            ),
                          ),
                          RaisedButton.icon(
                            icon: Icon(Icons.add),
                            onPressed:() => _createToDoItem(),
                            label: Text('ADD', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ]
                    ),
                  )
              );
            }
        )
    );
  }

  Widget _buildListOfTasks() {
    // ignore: missing_return
    return ListView.builder(
        itemCount: _displayedList.length,
        itemBuilder: (context, index) {
          return Row(
              children: <Widget>[
                Checkbox(
                  checkColor: Colors.black,
                  activeColor: Colors.grey,
                  value: _displayedList[index].isChecked,
                  onChanged: (bool newValue) {
                    setState(() {
                      _displayedList[index].isChecked = newValue;
                    });
                  },
                ),
                Text(_displayedList[index].name, style: TextStyle(fontSize: 25)),
                Spacer(),
                CloseButton(
                    onPressed: () {
                      var removeMe = _displayedList[index];
                      setState(() {
                        _displayedList.remove(removeMe);
                      });
                      _toDoList.removeWhere((element) => element.id == removeMe.id);
                    }
                ),
              ]
          );
        });
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.grey,
        title: Text('TIG 169 TODO', style: TextStyle(color: Colors.black)),
        actions: [
          PopupMenuButton<String>(
            onSelected: _selectMenuItem,
            itemBuilder: (BuildContext context) {
              return Constants.ChoiceItems.map((String choiceItem) {
                return PopupMenuItem<String>(
                  value: choiceItem,
                  child: Text(choiceItem),
                );
              }).toList();
            },
          )
        ],
      ),
      body: _buildListOfTasks(),
      //body: Container(child: SelectedOption(choice: _list),),
      floatingActionButton: FloatingActionButton(
        elevation: 4,
        backgroundColor: Colors.grey,
        child: const Icon(Icons.add),
        onPressed: _renderToDoPage,
      ),
    ),
  );

}