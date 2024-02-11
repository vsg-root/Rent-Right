import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_interface/models/building.dart';
import 'package:login_interface/models/buildingType.dart';
import 'package:login_interface/models/state.dart';

class HousingService {
  final CollectionReference _housingCollection =
      FirebaseFirestore.instance.collection('housing');

  Future<String> addBuilding(Building building) async {
    try {
      DocumentReference newBuildinghRef = await _housingCollection.add({
        'region': building.region,
        'baths': building.nBathrooms,
        'beds': building.nBedrooms,
        'cats_allowed': building.getPermissions()['cats'] == true ? 1 : 0,
        'comes_furnished':
            building.getAccommodations()['comes-furnished'] == true ? 1 : 0,
        'dogs_allowed': building.getPermissions()['dogs'] == true ? 1 : 0,
        'electric_vehicle_charge':
            building.getAccommodations()['electric-vehicle-charge'] == true
                ? 1
                : 0,
        'price': building.price,
        'smoking_allowed': building.getPermissions()['smoking'] == true ? 1 : 0,
        'sqfeet': building.size,
        'state': building.state.name.toLowerCase(),
        'type': building.type.name,
        'wheelchair_access':
            building.getAccommodations()['wheelchair-access'] == true ? 1 : 0
      });
      return newBuildinghRef.id;
    } catch (e) {
      print('Error adding building: $e');
      return '';
    }
  }

  Future<List<Building>> getAllBuildings() async {
    try {
      QuerySnapshot querySnapshot = await _housingCollection.get();

      List<Building> buildings =
          querySnapshot.docs.map((DocumentSnapshot document) {
        return Building(
          type: BuildingType.values
                  .map((e) => e.name)
                  .toList()
                  .contains(document['type'])
              ? BuildingType.values.byName(document['type'])
              : BuildingType.other,
          region: document['region'],
          state: USState.values.byName(document['state'].toUpperCase()),
          price: document['price'],
          size: document['sqfeet'],
          nBedrooms: document['beds'],
          nBathrooms: document['baths'],
          allowCats: document['cats_allowed'] == 1,
          allowDogs: document['dogs_allowed'] == 1,
          allowSmoking: document['smoking_allowed'] == 1,
          hasElectricVehicleCharge: document['smoking_allowed'] == 1,
          hasWheelchairAccess: document['wheelchair_access'] == 1,
          comesFurnished: document['comes_furnished'] == 1,
        );
      }).toList();

      return buildings;
    } catch (e) {
      print('Error getting all buildings: $e');
      return [];
    }
  }

  Future<Building?> getBuilding(String buildingId) async {
    try {
      print(buildingId);
      DocumentSnapshot buildingSnapshot =
          await _housingCollection.doc(buildingId).get();
      print(buildingSnapshot.exists);
      if (buildingSnapshot.exists) {
        return Building(
          type: BuildingType.values
                  .map((e) => e.name)
                  .toList()
                  .contains(buildingSnapshot['type'])
              ? BuildingType.values.byName(buildingSnapshot['type'])
              : BuildingType.other,
          region: buildingSnapshot['region'],
          state: USState.values.byName(buildingSnapshot['state'].toUpperCase()),
          price: buildingSnapshot['price'],
          size: buildingSnapshot['sqfeet'],
          nBedrooms: buildingSnapshot['beds'],
          nBathrooms: buildingSnapshot['baths'],
          allowCats: buildingSnapshot['cats_allowed'] == 1,
          allowDogs: buildingSnapshot['dogs_allowed'] == 1,
          allowSmoking: buildingSnapshot['smoking_allowed'] == 1,
          hasElectricVehicleCharge: buildingSnapshot['smoking_allowed'] == 1,
          hasWheelchairAccess: buildingSnapshot['wheelchair_access'] == 1,
          comesFurnished: buildingSnapshot['comes_furnished'] == 1,
        );
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting search: $e');
      return null;
    }
  }

  Future<void> updateBuilding(String buildingId, Building building) async {
    try {
      await _housingCollection.doc(buildingId).update({
        'region': building.region,
        'baths': building.nBathrooms,
        'beds': building.nBedrooms,
        'cats_allowed': building.getPermissions()['cats'] == true ? 1 : 0,
        'comes_furnished':
            building.getAccommodations()['comes-furnished'] == true ? 1 : 0,
        'dogs_allowed': building.getPermissions()['dogs'] == true ? 1 : 0,
        'electric_vehicle_charge':
            building.getAccommodations()['electric-vehicle-charge'] == true
                ? 1
                : 0,
        'price': building.price,
        'smoking_allowed': building.getPermissions()['smoking'] == true ? 1 : 0,
        'sqfeet': building.size,
        'state': building.state.name.toLowerCase(),
        'type': building.type.name,
        'wheelchair_access':
            building.getAccommodations()['wheelchair-access'] == true ? 1 : 0
      });
    } catch (e) {
      print('Error updating search: $e');
    }
  }

  Future<void> deleteBuilding(String buildingId) async {
    try {
      await _housingCollection.doc(buildingId).delete();
    } catch (e) {
      print('Error deleting search: $e');
    }
  }
}
