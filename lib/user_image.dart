import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'dart:typed_data';

import 'flutterfire.dart';

class UserImage extends StatefulWidget {
  final Function(String imageUrl) onFileChanged;
  bool? s;
  UserImage({required this.onFileChanged, required this.s});

  @override
  _UserImageState createState() => _UserImageState(s);
}

class _UserImageState extends State<UserImage> {
  bool? s;

  final ImagePicker _picker = ImagePicker();
  _UserImageState(this.s);

  String? imageUrl = FirebaseAuth.instance.currentUser!.photoURL;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => _selectPhoto(),
        child: Column(
          children: [
            if (imageUrl == null)
              Icon(Icons.account_circle, size: 80, color: Colors.grey.shade600),
            if (imageUrl != null)
              ClipRRect(
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () => _selectPhoto(),
                  child: Image(
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      image: NetworkImage(imageUrl!)),
                ),
                borderRadius: BorderRadius.circular(200),
              ),
            InkWell(
              onTap: () => _selectPhoto(),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  imageUrl != null ? 'Change photo' : 'Select photo',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ));
  }

  Future _selectPhoto() async {
    await showModalBottomSheet(
        context: context,
        builder: (context) => BottomSheet(
              builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                      leading: Icon(Icons.camera),
                      title: Text('Camera'),
                      onTap: () {
                        Navigator.of(context).pop();
                        _pickImage(ImageSource.camera);
                      }),
                  ListTile(
                      leading: Icon(Icons.filter),
                      title: Text('Pick a file'),
                      onTap: () {
                        Navigator.of(context).pop();
                        _pickImage(ImageSource.gallery);
                      }),
                ],
              ),
              onClosing: () {},
            ));
  }

  Future _pickImage(ImageSource source) async {
    final pickedFile =
        await _picker.pickImage(source: source, imageQuality: 50);
    if (pickedFile == null) {
      return;
    }

    var file = await compressImagePath(pickedFile.path, 35);

    await _uploadFile(file.path);
  }

  Future<File> compressImagePath(String path, int quality) async {
    final newPath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now()}.${p.extension(path)}');

    final result = await FlutterImageCompress.compressAndGetFile(
      path,
      newPath,
      quality: quality,
    );

    return result!;
  }

  Future _uploadFile(String path) async {
    final ref = storage.FirebaseStorage.instance
        .ref()
        .child('images')
        .child('${DateTime.now().toIso8601String() + p.basename(path)}');

    final result = await ref.putFile(File(path));
    final fileUrl = await result.ref.getDownloadURL();

    setState(() {
      imageUrl = fileUrl;
    });
    s == true
        ? {
            FirebaseAuth.instance.currentUser!.updatePhotoURL(imageUrl),
            photo(imageUrl!)
          }
        : null;

    widget.onFileChanged(fileUrl);
  }
}

class UserImage1 extends StatefulWidget {
  final Function(String imageUrl) onFileChanged;
  bool? s;
  UserImage1({required this.onFileChanged, required this.s});

  @override
  _UserImage1State createState() => _UserImage1State(s);
}

class _UserImage1State extends State<UserImage1> {
  bool? s;

  final ImagePicker _picker = ImagePicker();
  _UserImage1State(this.s);

  String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => _selectPhoto(),
        child: Column(
          children: [
            if (imageUrl != null)
              ClipRRect(
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () => _selectPhoto(),
                  child: Image(
                      width: MediaQuery.of(context).size.width - 100,
                      height: MediaQuery.of(context).size.width - 100,
                      fit: BoxFit.fitWidth,
                      image: NetworkImage(imageUrl!)),
                ),
                // borderRadius: BorderRadius.circular(200),
              ),
            InkWell(
              onTap: () => _selectPhoto(),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  imageUrl != null ? 'Change photo' : 'Select photo',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ));
  }

  Future _selectPhoto() async {
    await showModalBottomSheet(
        context: context,
        builder: (context) => BottomSheet(
              builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                      leading: Icon(Icons.camera),
                      title: Text('Camera'),
                      onTap: () {
                        Navigator.of(context).pop();
                        _pickImage(ImageSource.camera);
                      }),
                  ListTile(
                      leading: Icon(Icons.filter),
                      title: Text('Pick a file'),
                      onTap: () {
                        Navigator.of(context).pop();
                        _pickImage(ImageSource.gallery);
                      }),
                ],
              ),
              onClosing: () {},
            ));
  }

  Future _pickImage(ImageSource source) async {
    final pickedFile =
        await _picker.pickImage(source: source, imageQuality: 50);
    if (pickedFile == null) {
      return;
    }

    var file = await compressImagePath(pickedFile.path, 35);

    await _uploadFile(file.path);
  }

  Future<File> compressImagePath(String path, int quality) async {
    final newPath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now()}.${p.extension(path)}');

    final result = await FlutterImageCompress.compressAndGetFile(
      path,
      newPath,
      quality: quality,
    );

    return result!;
  }

  Future _uploadFile(String path) async {
    final ref = storage.FirebaseStorage.instance
        .ref()
        .child('images')
        .child('${DateTime.now().toIso8601String() + p.basename(path)}');

    final result = await ref.putFile(File(path));
    final fileUrl = await result.ref.getDownloadURL();

    setState(() {
      imageUrl = fileUrl;
    });
    s == true
        ? {
            FirebaseAuth.instance.currentUser!.updatePhotoURL(imageUrl),
            photo(imageUrl!)
          }
        : null;

    widget.onFileChanged(fileUrl);
  }
}

class AppRoundImage extends StatelessWidget {
  final ImageProvider provider;
  final double height;
  final double width;
  final bool selected;
  AppRoundImage(
    this.provider, {
    required this.height,
    required this.width,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: Image(
        image: provider,
        height: height,
        width: width,
      ),
    );
  }

  factory AppRoundImage.url(String url,
      {required double height, required double width, required bool selected}) {
    return AppRoundImage(
      NetworkImage(url),
      height: height,
      width: width,
      selected: selected,
    );
  }

  factory AppRoundImage.memory(Uint8List data,
      {required double height, required double width, required bool selected}) {
    return AppRoundImage(
      MemoryImage(data),
      height: height,
      width: width,
      selected: selected,
    );
  }
}
