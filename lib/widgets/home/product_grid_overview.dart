import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/providers/Products.dart';
import 'package:shop_app/screens/product_page.dart';

class ProductsGridOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsController = Get.put(Products());
    return GetBuilder<Products>(
        init: Products(),
        builder: (_) {
          return productsController.items.isEmpty
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : GridView.builder(
                  padding: EdgeInsets.all(20),
                  itemCount: productsController.popularOrCategory.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.5,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 25,
                  ),
                  itemBuilder: (ctx, i) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        child: GridTile(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(PageRouteBuilder(
                                  pageBuilder: (context, animation, _) {
                                return ProductPage(
                                  id: productsController
                                      .popularOrCategory[i].id,
                                );
                              }));
                            },
                            child: Image.network(
                              productsController.popularOrCategory[i].photo,
                            ),
                          ),
                          footer: GridTileBar(
                            backgroundColor: Colors.white,
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  productsController.popularOrCategory[i].name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  productsController.popularOrCategory[i].price
                                          .toString() +
                                      '\$',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
        });
  }
}
