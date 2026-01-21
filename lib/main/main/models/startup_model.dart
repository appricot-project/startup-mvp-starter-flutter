import 'package:startup_mvp_starter_flutter/main/service/models/startup_dto.dart';

class StartupModel {
  final String id;
  final String name;
  final String description;
  final String? imageUrl;
  final DateTime createdAt;

  StartupModel({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl,
    required this.createdAt,
  });

  factory StartupModel.fromDto(StartupDto dto) {
    return StartupModel(
      id: dto.id,
      name: dto.name,
      description: dto.description,
      imageUrl: dto.imageUrl,
      createdAt: dto.createdAt,
    );
  }
}
