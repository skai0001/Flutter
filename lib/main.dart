import 'package:flutter/material.dart';
import 'package:sqflitedatabase/database/dbhelper.dart';
import 'package:sqflitedatabase/model/User.dart';
import 'package:sqflitedatabase/userlist.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'MY DataBase ',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'MY Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  User user = new User("", "", "");

  String firstname;
  String lastname;
  String emailId;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
          title: new Text('Adding User'),
          actions: <Widget>[
            new IconButton(
              icon: const Icon(Icons.view_list),
              tooltip: 'Next choice',
              onPressed: () {
                navigateToEmployeeList();
              },
            ),
          ]
      ),
      body: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Form(
          key: formKey,
          child: new Column(
            children: [
              new TextFormField(
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(labelText: 'First Name'),
                validator: (val) =>
                val.length == 0 ?"Enter FirstName" : null,
                onSaved: (val) => this.firstname = val,
              ),
              new TextFormField(
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(labelText: 'Last Name'),
                validator: (val) =>
                val.length ==0 ? 'Enter LastName' : null,
                onSaved: (val) => this.lastname = val,
              ),
              new TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: new InputDecoration(labelText: 'Email Id'),
                validator: (val) =>
                val.length ==0 ? 'Enter Email Id' : null,
                onSaved: (val) => this.emailId = val,
              ),
              new Container(margin: const EdgeInsets.only(top: 10.0),child: new RaisedButton(onPressed: _submit,
                child: new Text('Save'),),)

            ],
          ),
        ),
      ),
    );
  }
  void _submit() {
    if (this.formKey.currentState.validate()) {
      formKey.currentState.save();
    }else{
      return null;
    }
    var user = User(firstname,lastname,emailId);
    var dbHelper = DBHelper();
    dbHelper.saveEmployee(user);
    _showSnackBar("Data saved successfully");
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  void navigateToEmployeeList(){
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new MyUserList()),
    );
  }
}
