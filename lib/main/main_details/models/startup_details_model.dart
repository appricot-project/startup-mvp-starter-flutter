import 'package:equatable/equatable.dart';
import 'package:startup_mvp_starter_flutter/main/service/models/startup_dto.dart';

class StartupDetailsModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String? imageUrl;
  final DateTime createdAt;
  final bool isFavorite;

  StartupDetailsModel({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl,
    required this.createdAt,
    this.isFavorite = false,
  });

  factory StartupDetailsModel.fromDto(StartupDto dto) {
    return StartupDetailsModel(
      id: dto.id,
      name: dto.name,
      description: dto.description,
      imageUrl: dto.imageUrl,
      createdAt: dto.createdAt,
    );
  }


  StartupDetailsModel copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    DateTime? createdAt,
    bool? isFavorite,
  }) {
    return StartupDetailsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    imageUrl,
    createdAt,
    isFavorite,
  ];
}
