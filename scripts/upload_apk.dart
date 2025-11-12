import 'dart:io';
import 'package:cart_pal/firebase_options.dart' show DefaultFirebaseOptions;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

// ignore: unused_import
import '../firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final storage = FirebaseStorage.instance;
  final ref = storage.ref().child('releases/app-release.apk');

  final file = File('build/app/outputs/flutter-apk/app-release.apk');

  try {
    print('Uploading APK to Firebase Storage...');
    await ref.putFile(file);
    final url = await ref.getDownloadURL();
    print('Upload complete!');
    print('Download URL: $url');
  } on FirebaseException catch (e) {
    print('Error uploading APK: $e');
  }
}
