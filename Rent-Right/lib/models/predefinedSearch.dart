import 'Range.dart';

enum BuildingType {
  house,
  apartment,
  other,
}

class PredefinedSearch {
  String? _name;
  String _region;
  BuildingType _type;
  Range _size;
  Range _nBedrooms;
  Range _nBathrooms;
  Map<String, bool> permissions = {};
  Map<String, bool> accommodations = {};

  PredefinedSearch({
    String? name,
    required String region,
    required BuildingType type,
    required Range size,
    required Range nBedrooms,
    required Range nBathrooms,
    bool? allowCats,
    bool? allowDogs,
    bool? allowSmoking,
    bool? hasWheelchairAccess,
    bool? hasElectricVehicleCharge,
    bool? comesFurnished,
  })  : _name = name,
        _region = region,
        _type = type,
        _size = size,
        _nBedrooms = nBedrooms,
        _nBathrooms = nBathrooms {
    permissions['cats'] = allowCats ?? false;
    permissions['dogs'] = allowDogs ?? false;
    permissions['smoking'] = allowSmoking ?? false;
    accommodations['wheelchair-access'] = hasWheelchairAccess ?? false;
    accommodations['electric-vehicle-charge'] =
        hasElectricVehicleCharge ?? false;
    accommodations['comes-furnished'] = comesFurnished ?? false;
  }

  String? get name => _name;
  set name(String? value) {
    _name = value;
  }

  String get region => _region;
  set region(String value) {
    _region = value;
  }

  BuildingType get type => _type;
  set type(BuildingType value) {
    _type = value;
  }

  Range get size => _size;
  set size(Range value) {
    _size = value;
  }

  Range get nBedrooms => _nBedrooms;
  set nBedrooms(Range value) {
    _nBedrooms = value;
  }

  Range get nBathrooms => _nBathrooms;
  set nBathrooms(Range value) {
    _nBathrooms = value;
  }

  Map<String, bool> getPermissions() {
    return permissions;
  }

  void setPermission(String key, bool value) {
    if (permissions.containsKey(key)) {
      permissions[key] = value;
    }
  }

  Map<String, bool> getAccommodations() {
    return accommodations;
  }

  void setAccommodation(String key, bool value) {
    if (accommodations.containsKey(key)) {
      accommodations[key] = value;
    }
  }
}
