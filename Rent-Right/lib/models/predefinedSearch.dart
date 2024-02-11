import 'buildingType.dart';

class PredefinedSearch {
  String? _name;
  String _region;
  BuildingType _type;
  int _size;
  int _nBedrooms;
  int _nBathrooms;
  Map<String, bool> permissions = {};
  Map<String, bool> accommodations = {};

  PredefinedSearch({
    String? name,
    required String region,
    required BuildingType type,
    required int size,
    required int nBedrooms,
    required int nBathrooms,
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

  int get size => _size;
  set size(int value) {
    _size = value;
  }

  int get nBedrooms => _nBedrooms;
  set nBedrooms(int value) {
    _nBedrooms = value;
  }

  int get nBathrooms => _nBathrooms;
  set nBathrooms(int value) {
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
