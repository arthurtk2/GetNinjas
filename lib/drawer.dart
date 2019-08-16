import 'package:flutter/material.dart';
import 'package:getninjas_mobile_teste/pages/home_page.dart';
import 'package:getninjas_mobile_teste/pages/orders_page.dart';
import 'package:getninjas_mobile_teste/utils/navigator.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              push(context, HomePage());
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment),
            title: Text('Pedidos'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              push(context, OrdersPage());
            },
          )
        ],
      ),
    );
  }
}
