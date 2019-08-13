class EntryPoint {
  final Links links;

  EntryPoint(this.links);

  EntryPoint.convertFromJson(Map<String, dynamic> map)
      : links = Links.convertFromJson(map['_links']);
}

class Links {
  final Leads leads;
  final Offers offers;

  Links(this.leads, this.offers);

  Links.convertFromJson(Map<String, dynamic> map)
      : leads = Leads.convertFromJson(map['leads']),
        offers = Offers.convertFromJson(map['offers']);
}

class Leads {
  final String href;

  Leads(this.href);

  Leads.convertFromJson(Map<String, dynamic> map) : href = map['href'];
}

class Offers {
  final String href;

  Offers(this.href);

  Offers.convertFromJson(Map<String, dynamic> map) : href = map['href'];
}
