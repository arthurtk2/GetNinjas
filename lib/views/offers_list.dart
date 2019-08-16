import 'package:flutter/material.dart';
import 'package:getninjas_mobile_teste/models/Offers.dart';
import 'package:getninjas_mobile_teste/services/offers.dart';
import 'package:getninjas_mobile_teste/utils/navigator.dart';
import 'package:getninjas_mobile_teste/widgets/separator.dart';
import 'offer.dart';

loadOrdersList() {
  return Container(
      color: Colors.blue,
      padding: EdgeInsets.all(12),
      child: FutureBuilder<List<Offer>>(
        future: ApiOffers.getList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text(
              'Erro ao exibir seus pedidos',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ));
          } else if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            ));
          } else {
            return _listView(snapshot.data);
          }
        },
      ));
}

_listView(List<Offer> offers) {
  return ListView.builder(
      itemCount: offers.length,
      itemBuilder: (ctx, idx) {
        final offer = offers[idx];
        final Color color = offer.state == 'read' ? Colors.blue : Colors.grey;

        return Container(
          child: InkWell(
            onTap: () {
              _openOrder(ctx, offer.links.self.href);
            },
            child: Card(
              child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        offer.offerEmbedded.request.title,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      SeparatorWidget(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.account_circle,
                                  size: 18,
                                  color: color,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    offer.offerEmbedded.request.requestEmbedded
                                        .requestUser.name,
                                    style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.calendar_today,
                                  size: 18,
                                  color: color,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    offer.offerEmbedded.request.createdAt,
                                    style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            size: 18,
                            color: color,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              offer.offerEmbedded.request.requestEmbedded
                                      .requestAddress.neighborhood +
                                  ' - ' +
                                  offer.offerEmbedded.request.requestEmbedded
                                      .requestAddress.city,
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 15),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
          ),
        );
      });
}

_openOrder(BuildContext context, url) {
  push(context, OfferPage(url));
}
