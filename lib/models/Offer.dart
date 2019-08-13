class Order {
  final String distance;
  final String leadPrice;
  final String title;
  final OrderEmbedded orderEmbedded;

  // Faltou o self link???

  Order.convertFromJson(Map<String, dynamic> map)
      : distance = map['distance'],
        leadPrice = map['lead_price'],
        title = map['title'],
        orderEmbedded = OrderEmbedded.convertFromJson(map['_embedded']);
}

class OrderEmbedded {
  final Info info;
  final User user;
  final Address address;

  OrderEmbedded.convertFromJson(Map<String, dynamic> map)
      : info = Info.convertFromJson(map['info']),
        user = User.convertFromJson(map['user']),
        address = Address.convertFromJson(map['address']);
}

class Info {
  final String label;
  final String value;

  Info.convertFromJson(Map<String, dynamic> map)
      : label = map['label'],
        value = map['value'];
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
  final UserEmbeddedFones userEmbeddedFones;

  UserEmbedded.convertFromJson(Map<String, dynamic> map)
      : userEmbeddedFones = UserEmbeddedFones.convertFromJson(map['_embedded']);
}

class UserEmbeddedFones {
  final List<Phone> phones;

  UserEmbeddedFones.convertFromJson(Map<String, dynamic> map)
      : phones = parsePhones(map['phones']);

  static List<Phone> parsePhones(phonesJson) {
    var list = phonesJson as List;

    List<Phone> phonesList =
    list.map((data) => Phone.convertFromJson(data)).toList();

    return phonesList;
  }
}

class Phone {
  final String number;

  Phone.convertFromJson(Map<String, dynamic> map) : number = map['number'];
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
  final String latitude;
  final String longitude;

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
