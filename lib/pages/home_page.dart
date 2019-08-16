import 'package:flutter/material.dart';

import '../drawer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.indigo,
      ),
      body: _body(),
      drawer: DrawerList(),
    );
  }

  _body() {
    return Container(
        color: Colors.blue,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Teste Mobile GetNinjas',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text(
                'Arthur Utiyama Marubayashi',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 23),
              ),
            ],
          ),
        ));
  }
}
