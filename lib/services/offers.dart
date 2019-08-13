import 'package:getninjas_mobile_teste/models/EntryPoint.dart' as entryPointModel;
import 'package:getninjas_mobile_teste/models/Offers.dart' as offerModel;
import 'package:getninjas_mobile_teste/services/entrypoints.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiOffers {
  static getList() async {
    final entryPointsResponse = await ApiEntryPoints.get();

    if (entryPointsResponse.statusCode == 200) {
      final entryPointModel.EntryPoint entryPoints =
      entryPointModel.EntryPoint.convertFromJson(json.decode(entryPointsResponse.body));
      final offersResponse = await http.get(entryPoints.links.offers.href);

      if (offersResponse.statusCode == 200) {

        final offerModel.Offers offers = offerModel.Offers.convertFromJson(json.decode(offersResponse.body));

        print(offers.offers);

      } else {
        // Error in retrieving offers

      }
    } else {
      // Error in retrieving entryPoints

    }
  }
}
