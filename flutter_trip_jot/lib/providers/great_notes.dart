import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/note.dart';
import '../helpers/dbhelper.dart';
import '../helpers/location_helper.dart';

class GreatNotes with ChangeNotifier {
  List<Note> _items = [];

  List<Note> get items {
    return [..._items];
  }

  Note findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  Future<void> addNote(
    String pickedTitle,
    String pickedDescription,
    File pickedImage,
    PlaceLocation pickedLocation,
  ) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);
    final updateLocation = PlaceLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address: address);
    final newNote = Note(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      description: pickedDescription,
      location: updateLocation,
    );
    _items.add(newNote);
    notifyListeners();
    DBHelper.insert('user_notes', {
      'id': newNote.id,
      'title': newNote.title,
      'description': newNote.description,
      'image': newNote.image.path,
      'loc_lat': newNote.location.latitude,
      'loc_lng': newNote.location.longitude,
      'address': newNote.location.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_notes');
    _items = dataList
        .map(
          (item) => Note(
            id: item['id'],
            title: item['title'],
            description: item['description'],
            image: File(item['image']),
            location: PlaceLocation(
              latitude: item['loc_lat'],
              longitude: item['loc_lng'],
              address: item['address'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
