import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:startup_mvp_starter_flutter/main/main/models/startup_model.dart';

extension StartupModelFirestore on StartupModel {
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  static StartupModel fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return StartupModel(
      id: doc.id,
      name: data['name'],
      description: data['description'],
      imageUrl: data['imageUrl'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}
