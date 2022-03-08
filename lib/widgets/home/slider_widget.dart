import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:shop_app/providers/Products.dart';

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
          return CarouselSlider.builder(
              itemCount: productsController.newsItems.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) {
                return Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Image.network(
                                productsController.newsItems[itemIndex].photo),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 160,
                                child: Text(productsController
                                    .newsItems[itemIndex].name),
                              ),
                              Text(productsController
                                  .newsItems[itemIndex].price),
                            ],
                          )
                        ],
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
