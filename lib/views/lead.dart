import 'package:flutter/material.dart';
import 'package:getninjas_mobile_teste/models/Lead.dart';
import 'package:getninjas_mobile_teste/services/leads.dart';
import 'package:getninjas_mobile_teste/widgets/separator.dart';

class LeadPage extends StatefulWidget {
  final String url;

  const LeadPage(this.url);

  @override
  _LeadPageState createState() => _LeadPageState();
}

class _LeadPageState extends State<LeadPage> {
  get url => widget.url;
  final iconColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Informações do serviço'),
      ),
      body: _body(),
    );
  }

  _body() {
    return FutureBuilder<Lead>(
      future: ApiLeads.getLead(url),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
              child: Text(
                'Erro ao carregar o pedido',
                style: TextStyle(fontWeight: FontWeight.bold),
              ));
        } else if (!snapshot.hasData) {
          return Center(
              child: CircularProgressIndicator(
              ));
        } else {
          return _view(snapshot.data);
        }
      },
    );
  }

  _view(Lead lead) {
    return Container(
        color: Colors.blue,
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
                        lead.title,
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
                          lead.leadEmbedded.user.name,
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
                          lead.leadEmbedded.address.neighborhood +
                              ' - ' +
                              lead.leadEmbedded.address.city,
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
                        'A ' + lead.distance.toString() + 'KM de você',
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
                    itemCount: lead.leadEmbedded.info.length,
                    itemBuilder: (BuildContext context, int index) =>
                        _infos(lead.leadEmbedded.info[index]),
                  ),
                ),
                Container(
                  color: Colors.lightGreen,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            'Contato do cliente',
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                        lead.leadEmbedded.user.userEmbedded.phones.length,
                        itemBuilder: (BuildContext context, int index) => Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.phone,
                                size: 18,
                                color: Colors.black,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  lead.leadEmbedded.user.userEmbedded
                                      .phones[index].number,
                                  style: TextStyle(color: Colors.black),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.email,
                            size: 18,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              lead.leadEmbedded.user.email,
                              style: TextStyle(color: Colors.black),
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
                    child: Text('Fale com o cliente o quanto antes!', style: TextStyle(
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
