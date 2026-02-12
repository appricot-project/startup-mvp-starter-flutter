import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:startup_mvp_starter_flutter/main/service/models/startup_dto.dart';

extension StartupDtoFirestore on StartupDto {
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
