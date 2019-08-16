import 'package:getninjas_mobile_teste/models/EntryPoint.dart'
as entryPointModel;
import 'package:getninjas_mobile_teste/models/Leads.dart' as leadModel;
import 'package:getninjas_mobile_teste/models/Leads.dart';
import 'package:getninjas_mobile_teste/models/Lead.dart' as LeadSingleModel;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:getninjas_mobile_teste/services/entrypoints.dart';

class ApiLeads {
  static Future<List<Lead>> getList() async {
    final entryPointsResponse = await ApiEntryPoints.get();

    if (entryPointsResponse.statusCode == 200) {
      final entryPointModel.EntryPoint entryPoints =
      entryPointModel.EntryPoint.convertFromJson(
          json.decode(entryPointsResponse.body));
      final leadsResponse = await http.get(entryPoints.links.leads.href);

      if (leadsResponse.statusCode == 200) {

        var responseJson = json.decode(utf8.decode(leadsResponse.bodyBytes));

        final leadModel.Leads leads = leadModel.Leads.convertFromJson(responseJson);

        return leads.leads;
      } else {
        // Error in retrieving offers
        return null;
      }
    } else {
      // Error in retrieving entryPoints
      return null;
    }
  }

  static Future<LeadSingleModel.Lead> getLead(url) async{
    final leadResponse = await http.get(url);

    if (leadResponse.statusCode == 200) {

      var responseJson = json.decode(utf8.decode(leadResponse.bodyBytes));

      final LeadSingleModel.Lead lead = LeadSingleModel.Lead.convertFromJson(responseJson);

      return lead;

    } else {
      // Error in retrieving offers
      return null;
    }
  }
}
