import 'package:flutter/material.dart';
import 'package:getninjas_mobile_teste/models/Leads.dart';
import 'package:getninjas_mobile_teste/services/leads.dart';
import 'package:getninjas_mobile_teste/utils/navigator.dart';
import 'package:getninjas_mobile_teste/widgets/separator.dart';
import 'lead.dart';

loadLeadsList() {
  return Container(
      color: Colors.blue,
      padding: EdgeInsets.all(12),
      child: FutureBuilder<List<Lead>>(
        future: ApiLeads.getList(),
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

_listView(List<Lead> leads) {
  return ListView.builder(
      itemCount: leads.length,
      itemBuilder: (ctx, idx) {
        final lead = leads[idx];
        final Color color = Colors.green;

        return Container(
          child: InkWell(
            onTap: () {
              _openLeads(ctx, lead.links.self.href);
            },
            child: Card(
              child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        lead.leadEmbedded.embeddedRequest.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
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
                                    lead.leadEmbedded.embeddedUser.name,
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
                                    lead.createdAt,
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
                              lead.leadEmbedded.embeddedAddress.neighborhood +
                                  ' - ' +
                                  lead.leadEmbedded.embeddedAddress.city,
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

_openLeads(BuildContext context, url) {
  push(context, LeadPage(url));
}
