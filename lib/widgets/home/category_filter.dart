import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/providers/Products.dart';
import 'package:dropdown_search/dropdown_search.dart';

class CategoryFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productController = Get.put(Products());

    return GetBuilder<Products>(
      init: Products(),
      builder: (_) => Container(
        padding: EdgeInsets.all(10),
        child: DropdownSearch<String>.multiSelection(
            mode: Mode.BOTTOM_SHEET,
            popupBackgroundColor: Colors.white,
            dropdownSearchDecoration: InputDecoration(
                filled: true,
                labelText: 'Категория',
                hintText: 'Выберите категории',
                fillColor: Colors.white,
                floatingLabelStyle: TextStyle(color: Colors.black),
                iconColor: Colors.black,
                suffixIconColor: Colors.black,
                prefixIconColor: Colors.black,
                counterStyle: TextStyle(color: Colors.black),
                labelStyle: TextStyle(color: Colors.black),
                hintStyle: TextStyle(color: Colors.black)),
            showSelectedItems: true,
            dropdownSearchBaseStyle: TextStyle(color: Colors.black),
            items: productController.categoriesName,
            onChanged: (e) {
              productController.setCategoryItems(e);
            },
            selectedItems: []),
      ),
    );
  }
}
