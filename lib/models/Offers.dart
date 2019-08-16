import 'package:getninjas_mobile_teste/utils/date.dart';

class Offers {
  final List<Offer> offers;
  final Links links;

  Offers(this.offers, this.links);

  Offers.convertFromJson(Map<String, dynamic> map)
      : offers = parseOffers(map['offers']),
        links = Links.convertFromJson(map['_links']);

  static List<Offer> parseOffers(offersJson) {
    var list = offersJson as List;

    List<Offer> offersList =
        list.map((data) => Offer.convertFromJson(data)).toList();

    return offersList;
  }
}

class Offer {
  final String state;
  final OfferEmbedded offerEmbedded;
  final Links links;

  Offer.convertFromJson(Map<String, dynamic> map)
      : state = map['state'],
        offerEmbedded = OfferEmbedded.convertFromJson(map['_embedded']),
        links = Links.convertFromJson(map['_links']);
}

class OfferEmbedded {
  final Request request;

  OfferEmbedded.convertFromJson(Map<String, dynamic> map)
      : request = Request.convertFromJson(map['request']);
}

class Request {
  final String createdAt;
  final String title;
  final RequestEmbedded requestEmbedded;

  Request({this.createdAt, this.title, this.requestEmbedded});

  factory Request.convertFromJson(Map<String, dynamic> map) {
    return new Request(
      createdAt: convertToBr(map['created_at']),
      title: map['title'],
      requestEmbedded: RequestEmbedded.convertFromJson(map['_embedded']),
    );
  }
}

class RequestEmbedded {
  final RequestUser requestUser;
  final RequestAddress requestAddress;

  RequestEmbedded(this.requestUser, this.requestAddress);

  RequestEmbedded.convertFromJson(Map<String, dynamic> map)
      : requestUser = RequestUser.convertFromJson(map['user']),
        requestAddress = RequestAddress.convertFromJson(map['address']);
}

class RequestUser {
  final String name;

  RequestUser(this.name);

  RequestUser.convertFromJson(Map<String, dynamic> map) : name = map['name'];
}

class RequestAddress {
  final String city;
  final String neighborhood;
  final String uf;

  RequestAddress(this.city, this.neighborhood, this.uf);

  RequestAddress.convertFromJson(Map<String, dynamic> map)
      : city = map['city'],
        neighborhood = map['neighborhood'],
        uf = map['uf'];
}

class Links {
  final Self self;

  Links(this.self);

  Links.convertFromJson(Map<String, dynamic> map)
      : self = Self.convertFromJson(map['self']);
}

class Self {
  final String href;

  Self(this.href);

  Self.convertFromJson(Map<String, dynamic> map) : href = map['href'];
}
