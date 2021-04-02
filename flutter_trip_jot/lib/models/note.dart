import 'dart:io';

import 'package:flutter/foundation.dart';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  const PlaceLocation(
      {@required this.latitude, @required this.longitude, this.address});
}

class Note {
  final String id;
  final String title;
  final PlaceLocation location;
  final File image;
  final String description;

  Note({
    this.id,
    this.title,
    this.location,
    this.image,
    this.description,
  });
}
