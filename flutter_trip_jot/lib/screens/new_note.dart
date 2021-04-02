import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_trip_jot/models/note.dart';
import 'package:provider/provider.dart';
import '../widget/image_input.dart';
import '../providers/great_notes.dart';
import '../widget/location_input.dart';
import '../models/note.dart';

class AddNotes extends StatefulWidget {
  static const routeName = '/add-note';
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNotes> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  File _pickedImage;
  PlaceLocation _pickedLocation;
  String selectedDate;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double lng) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  void _saveNote() {
    if (_titleController.text.isEmpty || _pickedLocation == null) {
      return;
    }
    Provider.of<GreatNotes>(context, listen: false).addNote(
      _titleController.text,
      _descriptionController.text,
      _pickedImage,
      _pickedLocation,
    );
    Navigator.of(context).pop();
  }

  Future<void> _selectDate() async {
    DateTime date1 = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime(2030),
    );
    setState(() {
      selectedDate = DateFormat("dd/MM/yyyy").format(date1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Add a New Note"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        labelText: 'Title',
                      ),
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      controller: _titleController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      minLines: 2,
                      maxLines: null,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Description'),
                      style: TextStyle(
                        fontSize: 18,
                        // height: 10,
                        color: Colors.black,
                      ),
                      controller: _descriptionController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton.icon(
                        onPressed: _selectDate,
                        icon: Icon(Icons.calendar_today),
                        label: selectedDate != null
                            ? Text(selectedDate)
                            : Text('Pick a Date'),
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            onPrimary: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 150,
                    ),
                    LocationInput(_selectPlace),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _saveNote,
            icon: Icon(Icons.check),
            label: Text('Save Note'),
            style: ElevatedButton.styleFrom(
                elevation: 0,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                primary: Theme.of(context).primaryColor,
                onPrimary: Colors.white),
          ),
        ],
      ),
    );
  }
}
