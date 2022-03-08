// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/providers/Products.dart';

class SearchInput extends StatelessWidget {
  TextEditingController _textSearch = TextEditingController();

  Products productController = Get.put(Products());

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4)),
        margin: EdgeInsets.all(10),
        child: TextField(
          controller: _textSearch,
          onChanged: (e) {
            productController.searchedCart(e);
          },
          decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.black),
              labelText: 'Поиск товаров',
              prefixIcon: Icon(Icons.search, color: Colors.black)),
        ));
  }
}
