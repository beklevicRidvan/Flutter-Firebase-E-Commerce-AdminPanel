import 'package:flutter/material.dart';

class Constants {
  static TextStyle getBoldStyle({required double fontSize}) {
    return TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize);
  }

  static TextStyle getNormalStyle({required double fontSize}) {
    return TextStyle(fontSize: fontSize);
  }

  static TextStyle getBoldColorStyle(
      {required double fontSize, required Color color}) {
    return TextStyle(
        color: color, fontSize: fontSize, fontWeight: FontWeight.bold);
  }

  static TextStyle getNormalColorStyle({required double fontSize}) {
    return TextStyle(fontSize: fontSize);
  }

  static EdgeInsets getNormalPadding() {
    return const EdgeInsets.all(16);
  }

  static EdgeInsets getLittlePadding() {
    return const EdgeInsets.all(8);
  }

  static EdgeInsets getNormalMargin() {
    return const EdgeInsets.all(16);
  }

  static EdgeInsets getBottomMargin() {
    return const EdgeInsets.only(bottom: 5);
  }

  static String getSpliceWord(String word) {
    List<String> words = word.split(" ");
    if (words.length >= 2) {
      return "${words[0]} ${words[1]}\n\t${words.sublist(2).join(" ")}";
    } else {
      return word;
    }
  }

  static String placeHolderImageAdress = "assets/placeholder.png";

  static Color circularProgressIndicatorColor = const Color(0xffFF5252);

  static List<Icon> menuItems = const [Icon(Icons.edit), Icon(Icons.clear)];

  static FloatingActionButton buildFloatingActionButton(VoidCallback func) {
    return FloatingActionButton(
      onPressed: () => func(),
      shape: const CircleBorder(),
      backgroundColor: Colors.red,
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 35,
      ),
    );
  }
  static List<String> toolList = ["Güncelle,Sil"];
  static List<Icon> iconList = const [Icon(Icons.edit,size: 30,), Icon(Icons.clear,size: 30,)];
  static Widget buildPopMenu(

      BuildContext context, List<VoidCallback> funcList) {
    return PopupMenuButton<int>(
      color: Color(0xff212121),
      iconColor: Colors.red,
      iconSize: 35,
      onSelected: (value) => funcList[value](),
        itemBuilder: (context) => List.generate(
              iconList.length,
              (index) => PopupMenuItem(value: index, child: iconList[index],),
            ));
  }
}
