import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../models/contact.dart';
import '../middleware/error_handler.dart';

class ContactRoutes {
  final Db database;
  late final DbCollection _contactCollection;

  ContactRoutes(this.database) {
    _contactCollection = database.collection('contacts');
  }

  Router get router {
    final router = Router();

    // POST /api/contact - Submit contact form
    router.post('/contact', _submitContact);

    // GET /api/contacts - Get all contacts (admin only)
    router.get('/contacts', _getContacts);

    return router;
  }

  Future<Response> _submitContact(Request request) async {
    try {
      // Parse request body
      final body = await request.readAsString();
      final Map<String, dynamic> data;
      
      try {
        data = jsonDecode(body) as Map<String, dynamic>;
      } catch (e) {
        throw HttpException(400, 'Invalid JSON format');
      }

      // Extract and validate data
      final name = data['name']?.toString() ?? '';
      final email = data['email']?.toString() ?? '';
      final subject = data['subject']?.toString() ?? '';
      final message = data['message']?.toString() ?? '';

      // Validate input
      final validationErrors = Contact.validateContact(
        name: name,
        email: email,
        subject: subject,
        message: message,
      );

      if (validationErrors.isNotEmpty) {
        throw ValidationException(
          'Validation failed',
          validationErrors,
        );
      }

      // Get client IP address
      String? ipAddress;
      try {
        ipAddress = _getClientIpAddress(request);
      } catch (e) {
        // IP address is optional, continue without it
        ipAddress = null;
      }

      // Create contact object
      final contact = Contact(
        name: name.trim(),
        email: email.trim().toLowerCase(),
        subject: subject.trim(),
        message: message.trim(),
        createdAt: DateTime.now(),
        ipAddress: ipAddress,
      );

      // Save to database
      try {
        await _contactCollection.insertOne(contact.toJson());
      } catch (e) {
        print('Database error: $e');
        throw DatabaseException('Failed to save contact message');
      }

      // Return success response
      return Response(
        201,
        body: jsonEncode({
          'status': 'success',
          'message': 'Message sent successfully! We will get back to you soon.',
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );
    } catch (e) {
      rethrow; // Let error handler middleware handle it
    }
  }

  Future<Response> _getContacts(Request request) async {
    try {
      // This endpoint could be protected with authentication in a real app
      final contacts = await _contactCollection
          .find()
          .map((doc) => Contact.fromJson(doc).toJson())
          .toList();

      return Response.ok(
        jsonEncode({
          'status': 'success',
          'data': contacts,
          'count': contacts.length,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );
    } catch (e) {
      print('Database error: $e');
      throw DatabaseException('Failed to retrieve contacts');
    }
  }

  String? _getClientIpAddress(Request request) {
    // Try to get IP from various headers
    final headers = request.headers;
    
    // Check X-Forwarded-For header (most common for proxied requests)
    final xForwardedFor = headers['x-forwarded-for'];
    if (xForwardedFor != null && xForwardedFor.isNotEmpty) {
      // X-Forwarded-For can contain multiple IPs, take the first one
      return xForwardedFor.split(',').first.trim();
    }

    // Check X-Real-IP header
    final xRealIp = headers['x-real-ip'];
    if (xRealIp != null && xRealIp.isNotEmpty) {
      return xRealIp;
    }

    // Check X-Client-IP header
    final xClientIp = headers['x-client-ip'];
    if (xClientIp != null && xClientIp.isNotEmpty) {
      return xClientIp;
    }

    // Fallback to connection info (may not be available in all environments)
    try {
      final connectionInfo = request.context['shelf.io.connection_info'] as HttpConnectionInfo?;
      return connectionInfo?.remoteAddress.address;
    } catch (e) {
      // Connection info not available
      return null;
    }
  }
}
