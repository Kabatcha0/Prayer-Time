import 'package:flutter/material.dart';

void navigatorAndPushReplacement(
    {required BuildContext context, required Widget widget}) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}

void navigator({required BuildContext context, required Widget widget}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

Widget listTile({
  required String prayer,
  required String time,
}) {
  return ListTile(
    tileColor: const Color.fromARGB(255, 40, 15, 83),
    leading: Image.asset(
      "assets/ramadan.png",
      height: 40,
      width: 40,
      fit: BoxFit.fill,
    ),
    title: Text(prayer,
        style: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
    trailing: Padding(
      padding: const EdgeInsetsDirectional.only(end: 5),
      child: Text(time,
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
    ),
  );
}

Widget textFormField(
    {required TextEditingController textEditingController,
    required Function(String) onChanged}) {
  return TextFormField(
    decoration: InputDecoration(
        hintText: "Search",
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.white, width: 0.8)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.white, width: 0.8)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.white, width: 0.8)),
        hintStyle: TextStyle(color: Colors.grey[300], fontSize: 16),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.white, width: 0.8))),
    style: const TextStyle(color: Colors.white, fontSize: 18),
    controller: textEditingController,
    onChanged: onChanged,
  );
}
