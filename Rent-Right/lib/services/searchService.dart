import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_interface/models/predefinedSearch.dart';
import 'package:login_interface/models/Range.dart';

class SearchService {
  final CollectionReference _searchesCollection =
      FirebaseFirestore.instance.collection('searches');

  Future<String> addSearch(PredefinedSearch search) async {
    try {
      DocumentReference newSearchRef = await _searchesCollection.add({
        'accommodations': search.accommodations,
        'name': search.name,
        'num-of-bathrooms': {
          'max': search.nBathrooms.end,
          'min': search.nBathrooms.start
        },
        'num-of-bedrooms': {
          'max': search.nBedrooms.end,
          'min': search.nBedrooms.start
        },
        'permissions': search.permissions,
        'region': search.region,
        'size': {'max': search.size.end, 'min': search.size.start},
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
          size: Range(
            start: searchSnapshot['size']['min'],
            end: searchSnapshot['size']['max'],
          ),
          nBedrooms: Range(
            start: searchSnapshot['num-of-bedrooms']['min'],
            end: searchSnapshot['num-of-bedrooms']['max'],
          ),
          nBathrooms: Range(
            start: searchSnapshot['num-of-bathrooms']['min'],
            end: searchSnapshot['num-of-bathrooms']['max'],
          ),
          allowCats: searchSnapshot['permissions']['cats'],
          allowDogs: searchSnapshot['permissions']['dogs'],
          allowSmoking: searchSnapshot['permissions']['smoking'],
          hasElectricVehicleCharge: searchSnapshot['accommodations']
              ['electric-vehicle-charge'],
          hasWheelchairAccess: searchSnapshot['accommodations']
              ['comes-furnished'],
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
        'num-of-bathrooms': {
          'max': updatedSearch.nBathrooms.end,
          'min': updatedSearch.nBathrooms.start
        },
        'num-of-bedrooms': {
          'max': updatedSearch.nBedrooms.end,
          'min': updatedSearch.nBedrooms.start
        },
        'permissions': updatedSearch.permissions,
        'region': updatedSearch.region,
        'size': {
          'max': updatedSearch.size.end,
          'min': updatedSearch.size.start
        },
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
