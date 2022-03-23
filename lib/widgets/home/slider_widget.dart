import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:shop_app/providers/Products.dart';
import 'package:shop_app/screens/product_page.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({
    Key key,
    @required this.productsController,
  }) : super(key: key);

  final Products productsController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Products>(
        init: Products(),
        builder: (_) {
          return productsController.newsItems.isEmpty
              ? Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.white,
                  margin: const EdgeInsets.all(10),
                  child: Center(child: CircularProgressIndicator()))
              : CarouselSlider.builder(
                  itemCount: productsController.newsItems.length,
                  itemBuilder:
                      (BuildContext context, int itemIndex, int pageViewIndex) {
                    return Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder: (context, animation, _) {
                              return ProductPage(
                                  id: (productsController
                                      .newsItems[itemIndex].id));
                            }));
                          },
                          child: Container(
                            width: double.infinity,
                            color: Colors.white,
                            margin: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Image.network(productsController
                                        .newsItems[itemIndex].photo),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(productsController
                                          .newsItems[itemIndex].name),
                                      Text("Цена: " +
                                          productsController
                                              .newsItems[itemIndex].price),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                            top: 20,
                            right: 20,
                            child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  'Новинка',
                                  style: TextStyle(color: Colors.white),
                                )))
                      ],
                    );
                  },
                  options: CarouselOptions(
                      viewportFraction: 1,
                      autoPlay: true,
                      enableInfiniteScroll: false,
                      autoPlayInterval: Duration(seconds: 4)));
        });
  }
}
