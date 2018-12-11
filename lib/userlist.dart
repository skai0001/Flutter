import 'package:flutter/material.dart';
import 'package:sqflitedatabase/model/User.dart';
import 'dart:async';
import 'package:sqflitedatabase/database/dbhelper.dart';

Future<List<User>> fetchUserFromDatabase() async {
  var dbHelper = DBHelper();
  Future<List<User>> users = dbHelper.getUsers();
  return users;
}

class MyUserList extends StatefulWidget {
  @override
  MyUserListPageState createState() => new MyUserListPageState();
}

class MyUserListPageState extends State<MyUserList> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Users List'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(16.0),
        child: new FutureBuilder<List<User>>(
          future: fetchUserFromDatabase(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(snapshot.data[index].firstName,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          new Text(snapshot.data[index].lastName,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0)),

                          new Divider()
                        ]);
                  });
            } else if (snapshot.hasError) {
              return new Text("${snapshot.error}");
            }
            return new Container(alignment: AlignmentDirectional.center,child: new CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }
}
