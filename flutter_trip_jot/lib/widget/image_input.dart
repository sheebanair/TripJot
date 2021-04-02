import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;
  File _storedImage1;
  File _storedImage2;
  File _storedImage3;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );

    if (imageFile == null) {
      return;
    }

    setState(() {
      _storedImage = File(imageFile.path);
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _storedImage.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
            ),
            child: _storedImage != null
                ? Image.file(
                    _storedImage,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : Expanded(
                    child: TextButton.icon(
                      icon: Icon(Icons.add_a_photo_outlined),
                      label: Text(''),
                      onPressed: _takePicture,
                      style: TextButton.styleFrom(
                        primary: Theme.of(context).accentColor,
                      ),
                    ),
                  )),
        SizedBox(
          width: 10,
        ),
        Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
            ),
            child: _storedImage1 != null
                ? Image.file(
                    _storedImage1,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : Expanded(
                    child: TextButton.icon(
                      icon: Icon(Icons.add_a_photo_outlined),
                      label: Text(''),
                      onPressed: _takePicture,
                      style: TextButton.styleFrom(
                        primary: Theme.of(context).accentColor,
                      ),
                    ),
                  )),
        SizedBox(
          width: 10,
        ),
        Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
            ),
            child: _storedImage2 != null
                ? Image.file(
                    _storedImage2,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : Expanded(
                    child: TextButton.icon(
                      icon: Icon(Icons.add_a_photo_outlined),
                      label: Text(''),
                      onPressed: _takePicture,
                      style: TextButton.styleFrom(
                        primary: Theme.of(context).accentColor,
                      ),
                    ),
                  )),
        SizedBox(
          width: 10,
        ),
        Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
            ),
            child: _storedImage3 != null
                ? Image.file(
                    _storedImage3,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : Expanded(
                    child: TextButton.icon(
                      icon: Icon(Icons.add_a_photo_outlined),
                      label: Text(''),
                      onPressed: _takePicture,
                      style: TextButton.styleFrom(
                        primary: Theme.of(context).accentColor,
                      ),
                    ),
                  )),
      ],
    );
  }
}
