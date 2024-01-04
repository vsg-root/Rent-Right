import 'Range.dart';

enum BuildingType { house, apartment, other }

class PredefinedSearch {
  String _name;
  String _region;
  BuildingType _type;
  Range _size;
  Range _nBedrooms;
  Range _nBathrooms;
  bool _allowCats;
  bool _allowDogs;
  bool _allowSmoking;
  bool _hasWheelchairAccess;
  bool _hasElectricVehicleCharge;
  bool _comesFurnished;

  PredefinedSearch({
    required String name,
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
        _nBathrooms = nBathrooms,
        _allowCats = allowCats ?? true,
        _allowDogs = allowDogs ?? true,
        _allowSmoking = allowSmoking ?? true,
        _hasWheelchairAccess = hasWheelchairAccess ?? true,
        _hasElectricVehicleCharge = hasElectricVehicleCharge ?? true,
        _comesFurnished = comesFurnished ?? true;

  String get name => _name;
  set name(String value) {
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

  bool get allowCats => _allowCats;
  set allowCats(bool value) {
    _allowCats = value;
  }

  bool get allowDogs => _allowDogs;
  set allowDogs(bool value) {
    _allowDogs = value;
  }

  bool get allowSmoking => _allowSmoking;
  set allowSmoking(bool value) {
    _allowSmoking = value;
  }

  bool get hasWheelchairAccess => _hasWheelchairAccess;
  set hasWheelchairAccess(bool value) {
    _hasWheelchairAccess = value;
  }

  bool get hasElectricVehicleCharge => _hasElectricVehicleCharge;
  set hasElectricVehicleCharge(bool value) {
    _hasElectricVehicleCharge = value;
  }

  bool get comesFurnished => _comesFurnished;
  set comesFurnished(bool value) {
    _comesFurnished = value;
  }
}
