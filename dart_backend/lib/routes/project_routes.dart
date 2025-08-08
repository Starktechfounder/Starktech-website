import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../models/project.dart';
import '../middleware/error_handler.dart';

class ProjectRoutes {
  final Db database;
  late final DbCollection _projectCollection;

  ProjectRoutes(this.database) {
    _projectCollection = database.collection('projects');
  }

  Router get router {
    final router = Router();

    // GET /api/projects - Get all projects
    router.get('/projects', _getProjects);

    // POST /api/projects - Create new project (admin only)
    router.post('/projects', _createProject);

    // GET /api/projects/<id> - Get project by ID
    router.get('/projects/<id>', _getProjectById);

    return router;
  }

  Future<Response> _getProjects(Request request) async {
    try {
      // Get query parameters for filtering/sorting
      final queryParams = request.url.queryParameters;
      final category = queryParams['category'];
      final limit = int.tryParse(queryParams['limit'] ?? '10') ?? 10;
      final skip = int.tryParse(queryParams['skip'] ?? '0') ?? 0;

      // Build query
      final query = <String, dynamic>{};
      if (category != null && category.isNotEmpty) {
        query['category'] = category;
      }

      // Execute query
      final projects = await _projectCollection
          .find(query)
          .skip(skip)
          .limit(limit)
          .map((doc) => Project.fromJson(doc).toJson())
          .toList();

      // Get total count for pagination
      final totalCount = await _projectCollection.count(query);

      return Response.ok(
        jsonEncode({
          'status': 'success',
          'data': projects,
          'pagination': {
            'total': totalCount,
            'limit': limit,
            'skip': skip,
            'hasMore': (skip + limit) < totalCount,
          },
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );
    } catch (e) {
      print('Database error: $e');
      throw DatabaseException('Failed to retrieve projects');
    }
  }

  Future<Response> _createProject(Request request) async {
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
      final title = data['title']?.toString() ?? '';
      final description = data['description']?.toString() ?? '';
      final technologies = (data['technologies'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ?? [];
      final imageUrl = data['imageUrl']?.toString();
      final projectUrl = data['projectUrl']?.toString();
      final category = data['category']?.toString();

      // Validate input
      final validationErrors = Project.validateProject(
        title: title,
        description: description,
        technologies: technologies,
      );

      if (validationErrors.isNotEmpty) {
        throw ValidationException(
          'Validation failed',
          validationErrors,
        );
      }

      // Create project object
      final project = Project(
        title: title.trim(),
        description: description.trim(),
        technologies: technologies.map((t) => t.trim()).toList(),
        imageUrl: imageUrl?.trim(),
        projectUrl: projectUrl?.trim(),
        category: category?.trim(),
        createdAt: DateTime.now(),
      );

      // Save to database
      try {
        final result = await _projectCollection.insertOne(project.toJson());
        final insertedId = result.id;

        return Response(
          201,
          body: jsonEncode({
            'status': 'success',
            'message': 'Project created successfully',
            'data': {
              'id': insertedId.toString(),
              ...project.toJson(),
            },
          }),
          headers: {
            'Content-Type': 'application/json',
          },
        );
      } catch (e) {
        print('Database error: $e');
        throw DatabaseException('Failed to create project');
      }
    } catch (e) {
      rethrow; // Let error handler middleware handle it
    }
  }

  Future<Response> _getProjectById(Request request, String id) async {
    try {
      // Validate ObjectId format
      ObjectId objectId;
      try {
        objectId = ObjectId.fromHexString(id);
      } catch (e) {
        throw HttpException(400, 'Invalid project ID format');
      }

      // Find project by ID
      final projectDoc = await _projectCollection.findOne({'_id': objectId});
      
      if (projectDoc == null) {
        throw HttpException(404, 'Project not found');
      }

      final project = Project.fromJson(projectDoc);

      return Response.ok(
        jsonEncode({
          'status': 'success',
          'data': project.toJson(),
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );
    } catch (e) {
      if (e is HttpException) {
        rethrow;
      }
      print('Database error: $e');
      throw DatabaseException('Failed to retrieve project');
    }
  }

  // Helper method to seed sample projects (for development)
  Future<void> seedSampleProjects() async {
    try {
      // Check if projects already exist
      final existingCount = await _projectCollection.count();
      if (existingCount > 0) {
        print('Projects already exist, skipping seed');
        return;
      }

      final sampleProjects = [
        Project(
          title: 'E-Commerce Platform',
          description: 'A full-stack e-commerce solution built with modern technologies, featuring user authentication, payment integration, and admin dashboard.',
          technologies: ['Flutter', 'Node.js', 'MongoDB', 'Stripe'],
          category: 'Mobile App',
          createdAt: DateTime.now().subtract(const Duration(days: 30)),
        ),
        Project(
          title: 'Task Management System',
          description: 'A comprehensive project management tool with real-time collaboration, file sharing, and progress tracking capabilities.',
          technologies: ['React', 'Express.js', 'PostgreSQL', 'Socket.io'],
          category: 'Web Application',
          createdAt: DateTime.now().subtract(const Duration(days: 25)),
        ),
        Project(
          title: 'Healthcare Management App',
          description: 'A mobile application for healthcare providers to manage patient records, appointments, and medical history securely.',
          technologies: ['Flutter', 'Firebase', 'Cloud Functions', 'Firestore'],
          category: 'Mobile App',
          createdAt: DateTime.now().subtract(const Duration(days: 20)),
        ),
        Project(
          title: 'Real Estate Platform',
          description: 'A property listing and management platform with advanced search filters, virtual tours, and agent management.',
          technologies: ['Next.js', 'Python', 'Django', 'AWS S3'],
          category: 'Web Application',
          createdAt: DateTime.now().subtract(const Duration(days: 15)),
        ),
        Project(
          title: 'Learning Management System',
          description: 'An educational platform with course creation, student progress tracking, and interactive learning modules.',
          technologies: ['Vue.js', 'Laravel', 'MySQL', 'Redis'],
          category: 'Web Application',
          createdAt: DateTime.now().subtract(const Duration(days: 10)),
        ),
        Project(
          title: 'Food Delivery App',
          description: 'A complete food delivery solution with restaurant management, order tracking, and payment processing.',
          technologies: ['Flutter', 'Node.js', 'MongoDB', 'Google Maps API'],
          category: 'Mobile App',
          createdAt: DateTime.now().subtract(const Duration(days: 5)),
        ),
      ];

      // Insert sample projects
      for (final project in sampleProjects) {
        await _projectCollection.insertOne(project.toJson());
      }

      print('Sample projects seeded successfully');
    } catch (e) {
      print('Error seeding sample projects: $e');
    }
  }
}
