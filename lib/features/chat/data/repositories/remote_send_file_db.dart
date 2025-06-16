import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class RemoteSendFileDb {

  final storage = FirebaseStorage.instance;

  Future<void> sedData(File file) async {
    try {
      final bytes = await file.readAsBytes();
      final base64Str = base64Encode(bytes);
      final temporary = await getTemporaryDirectory();
      final fileName = basename(file.path);
      final tempFile = File("${temporary.path}/$fileName");
      await tempFile.writeAsBytes(base64Decode(base64Str));
      final storageRef = storage.ref().child('applications/$fileName');
      await storageRef.putFile(tempFile);
    } catch (e) {
      print("Xato ${e.toString()}");
    }
  }

  Future<String?> getData(String fileName) async {
    try {
       final storageRef = storage.ref().child('applications/$fileName');
      final tempDir = await getTemporaryDirectory();
      final localFile = File('${tempDir.path}/$fileName');

      await storageRef.writeToFile(localFile);

      final bytes = await localFile.readAsBytes();
      final base64Str = base64Encode(bytes);
      return base64Str;
    } catch (e) {
      print("Xato ${e.toString()}");
    }                 
    return null;
  }
}