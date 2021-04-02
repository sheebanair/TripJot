import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_notes.dart';
import './note_list.dart';
import './new_note.dart';
import './map_view_screen.dart';

class MainScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatNotes(),
      child: MaterialApp(
          title: 'Travel Memories',
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            accentColor: Colors.teal,
            backgroundColor: Colors.grey.shade400,
          ),
          home: NotesList(),
          routes: {
            AddNotes.routeName: (ctx) => AddNotes(),
            MapViewScreen.routeName: (ctx) => MapViewScreen(),
          }),
    );
  }
}
