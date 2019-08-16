import 'package:flutter/material.dart';
import 'package:getninjas_mobile_teste/views/leads_list.dart';
import 'package:getninjas_mobile_teste/views/offers_list.dart';
import '../drawer.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Pedidos'),
          backgroundColor: Colors.indigo,
          bottom: TabBar(tabs: [
            Tab(
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.loyalty),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text('Disponíveis'),
                  )
                ],
              ),
            ),
            Tab(
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.done),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text('Aceitos'),
                  )
                ],
              ),
            ),
          ]),
        ),
        body: TabBarView(children: [
          loadOrdersList(),
          loadLeadsList()]
        ),
        drawer: DrawerList(),
      ),
    );
  }
}
