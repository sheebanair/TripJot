import 'package:flutter/material.dart';
import 'package:flutter_trip_jot/screens/map_view_screen.dart';
import 'package:provider/provider.dart';
import './new_note.dart';
import '../providers/great_notes.dart';

class NotesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Notes'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddNotes.routeName);
              },
            )
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<GreatNotes>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<GreatNotes>(
                  child: Center(child: Text('No new notes yet, add some!')),
                  builder: (context, greatNotes, child) => greatNotes
                              .items.length <=
                          0
                      ? child
                      : ListView.builder(
                          padding: EdgeInsets.only(top: 30),
                          itemCount: greatNotes.items.length,
                          itemBuilder: (context, i) {
                            // final folder = greatNotes.items[i];
                            return Dismissible(
                              onDismissed: (direction) {
                                greatNotes.items.removeAt(
                                    i); // to avoid weird future builder issue with dismissible
                                // Provider.of<GreatNotes>(context, listen: false)
                                //     .(folder.id);
                              },
                              background: Card(
                                margin: EdgeInsets.symmetric(vertical: 8),
                                elevation: 1,
                                child: Container(
                                  alignment: AlignmentDirectional.centerStart,
                                  color: Colors.red,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        15.0, 0.0, 0.0, 0.0),
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              key: UniqueKey(),
                              direction: DismissDirection.endToStart,
                              child: Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: FileImage(greatNotes
                                        .items[greatNotes.items.length - i - 1]
                                        .image),
                                  ),
                                  title: Text(greatNotes
                                      .items[greatNotes.items.length - i - 1]
                                      .title),
                                  subtitle: Text(greatNotes
                                      .items[greatNotes.items.length - i - 1]
                                      .location
                                      .address),
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      MapViewScreen.routeName,
                                      arguments: greatNotes
                                          .items[
                                              greatNotes.items.length - i - 1]
                                          .id,
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                ),
        ));
  }
}
