import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/theme.dart';
import '../widgets/app_drawer.dart';
import '../services/api_service.dart';

class ProjectsPage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const ProjectsPage({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  List<Map<String, dynamic>> projects = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    try {
      final fetchedProjects = await ApiService.getProjects();
      setState(() {
        projects = fetchedProjects;
        isLoading = false;
      });
    } catch (e) {
      // If API fails, show sample projects
      setState(() {
        projects = _getSampleProjects();
        isLoading = false;
        error = null; // Don't show error for sample data
      });
    }
  }

  List<Map<String, dynamic>> _getSampleProjects() {
    return [
      {
        'title': 'E-Commerce Platform',
        'description': 'A full-stack e-commerce solution built with modern technologies, featuring user authentication, payment integration, and admin dashboard.',
        'technologies': ['Flutter', 'Node.js', 'MongoDB', 'Stripe'],
        'category': 'Mobile App',
      },
      {
        'title': 'Task Management System',
        'description': 'A comprehensive project management tool with real-time collaboration, file sharing, and progress tracking capabilities.',
        'technologies': ['React', 'Express.js', 'PostgreSQL', 'Socket.io'],
        'category': 'Web Application',
      },
      {
        'title': 'Healthcare Management App',
        'description': 'A mobile application for healthcare providers to manage patient records, appointments, and medical history securely.',
        'technologies': ['Flutter', 'Firebase', 'Cloud Functions', 'Firestore'],
        'category': 'Mobile App',
      },
      {
        'title': 'Real Estate Platform',
        'description': 'A property listing and management platform with advanced search filters, virtual tours, and agent management.',
        'technologies': ['Next.js', 'Python', 'Django', 'AWS S3'],
        'category': 'Web Application',
      },
      {
        'title': 'Learning Management System',
        'description': 'An educational platform with course creation, student progress tracking, and interactive learning modules.',
        'technologies': ['Vue.js', 'Laravel', 'MySQL', 'Redis'],
        'category': 'Web Application',
      },
      {
        'title': 'Food Delivery App',
        'description': 'A complete food delivery solution with restaurant management, order tracking, and payment processing.',
        'technologies': ['Flutter', 'Node.js', 'MongoDB', 'Google Maps API'],
        'category': 'Mobile App',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('STARK TECH'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      drawer: AppDrawer(toggleTheme: widget.toggleTheme, isDarkMode: widget.isDarkMode),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(context),
            _buildProjectsSection(context),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            AppTheme.accent.withOpacity(0.1),
            Colors.transparent,
          ],
        ),
      ),
      child: Column(
        children: [
          Text(
            'Our Projects',
            style: Theme.of(context).textTheme.displayLarge,
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 24),
          Text(
            'Showcasing our expertise through innovative solutions and cutting-edge technology implementations.',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.normal,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ).animate(delay: 300.ms).fadeIn(duration: 800.ms).slideY(begin: 0.3, end: 0),
        ],
      ),
    );
  }

  Widget _buildProjectsSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Column(
        children: [
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.accent),
              ),
            )
          else if (error != null)
            _buildErrorWidget()
          else
            _buildProjectsGrid(context),
        ],
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            'Failed to load projects',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            error!,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                isLoading = true;
                error = null;
              });
              _loadProjects();
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsGrid(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 1;
        if (constraints.maxWidth > 1200) {
          crossAxisCount = 3;
        } else if (constraints.maxWidth > 800) {
          crossAxisCount = 2;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: 0.8,
          ),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            return _buildProjectCard(context, projects[index], index);
          },
        );
      },
    );
  }

  Widget _buildProjectCard(BuildContext context, Map<String, dynamic> project, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project Image Placeholder
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.accent.withOpacity(0.8),
                  AppTheme.secondary.withOpacity(0.6),
                ],
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    _getProjectIcon(project['category']),
                    size: 64,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      project['category'] ?? 'Project',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project['title'] ?? 'Untitled Project',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: Text(
                      project['description'] ?? 'No description available.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (project['technologies'] != null)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: (project['technologies'] as List<dynamic>)
                          .take(4)
                          .map((tech) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppTheme.accent.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: AppTheme.accent.withOpacity(0.3),
                                  ),
                                ),
                                child: Text(
                                  tech.toString(),
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppTheme.accent,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        _showProjectDetails(context, project);
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppTheme.accent),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'View Details',
                        style: TextStyle(color: AppTheme.accent),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate(delay: (index * 100).ms).fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0);
  }

  IconData _getProjectIcon(String? category) {
    switch (category?.toLowerCase()) {
      case 'mobile app':
        return Icons.phone_android;
      case 'web application':
        return Icons.web;
      case 'desktop app':
        return Icons.desktop_windows;
      default:
        return Icons.code;
    }
  }

  void _showProjectDetails(BuildContext context, Map<String, dynamic> project) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(project['title'] ?? 'Project Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Description:',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  project['description'] ?? 'No description available.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                if (project['technologies'] != null) ...[
                  Text(
                    'Technologies:',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: (project['technologies'] as List<dynamic>)
                        .map((tech) => Chip(
                              label: Text(tech.toString()),
                              backgroundColor: AppTheme.accent.withOpacity(0.1),
                              labelStyle: TextStyle(color: AppTheme.accent),
                            ))
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'STARK TECH',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppTheme.accent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Building the future with innovative technology solutions.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.email),
                    color: Theme.of(context).iconTheme.color,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.code),
                    color: Theme.of(context).iconTheme.color,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.business),
                    color: Theme.of(context).iconTheme.color,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          Divider(color: Theme.of(context).dividerColor),
          const SizedBox(height: 16),
          Text(
            '© 2024 Stark Tech. All rights reserved.',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
