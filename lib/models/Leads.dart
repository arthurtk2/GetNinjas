class Leads {
  final List<Lead> leads;
  final Links links;

  Leads(this.leads, this.links);

  Leads.convertFromJson(Map<String, dynamic> map)
      : leads = parseLeads(map['leads']),
        links = Links.convertFromJson(map['_links']);

  static List<Lead> parseLeads(leadsJson) {
    var list = leadsJson as List;

    List<Lead> leadsList =
        list.map((data) => Lead.convertFromJson(data)).toList();

    return leadsList;
  }
}

class Lead {
  final String createdAt;
  final LeadEmbedded leadEmbedded;
  final Links links;

  Lead.convertFromJson(Map<String, dynamic> map)
      : createdAt = map['created_at'],
        leadEmbedded = LeadEmbedded.convertFromJson(map['_embedded']),
        links = Links.convertFromJson(map['_links']);
}

class LeadEmbedded {
  final EmbeddedAddress embeddedAddress;
  final EmbeddedUser embeddedUser;
  final EmbeddedRequest embeddedRequest;

  LeadEmbedded.convertFromJson(Map<String, dynamic> map)
      : embeddedAddress = EmbeddedAddress.convertFromJson(map['address']),
        embeddedUser = EmbeddedUser.convertFromJson(map['user']),
        embeddedRequest = EmbeddedRequest.convertFromJson(map['request']);
}

class EmbeddedAddress {
  final String city;
  final String street;
  final String neighborhood;
  final String uf;

  EmbeddedAddress(this.city, this.street, this.neighborhood, this.uf);

  EmbeddedAddress.convertFromJson(Map<String, dynamic> map)
      : city = map['city'],
        street = map['street'],
        neighborhood = map['neighborhood'],
        uf = map['uf'];
}

class EmbeddedUser {
  final String name;
  final String email;

  EmbeddedUser(this.name, this.email);

  EmbeddedUser.convertFromJson(Map<String, dynamic> map)
      : name = map['name'],
        email = map['email'];
}

class EmbeddedRequest {
  final String title;

  EmbeddedRequest(this.title);

  EmbeddedRequest.convertFromJson(Map<String, dynamic> map)
      : title = map['title'];
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
