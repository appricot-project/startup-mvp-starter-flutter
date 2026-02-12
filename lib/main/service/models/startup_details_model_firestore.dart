
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:startup_mvp_starter_flutter/main/main_details/models/startup_details_model.dart';

extension StartupDetailsModelFirestore on StartupDetailsModel {
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  static StartupDetailsModel fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return StartupDetailsModel(
      id: doc.id,
      name: data['name'],
      description: data['description'],
      imageUrl: data['imageUrl'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}
