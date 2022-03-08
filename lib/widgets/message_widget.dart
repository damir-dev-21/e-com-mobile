import 'package:flutter/material.dart';

Widget toast(String type, String text) {
  return Container(
    alignment: Alignment.center,
    width: 200,
    height: 70,
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: type == 'CART'
            ? Colors.orangeAccent
            : type == 'AUTH'
                ? Colors.greenAccent
                : Colors.redAccent),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    ),
  );
}
