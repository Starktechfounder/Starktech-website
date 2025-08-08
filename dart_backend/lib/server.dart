import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:dotenv/dotenv.dart';
import 'middleware/error_handler.dart';
import 'routes/contact_routes.dart';
import 'routes/project_routes.dart';

class StarkTechServer {
  late Db _database;
  late ContactRoutes _contactRoutes;
  late ProjectRoutes _projectRoutes;
  HttpServer? _server;

  Future<void> start() async {
    // Load environment variables
    final env = DotEnv()..load();
    
    final mongoUri = env['MONGODB_URI'] ?? Platform.environment['MONGODB_URI'] ?? 'mongodb://localhost:27017/starktech';
    final port = int.parse(env['PORT'] ?? Platform.environment['PORT'] ?? '5000');
    final host = env['HOST'] ?? Platform.environment['HOST'] ?? '0.0.0.0';

    print('Starting Stark Tech Server...');
    print('MongoDB URI: $mongoUri');
    print('Server will run on: http://$host:$port');

    // Connect to MongoDB with retry logic
    await _connectToDatabase(mongoUri);

    // Initialize routes
    _contactRoutes = ContactRoutes(_database);
    _projectRoutes = ProjectRoutes(_database);

    // Seed sample data if needed
    await _projectRoutes.seedSampleProjects();

    // Create the main router
    final router = Router();

    // Health check endpoint
    router.get('/health', _healthCheck);

    // API routes
    router.mount('/api/', _createApiRouter());

    // Create middleware pipeline
    final pipeline = Pipeline()
        .addMiddleware(logRequests())
        .addMiddleware(corsHeaders())
        .addMiddleware(ErrorHandler.middleware())
        .addHandler(router);

    // Start the server
    _server = await shelf_io.serve(
      pipeline,
      host,
      port,
    );

    print('Server started successfully!');
    print('Health check: http://$host:$port/health');
    print('API endpoints:');
    print('  POST http://$host:$port/api/contact');
    print('  GET  http://$host:$port/api/projects');
    print('  GET  http://$host:$port/api/contacts');
  }

  Future<void> stop() async {
    print('Stopping server...');
    await _server?.close();
    await _database.close();
    print('Server stopped.');
  }

  Future<void> _connectToDatabase(String mongoUri) async {
    print('Connecting to MongoDB...');
    
    int retryCount = 0;
    const maxRetries = 5;
    const retryDelay = Duration(seconds: 5);

    while (retryCount < maxRetries) {
      try {
        _database = Db(mongoUri);
        await _database.open();
        
        // Test the connection
        await _database.collection('test').findOne();
        
        print('Connected to MongoDB successfully!');
        return;
      } catch (e) {
        retryCount++;
        print('MongoDB connection attempt $retryCount failed: $e');
        
        if (retryCount >= maxRetries) {
          print('Failed to connect to MongoDB after $maxRetries attempts');
          throw Exception('Could not connect to MongoDB: $e');
        }
        
        print('Retrying in ${retryDelay.inSeconds} seconds...');
        await Future.delayed(retryDelay);
      }
    }
  }

  Router _createApiRouter() {
    final apiRouter = Router();

    // Mount contact routes
    apiRouter.mount('/', _contactRoutes.router);

    // Mount project routes
    apiRouter.mount('/', _projectRoutes.router);

    // API info endpoint
    apiRouter.get('/', _apiInfo);

    return apiRouter;
  }

  Response _healthCheck(Request request) {
    return Response.ok(
      '{"status": "healthy", "timestamp": "${DateTime.now().toIso8601String()}"}',
      headers: {'Content-Type': 'application/json'},
    );
  }

  Response _apiInfo(Request request) {
    return Response.ok(
      '''
{
  "name": "Stark Tech API",
  "version": "1.0.0",
  "description": "Backend API for Stark Tech Flutter application",
  "endpoints": {
    "contact": {
      "POST /api/contact": "Submit contact form",
      "GET /api/contacts": "Get all contacts (admin)"
    },
    "projects": {
      "GET /api/projects": "Get all projects",
      "POST /api/projects": "Create new project (admin)",
      "GET /api/projects/:id": "Get project by ID"
    }
  },
  "timestamp": "${DateTime.now().toIso8601String()}"
}
      ''',
      headers: {'Content-Type': 'application/json'},
    );
  }
}

// CORS configuration
Map<String, String> corsHeaders() {
  return {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
    'Access-Control-Allow-Headers': 'Origin, Content-Type, Accept, Authorization, X-Requested-With',
    'Access-Control-Max-Age': '86400',
  };
}

// Main entry point
Future<void> main(List<String> args) async {
  final server = StarkTechServer();

  // Handle graceful shutdown
  ProcessSignal.sigint.watch().listen((signal) async {
    print('\nReceived SIGINT, shutting down gracefully...');
    await server.stop();
    exit(0);
  });

  ProcessSignal.sigterm.watch().listen((signal) async {
    print('\nReceived SIGTERM, shutting down gracefully...');
    await server.stop();
    exit(0);
  });

  try {
    await server.start();
  } catch (e) {
    print('Failed to start server: $e');
    exit(1);
  }
}
