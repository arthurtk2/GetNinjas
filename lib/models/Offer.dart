class Offer {
  final int distance;
  final int leadPrice;
  final String title;
  final OfferEmbedded offerEmbedded;

  // Faltou o self link???

  Offer({this.distance, this.leadPrice, this.title, this.offerEmbedded});

  factory Offer.convertFromJson(Map<String, dynamic> map){

    double distance =  map['distance'] / 10000;

    return new Offer(
        distance: distance.toInt(),
        leadPrice: map['lead_price'],
        title: map['title'],
        offerEmbedded: OfferEmbedded.convertFromJson(map['_embedded'])
    );
  }
}

class OfferEmbedded {
  final List<Info> info;
  final User user;
  final Address address;

  OfferEmbedded.convertFromJson(Map<String, dynamic> map)
      : info = parseInfos(map['info']),
        address = Address.convertFromJson(map['address']),
        user = User.convertFromJson(map['user']);

  static List<Info> parseInfos(json) {
    var list = json as List;

    List<Info> infoList =
    list.map((data) => Info.convertFromJson(data)).toList();

    return infoList;
  }
}

class Info {
  final String label;
  final List<String> value;

  Info({this.label, this.value});

  factory Info.convertFromJson(Map<String, dynamic> map) {
    List<String> valueArray = [];
    var valuesFromJson = map['value'];

    if (valuesFromJson is String) {
      valueArray.add(valuesFromJson);
    } else if (valueArray is List) {
      for (var item in valuesFromJson) {
        valueArray.add(item);
      }
    }

    return new Info(
      label: map['label'],
      value: valueArray,
    );
  }
}

class User {
  final String name;
  final String email;
  final UserEmbedded userEmbedded;

  User.convertFromJson(Map<String, dynamic> map)
      : name = map['name'],
        email = map['email'],
        userEmbedded = UserEmbedded.convertFromJson(map['_embedded']);
}

class UserEmbedded {
  final List<Number> phones;

  UserEmbedded.convertFromJson(Map<String, dynamic> map)
      : phones = parsePhones(map['phones']);

  static List<Number> parsePhones(phonesJson) {
    var list = phonesJson as List;

    List<Number> numberList =
    list.map((data) => Number.convertFromJson(data)).toList();

    return numberList;
  }
}

class Number {
  final String number;

  Number({this.number});

  factory Number.convertFromJson(Map<String, dynamic> map){

    return new Number(
        number :  map['number']
    );
  }
}

class Address {
  final String city;
  final String neighborhood;
  final String uf;
  final AddressGeolocation addressGeolocation;

  Address.convertFromJson(Map<String, dynamic> map)
      : city = map['city'],
        neighborhood = map['neighborhood'],
        uf = map['uf'],
        addressGeolocation =
        AddressGeolocation.convertFromJson(map['geolocation']);
}

class AddressGeolocation {
  final double latitude;
  final double longitude;

  AddressGeolocation.convertFromJson(Map<String, dynamic> map)
      : longitude = map['longitude'],
        latitude = map['latitude'];
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
