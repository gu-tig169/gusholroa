
class Item {

  String id;
  String name;
  bool isChecked;
  Item(this.id, this.name, this.isChecked);

  static bool parseBool(String str) {
    if(str == 'true' || str == "True") {
      return true;
    } else return false;
  }

}