import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:kinfolk/kinfolk.dart';
import 'package:kinfolk/model/url_types.dart';
import 'package:test_project/modal/modal.dart';
import 'package:test_project/pages/auth/auth.dart';

class ProfilePage extends StatefulWidget {
  final profile;

  ProfilePage({Key key, this.profile}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  dynamic model;
  @override
  initState() {
    getList();
    super.initState();
  }

  Future<List<Users>> getList() {
    model = Kinfolk.getListModelRest(
        serviceOrEntityName: "base\$UserExt",
        type: Types.entities,
        fromMap: (val) => Users.fromMap(val).toMap(),
        methodName: '');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "UCO USERLIST",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          brightness: Brightness.dark,
          actions: [
            IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>AuthPage(),),);
                }),
          ],
        ),
        body: FutureBuilder(
            future: model,
            // ignore: missing_return
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 100.0),
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (!snapshot.hasError) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, index) {
                        return Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Fullname: ",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.0),
                                  ),
                                  Flexible(
                                    child: Text(
                                      snapshot.data[index]['fullName'],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.0),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "email: ",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.0),
                                  ),
                                  Flexible(
                                    child: Text(
                                      snapshot.data[index]['login'],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.0),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.purple),
                        );
                      });
                }
              }
            }),
      ),
    );
  }
}