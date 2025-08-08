import 'package:mongo_dart/mongo_dart.dart';

class Project {
  final ObjectId? id;
  final String title;
  final String description;
  final List<String> technologies;
  final String? imageUrl;
  final String? projectUrl;
  final String? category;
  final DateTime createdAt;

  Project({
    this.id,
    required this.title,
    required this.description,
    required this.technologies,
    this.imageUrl,
    this.projectUrl,
    this.category,
    required this.createdAt,
  });

  // Convert Project to Map for MongoDB insertion
  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      'title': title,
      'description': description,
      'technologies': technologies,
      'imageUrl': imageUrl,
      'projectUrl': projectUrl,
      'category': category,
      'createdAt': createdAt,
    };
  }

  // Create Project from MongoDB document
  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['_id'] as ObjectId?,
      title: json['title'] as String,
      description: json['description'] as String,
      technologies: List<String>.from(json['technologies'] as List),
      imageUrl: json['imageUrl'] as String?,
      projectUrl: json['projectUrl'] as String?,
      category: json['category'] as String?,
      createdAt: json['createdAt'] as DateTime,
    );
  }

  // Validation methods
  static String? validateTitle(String? title) {
    if (title == null || title.trim().isEmpty) {
      return 'Title is required';
    }
    final trimmedTitle = title.trim();
    if (trimmedTitle.length < 3) {
      return 'Title must be at least 3 characters';
    }
    if (trimmedTitle.length > 100) {
      return 'Title cannot exceed 100 characters';
    }
    return null;
  }

  static String? validateDescription(String? description) {
    if (description == null || description.trim().isEmpty) {
      return 'Description is required';
    }
    final trimmedDescription = description.trim();
    if (trimmedDescription.length < 10) {
      return 'Description must be at least 10 characters';
    }
    if (trimmedDescription.length > 1000) {
      return 'Description cannot exceed 1000 characters';
    }
    return null;
  }

  static String? validateTechnologies(List<String>? technologies) {
    if (technologies == null || technologies.isEmpty) {
      return 'At least one technology is required';
    }
    if (technologies.length > 10) {
      return 'Cannot have more than 10 technologies';
    }
    return null;
  }

  // Validate all fields
  static Map<String, String> validateProject({
    required String title,
    required String description,
    required List<String> technologies,
  }) {
    final errors = <String, String>{};

    final titleError = validateTitle(title);
    if (titleError != null) errors['title'] = titleError;

    final descriptionError = validateDescription(description);
    if (descriptionError != null) errors['description'] = descriptionError;

    final technologiesError = validateTechnologies(technologies);
    if (technologiesError != null) errors['technologies'] = technologiesError;

    return errors;
  }
}
