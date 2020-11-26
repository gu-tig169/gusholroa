import './DataHandler.dart';

class ToDoHandler {

  static List<dynamic> toDoList = [];

  static Future<void> addItem(String name) async {
    toDoList = await DataHandler.createNewItem(name);
    print("Created item with name: " + name );
  }

  static Future<List<dynamic>> fetchListFromApi() async {
    toDoList = await DataHandler.fetchToDos();
    return toDoList;
  }

  static Future<void> updateBool(String name, bool newValue) async {
    for(var i = 0; i < toDoList.length; i++) {
      if(name == toDoList[i].name) {
        toDoList = await DataHandler.sendBoolChange(toDoList[i].id, toDoList[i].name, newValue);
        print("Item called: " + toDoList[i].name + " has isChecked status: " + newValue.toString());
      }
    }
  }

  static Future<void> deleteItem(String name) async {
    for(var i = 0; i < toDoList.length; i++) {
      if(name == toDoList[i].name) {
        print("Deleted item with name: " + toDoList[i].name);
        await DataHandler.sendDeletion(toDoList[i].id);
      }
    }
  }

  static List<dynamic> getDoneList() {
    return toDoList.where((item) => item.isChecked).toList();
  }

  static List<dynamic> getUndoneList() {
    return toDoList.where((item) => !item.isChecked).toList();
  }

  static List<dynamic> getList() {
    return toDoList;
  }

}