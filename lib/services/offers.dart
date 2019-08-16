import 'package:getninjas_mobile_teste/models/EntryPoint.dart' as entryPointModel;
import 'package:getninjas_mobile_teste/models/Offers.dart' as offerModel;
import 'package:getninjas_mobile_teste/models/Offers.dart';
import 'package:getninjas_mobile_teste/models/Offer.dart' as OfferSingleModel;
import 'package:getninjas_mobile_teste/services/entrypoints.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiOffers {
  static Future<List<Offer>> getList() async {
    final entryPointsResponse = await ApiEntryPoints.get();

    if (entryPointsResponse.statusCode == 200) {
      final entryPointModel.EntryPoint entryPoints = entryPointModel.EntryPoint.convertFromJson(json.decode(entryPointsResponse.body));
      final offersResponse = await http.get(entryPoints.links.offers.href);

      if (offersResponse.statusCode == 200) {

        var responseJson = json.decode(utf8.decode(offersResponse.bodyBytes));

        final offerModel.Offers offers = offerModel.Offers.convertFromJson(responseJson);

        return offers.offers;

      } else {
        // Error in retrieving offers
        return null;
      }
    } else {
      // Error in retrieving entryPoints
      return null;
    }
  }

  static Future<OfferSingleModel.Offer> getOffer(url) async{
    final offerResponse = await http.get(url,headers: {'Content-Type': 'application/json'});

    if (offerResponse.statusCode == 200) {

      var responseJson = json.decode(utf8.decode(offerResponse.bodyBytes));

      final OfferSingleModel.Offer offer = OfferSingleModel.Offer.convertFromJson(responseJson);

      return offer;

    } else {
      // Error in retrieving offers
      return null;
    }
  }
}
