import 'package:http/http.dart' as http;
import 'dart:convert';
import './Item.dart';
import './Constants.dart';

class DataHandler {

  static Future<List<dynamic>> fetchToDos() async {
    http.Response response = await http.get(Constants.BaseURL + 'todos?key=' + Constants.Key);
    return _mapResponseToList(response);
  }

  static List<dynamic> _mapResponseToList(http.Response response) {
    List<dynamic> list = [];
    var jsonResponseBody = response.body;
    var responseBody = jsonDecode(jsonResponseBody);
    responseBody.map((object) {
      list.add(Item(object["id"], object["title"], Item.parseBool(object["done"]),));
    }).toList();
    for(var i = 0; i < list.length; i++) {
      print(list[i].id);
      print(list[i].name);
    }
    return list;
  }

  static Future<List<dynamic>> createNewItem(String name) async {
    http.Response response = await http.post(
      Constants.BaseURL + 'todos?key=' + Constants.Key,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': name,
        'done': 'false',
      }),
    );
    return _mapResponseToList(response);
  }

  static Future<List<dynamic>> sendBoolChange(String id, String name, bool newValue) async {
    http.Response response =  await http.put(
        Constants.BaseURL + 'todos/' + id + '?key=' + Constants.Key,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'title': name,
          'done': newValue.toString(),
        }));
    return _mapResponseToList(response);
  }

  static Future<List<dynamic>> sendDeletion(String id) async {
    http.Response response = await http.delete(Constants.BaseURL + 'todos/' + id + '?key=' + Constants.Key);
    return _mapResponseToList(response);
  }

}