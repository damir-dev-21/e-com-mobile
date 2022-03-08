import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shop_app/providers/AuthController.dart';
import 'package:shop_app/screens/AuthScreen.dart';
import 'package:shop_app/widgets/message_widget.dart';

class RegScreen extends StatefulWidget {
  @override
  State<RegScreen> createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  bool isObsured = true;
  FToast ftoast;

  String name = '';
  String email = '';
  String password = '';
  String repeatPassword = '';

  @override
  void initState() {
    super.initState();
    ftoast = FToast();
    ftoast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    final AuthControlller authControlller = Get.put(AuthControlller());
    return Scaffold(
      body: GetBuilder<AuthControlller>(
          init: AuthControlller(),
          builder: (_) {
            return SafeArea(
              child: authControlller.isLoad
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Регистрация",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 22)),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (text) => {
                                setState(() {
                                  name = text;
                                })
                              },
                              decoration: InputDecoration(
                                  labelText: 'Имя пользователя',
                                  prefixIcon: Icon(Icons.email),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5))),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (text) => {
                                setState(() {
                                  email = text;
                                })
                              },
                              decoration: InputDecoration(
                                  labelText: 'Email пользователя',
                                  prefixIcon: Icon(Icons.email),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5))),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: TextField(
                              keyboardType: TextInputType.text,
                              onChanged: (text) => {
                                setState(() {
                                  password = text;
                                })
                              },
                              obscureText: isObsured,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(isObsured
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        isObsured = !isObsured;
                                      });
                                    },
                                  ),
                                  labelText: 'Пароль',
                                  prefixIcon: Icon(Icons.password_rounded),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5))),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: TextField(
                              keyboardType: TextInputType.text,
                              onChanged: (text) => {
                                setState(() {
                                  repeatPassword = text;
                                })
                              },
                              obscureText: isObsured,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(isObsured
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        isObsured = !isObsured;
                                      });
                                    },
                                  ),
                                  labelText: 'Повторите пароль',
                                  prefixIcon: Icon(Icons.password_rounded),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5))),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            height: 50,
                            child: TextButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => Colors.blue)),
                                onPressed: () {
                                  authControlller.reg(name, email, password);
                                  ftoast.showToast(
                                      child: toast(
                                          'AUTH', 'Регистрация прошла успешно'),
                                      toastDuration: Duration(seconds: 2),
                                      positionedToastBuilder: (context, child) {
                                        return Align(
                                          child: child,
                                          alignment: Alignment.center,
                                        );
                                      });
                                },
                                child: Container(
                                  child: Text(
                                    'Зарегистрироваться',
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white),
                                  ),
                                )),
                          ),
                          Container(
                            width: double.infinity,
                            height: 50,
                            child: TextButton(
                                onPressed: () {
                                  Get.to(AuthScreen());
                                },
                                child: Container(
                                  child: Text(
                                    'Войти',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.blue),
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
            );
          }),
    );
  }
}
