class AddressModel {
  late int? _id;
  late String? _adressType;
  late String _contactPersonName;
  late String _contactPersonNumber;

  late String _address;
  late String _latitude;
  late String _longitude;

  AddressModel(
      {id,
      required addressType,
      contactPersonName,
      contactPersonNumber,
      adress,
      latitude,
      longitude}) {
    _id = id;
    _adressType = addressType;
    _contactPersonName = contactPersonName;
    _contactPersonNumber = contactPersonNumber;
    _address = adress;
    _latitude = latitude;
    _longitude = longitude;
  }

  int? get id => _id;
  String? get addressType => _adressType;
  String get address => _address;
  String get latitude => _latitude;
  String get longitude => _longitude;

  String get conactPersonName => _contactPersonName;

  String get contactPersonNumber => _contactPersonNumber;

  AddressModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _adressType = json['address_type'] ?? "";
    _contactPersonName = json['contact_person_name'] ?? "";
    _contactPersonNumber = json['contact_person_number'] ?? "";
    _address = json['address'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
  }
  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['address_type'] = addressType;
    data['contact_person_name'] = conactPersonName;
    data['contact_person_number'] = contactPersonNumber;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['address'] = _address;

    return data;
  }
}
