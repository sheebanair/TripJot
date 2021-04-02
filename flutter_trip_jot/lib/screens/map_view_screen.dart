import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_notes.dart';
import './map.dart';

class MapViewScreen extends StatelessWidget {
  static const routeName = '/map-view';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace =
        Provider.of<GreatNotes>(context, listen: false).findById(id);
    return Scaffold(
        appBar: AppBar(
          title: Text(selectedPlace.title),
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 250,
              width: double.infinity,
              child: Image.file(
                selectedPlace.image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              selectedPlace.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              selectedPlace.location.address,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (ctx) => MapScreen(
                      initialLocation: selectedPlace.location,
                      isSelecting: false,
                    ),
                  ),
                );
              },
              child: Text('View on Map'),
              style:
                  TextButton.styleFrom(primary: Theme.of(context).primaryColor),
            ),
          ],
        ));
  }
}
