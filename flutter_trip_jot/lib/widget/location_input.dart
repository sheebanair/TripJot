import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../helpers/location_helper.dart';
import '../screens/map.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  LocationInput(this.onSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  void _showPreview(double lat, double lng) {
    final staticMapImageUrl = LocationHelper.generateLocationPreviewimage(
      latitude: lat,
      longitude: lng,
    );

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      final locationData = await Location().getLocation();
      _showPreview(locationData.latitude, locationData.longitude);
      widget.onSelectPlace(locationData.latitude, locationData.longitude);
    } catch (error) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );

    if (selectedLocation == null) {
      return;
    }
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 0.2),
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          height: 100,
          width: double.infinity,
          child: _previewImageUrl == null
              ? Text(
                  'Add Location',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade400),
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
              onPressed: _getCurrentLocation,
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              style:
                  TextButton.styleFrom(primary: Theme.of(context).accentColor),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              label: Text('Choose on Map'),
              style:
                  TextButton.styleFrom(primary: Theme.of(context).accentColor),
            ),
          ],
        ),
      ],
    );
  }
}
