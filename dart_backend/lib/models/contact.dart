import 'package:mongo_dart/mongo_dart.dart';

class Contact {
  final ObjectId? id;
  final String name;
  final String email;
  final String subject;
  final String message;
  final DateTime createdAt;
  final String? ipAddress;

  Contact({
    this.id,
    required this.name,
    required this.email,
    required this.subject,
    required this.message,
    required this.createdAt,
    this.ipAddress,
  });

  // Convert Contact to Map for MongoDB insertion
  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      'name': name,
      'email': email,
      'subject': subject,
      'message': message,
      'createdAt': createdAt,
      'ipAddress': ipAddress,
    };
  }

  // Create Contact from MongoDB document
  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['_id'] as ObjectId?,
      name: json['name'] as String,
      email: json['email'] as String,
      subject: json['subject'] as String,
      message: json['message'] as String,
      createdAt: json['createdAt'] as DateTime,
      ipAddress: json['ipAddress'] as String?,
    );
  }

  // Validation methods
  static String? validateName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return 'Name is required';
    }
    final trimmedName = name.trim();
    if (trimmedName.length < 2) {
      return 'Name must be at least 2 characters';
    }
    if (trimmedName.length > 50) {
      return 'Name cannot exceed 50 characters';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(trimmedName)) {
      return 'Name can only contain letters and spaces';
    }
    return null;
  }

  static String? validateEmail(String? email) {
    if (email == null || email.trim().isEmpty) {
      return 'Email is required';
    }
    final trimmedEmail = email.trim().toLowerCase();
    if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(trimmedEmail)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? validateSubject(String? subject) {
    if (subject == null || subject.trim().isEmpty) {
      return 'Subject is required';
    }
    final trimmedSubject = subject.trim();
    if (trimmedSubject.length < 3) {
      return 'Subject must be at least 3 characters';
    }
    if (trimmedSubject.length > 100) {
      return 'Subject cannot exceed 100 characters';
    }
    return null;
  }

  static String? validateMessage(String? message) {
    if (message == null || message.trim().isEmpty) {
      return 'Message is required';
    }
    final trimmedMessage = message.trim();
    if (trimmedMessage.length < 10) {
      return 'Message must be at least 10 characters';
    }
    if (trimmedMessage.length > 1000) {
      return 'Message cannot exceed 1000 characters';
    }
    return null;
  }

  // Validate all fields
  static Map<String, String> validateContact({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) {
    final errors = <String, String>{};

    final nameError = validateName(name);
    if (nameError != null) errors['name'] = nameError;

    final emailError = validateEmail(email);
    if (emailError != null) errors['email'] = emailError;

    final subjectError = validateSubject(subject);
    if (subjectError != null) errors['subject'] = subjectError;

    final messageError = validateMessage(message);
    if (messageError != null) errors['message'] = messageError;

    return errors;
  }
}
