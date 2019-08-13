import 'package:getninjas_mobile_teste/models/EntryPoint.dart' as entryPointModel;
import 'package:getninjas_mobile_teste/models/Leads.dart' as leadModel;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:getninjas_mobile_teste/services/entrypoints.dart';

class ApiLeads {
  static getList() async {
    final entryPointsResponse = await ApiEntryPoints.get();

    if (entryPointsResponse.statusCode == 200) {
      final entryPointModel.EntryPoint entryPoints =
      entryPointModel.EntryPoint.convertFromJson(json.decode(entryPointsResponse.body));
      final leadsResponse = await http.get(entryPoints.links.leads.href);

      if (leadsResponse.statusCode == 200) {

        final leadModel.Leads leads = leadModel.Leads.convertFromJson(json.decode(leadsResponse.body));

        print(leads.leads);

      } else {
        // Error in retrieving offers

      }
    } else {
      // Error in retrieving entryPoints

    }
  }
}
