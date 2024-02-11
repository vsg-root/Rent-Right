import 'buildingType.dart';
import 'state.dart';

class Building {
  String _region;
  BuildingType _type;
  int _size;
  int _nBedrooms;
  int _price;
  double _nBathrooms;
  Map<String, bool> permissions = {};
  Map<String, bool> accommodations = {};
  USState _state;

  Building({
    required String region,
    required BuildingType type,
    required int size,
    required int nBedrooms,
    required int price,
    required double nBathrooms,
    required USState state,
    bool? allowCats,
    bool? allowDogs,
    bool? allowSmoking,
    bool? hasWheelchairAccess,
    bool? hasElectricVehicleCharge,
    bool? comesFurnished,
  })  : _state = state,
        _price = price,
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

  USState get state => _state;
  set state(USState value) {
    _state = value;
  }

  int get price => _price;
  set price(int value) {
    _price = value;
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

  double get nBathrooms => _nBathrooms;
  set nBathrooms(double value) {
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
