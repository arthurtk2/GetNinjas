import 'package:flutter/material.dart';
import 'package:getninjas_mobile_teste/models/Offer.dart';
import 'package:getninjas_mobile_teste/services/offers.dart';
import 'package:getninjas_mobile_teste/widgets/separator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OfferPage extends StatefulWidget {
  final String url;

  const OfferPage(this.url);

  @override
  _OfferPageState createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
  get url => widget.url;
  final iconColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informações da oferta'),
        backgroundColor: Colors.indigo,
      ),
      body: _body(),
    );
  }

  _body() {
    return FutureBuilder<Offer>(
      future: ApiOffers.getOffer(url),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
              child: Text(
            'Erro ao carregar o pedido',
            style: TextStyle(fontWeight: FontWeight.bold),
          ));
        } else if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          return _view(snapshot.data);
        }
      },
    );
  }

  _view(Offer offer) {
    return Container(
        color: iconColor,
        padding: EdgeInsets.all(20),
        child: Card(
            color: Colors.white,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
                  child: Row(
                    children: <Widget>[
                      Text(
                        offer.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                SeparatorWidget(),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12, right: 12, bottom: 20),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.account_circle,
                        size: 18,
                        color: iconColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          offer.offerEmbedded.user.name,
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        size: 18,
                        color: iconColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          offer.offerEmbedded.address.neighborhood +
                              ' - ' +
                              offer.offerEmbedded.address.city,
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 40, top: 5),
                      child: Text(
                        'A ' + offer.distance.toString() + 'KM de você',
                        style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                      ),
                    )
                  ],
                ),
                SeparatorWidget(),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: offer.offerEmbedded.info.length,
                    itemBuilder: (BuildContext context, int index) =>
                        _infos(offer.offerEmbedded.info[index]),
                  ),
                ),
                Container(
                  color: Colors.lightBlueAccent,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            'Contato do cliente',
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            offer.offerEmbedded.user.userEmbedded.phones.length,
                        itemBuilder: (BuildContext context, int index) => Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.lock,
                                size: 18,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  offer.offerEmbedded.user.userEmbedded
                                      .phones[index].number,
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.lock,
                            size: 18,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              offer.offerEmbedded.user.email,
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text('Aceite o pedido para destravar o contato!', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),),
                  ),
                )
              ],
            )));
  }

  _infos(Info info) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.error,
                    size: 18,
                    color: iconColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(info.label),
                  )
                ],
              ),
            ),
            ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: info.value.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(
                          info.value[index],
                          style:
                              TextStyle(fontSize: 13, color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
