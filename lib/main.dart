import 'package:flutter/material.dart';
import './SecondView.dart';
import './Constants.dart';
import './ToDoHandler.dart';

void main() {
  runApp(MaterialApp(
    home: MyToDo(),));}

class MyToDo extends StatefulWidget {
  @override
  _MyToDoState createState() => _MyToDoState();
}

class _MyToDoState extends State<MyToDo> {

  List<dynamic> _theList = [];

  void _selectMenuOption(String choiceItem) {
    setState(() {
      switch(choiceItem){
        case "all": {
          _theList = ToDoHandler.getList();
        }
        break;
        case "done": {
          _theList = ToDoHandler.getDoneList();
        }
        break;
        case "undone": {
          _theList = ToDoHandler.getUndoneList();
        }
        break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: ToDoHandler.fetchListFromApi(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if( snapshot.connectionState == ConnectionState.waiting){
          return  Center(child: Text('Please wait its loading...'));
        }else{
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else
            _theList = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Colors.grey,
                title: Text('TIG 169 TODO', style: TextStyle(color: Colors.black)),
                actions: [
                  PopupMenuButton<String>(
                    onSelected: _selectMenuOption,
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
              body: ListView.builder(
                  itemCount: _theList.length,
                  itemBuilder: (context, index) {
                    return Row(
                        children: <Widget>[
                          Checkbox(
                            checkColor: Colors.black,
                            activeColor: Colors.grey,
                            value: _theList[index].isChecked,
                            onChanged: (bool newValue) {
                              setState(() {
                                _theList[index].isChecked = newValue;
                                ToDoHandler.updateBool(_theList[index].name, newValue);
                              });
                            },
                          ),
                          Text(_theList[index].name, style: TextStyle(fontSize: 18)),
                          Spacer(),
                          CloseButton(
                              onPressed: () {
                                setState(() {
                                  ToDoHandler.deleteItem(_theList[index].name);
                                  _theList.remove(_theList[index]);
                                });
                              }
                          ),
                        ]
                    );
                  }),
              floatingActionButton: FloatingActionButton(
                elevation: 4,
                backgroundColor: Colors.grey,
                child: const Icon(Icons.add),
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondView()),
                  );
                  setState(() {
                    ToDoHandler.addItem(result);
                  });
                },
              ),
            );
        }
      },
    );
  }

}