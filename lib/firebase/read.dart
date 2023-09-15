// read
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> readData() async {
  final db = FirebaseFirestore.instance;
  await db.collection('todus').get().then((value) {
    for (var doc in value.docs) {
      log("${doc.id} => ${doc.data()}");
    }
  });
}
