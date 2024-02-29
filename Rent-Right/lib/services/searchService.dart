import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_interface/models/predefinedSearch.dart';
import 'package:login_interface/models/buildingType.dart';

class SearchService {
  final CollectionReference _searchesCollection =
      FirebaseFirestore.instance.collection('searches');

  Future<String> addSearch(PredefinedSearch search) async {
    try {
      DocumentReference newSearchRef = await _searchesCollection.add({
        'accommodations': search.accommodations,
        'name': search.name,
        'num-of-bathrooms': search.nBathrooms,
        'num-of-bedrooms': search.nBedrooms,
        'permissions': search.permissions,
        'region': search.region,
        'size': search.size,
        'type': search.type.name
      });
      return newSearchRef.id;
    } catch (e) {
      print('Error adding search: $e');
      return '';
    }
  }

  Future<PredefinedSearch?> getSearch(String searchId) async {
    try {
      DocumentSnapshot searchSnapshot =
          await _searchesCollection.doc(searchId).get();

      if (searchSnapshot.exists) {
        return PredefinedSearch(
          name: searchSnapshot['name'],
          region: searchSnapshot['region'],
          type: BuildingType.values.byName(searchSnapshot['type']),
          size: searchSnapshot['size'],
          nBedrooms: searchSnapshot['num-of-bedrooms'],
          nBathrooms: searchSnapshot['num-of-bathrooms'],
          allowCats: searchSnapshot['permissions']['cats'],
          allowDogs: searchSnapshot['permissions']['dogs'],
          allowSmoking: searchSnapshot['permissions']['smoking'],
          hasElectricVehicleCharge: searchSnapshot['accommodations']
              ['electric-vehicle-charge'],
          hasWheelchairAccess: searchSnapshot['accommodations']
              ['wheelchair-access'],
          comesFurnished: searchSnapshot['accommodations']['comes-furnished'],
        );
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting search: $e');
      return null;
    }
  }

  Future<void> updateSearch(
      String searchId, PredefinedSearch updatedSearch) async {
    try {
      await _searchesCollection.doc(searchId).update({
        'accommodations': updatedSearch.accommodations,
        'name': updatedSearch.name,
        'num-of-bathrooms': updatedSearch.nBathrooms,
        'num-of-bedrooms': updatedSearch.nBedrooms,
        'permissions': updatedSearch.permissions,
        'region': updatedSearch.region,
        'size': updatedSearch.size,
        'type': updatedSearch.type.name
      });
    } catch (e) {
      print('Error updating search: $e');
    }
  }

  Future<void> deleteSearch(String searchId) async {
    try {
      await _searchesCollection.doc(searchId).delete();
    } catch (e) {
      print('Error deleting search: $e');
    }
  }
}
