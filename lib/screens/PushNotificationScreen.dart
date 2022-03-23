import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/constants/colors.dart';
import 'package:shop_app/models/Notif.dart';
import 'package:shop_app/providers/PushNotifications.dart';

class PushNotificationScreen extends StatelessWidget {
  final PushNotificationsController pushNController =
      Get.put(PushNotificationsController());
  @override
  Widget build(BuildContext context) {
    final List<Notif> notf = pushNController.items;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: appBarColor,
          title: Text('Уведомления'),
          centerTitle: true),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: notf.length,
                itemBuilder: (ctx, i) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: 220,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 220 / 2,
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Align(
                                    alignment: Alignment.topRight,
                                    child: Text(notf[i].date,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black38))),
                              ),
                              Container(
                                  width: double.infinity,
                                  height: 220 / 3,
                                  child: Image.network(
                                    notf[i].product.photo,
                                    fit: BoxFit.contain,
                                  )),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              Container(
                                child: Center(
                                    child: Text('Добавлен новый товар',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.redAccent))),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Center(
                                    child: Text(notf[i].product.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black))),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
          ),
        ],
      )),
    );
  }
}
