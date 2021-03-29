import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kinfolk/kinfolk.dart';
import 'package:test_project/pages/profile/profile.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController;
  TextEditingController _passwordTextController;
  bool hidePass;
  Kinfolk kinfolk = Kinfolk();

  @override
  initState() {
    super.initState();
    hidePass = true;
    kinfolk.initializeBaseVariables(
      "https://dev.uco.kz/knu",
      "client",
      "secret",
    );
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  void _onLoading() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 100.0),
        child: CircularProgressIndicator(),
      ),
    );
  }

  _showDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title:  Text("Not correct login or password"),
            actions: <Widget>[
              // ignore: deprecated_member_use
               FlatButton(
                child:  Text("Oк", style: TextStyle(color: Colors.black),),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
      child: GestureDetector(
      onTap: () async {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          brightness: Brightness.dark,
          backgroundColor: Colors.black,
        ),
        body: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                    child: TextFormField(
                      controller: _emailTextController,
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                      cursorColor: Colors.black,
                      // ignore: missing_return
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter login";
                        }
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Логин',
                        hintStyle: TextStyle(fontSize: 16, color: Colors.white),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                    child: TextFormField(
                      controller: _passwordTextController,
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                      cursorColor: Colors.black,
                      obscureText: hidePass,
                      // ignore: missing_return
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter password";
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Пароль',
                        hintStyle: TextStyle(fontSize: 16, color: Colors.white),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                        suffixIcon: Container(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                  hidePass = !hidePass;
                                }
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Icon(
                                hidePass
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  InkWell(
                    onTap: () async {
                      String login = _emailTextController.text,
                          password = _passwordTextController.text;
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        var client = await Kinfolk().getToken(login.trim(), password.trim());
                        if(client is String){
                          var text;
                          switch(client) {
                            case "ACCESS_ERROR":
                              _showDialog(context);
                             break;
                            case 'CONNECTION_TIME_OUT':
                              _showDialog(context);
                            break;
                            default:
                              text = client;
                          }
                          return null;
                        }else {
                          _onLoading();
                          Future.delayed(Duration(seconds: 3), () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfilePage(),
                              ),
                            );
                          });
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(11.0)),
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 100.0),
                      child: Text(
                        "Войти",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Center(
                      child: Text(
                        "Регистрация",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      ),
    );
  }
}
