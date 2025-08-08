import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/theme.dart';
import '../widgets/app_drawer.dart';

class BlogPage extends StatelessWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const BlogPage({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('STARK TECH'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: toggleTheme,
          ),
        ],
      ),
      drawer: AppDrawer(toggleTheme: toggleTheme, isDarkMode: isDarkMode),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(context),
            _buildBlogSection(context),
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
            'Tech Insights & Updates',
            style: Theme.of(context).textTheme.displayLarge,
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 24),
          Text(
            'Stay updated with the latest trends, insights, and innovations in technology and software development.',
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

  Widget _buildBlogSection(BuildContext context) {
    final blogPosts = _getSampleBlogPosts();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Column(
        children: [
          Text(
            'Latest Articles',
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: blogPosts.length,
                  itemBuilder: (context, index) {
                    return _buildBlogCard(context, blogPosts[index], index);
                  },
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: blogPosts.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: _buildBlogCard(context, blogPosts[index], index),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getSampleBlogPosts() {
    return [
      {
        'title': 'The Future of Flutter Development',
        'excerpt': 'Exploring the latest features and improvements in Flutter 3.0 and what they mean for cross-platform development.',
        'date': '2024-01-15',
        'readTime': '5 min read',
        'category': 'Flutter',
        'tags': ['Flutter', 'Mobile Development', 'Cross-platform'],
      },
      {
        'title': 'Building Scalable APIs with Node.js',
        'excerpt': 'Best practices for creating robust and scalable backend services using Node.js and Express framework.',
        'date': '2024-01-10',
        'readTime': '8 min read',
        'category': 'Backend',
        'tags': ['Node.js', 'API', 'Backend', 'Scalability'],
      },
      {
        'title': 'MongoDB vs PostgreSQL: Choosing the Right Database',
        'excerpt': 'A comprehensive comparison of MongoDB and PostgreSQL to help you make the right choice for your project.',
        'date': '2024-01-05',
        'readTime': '6 min read',
        'category': 'Database',
        'tags': ['MongoDB', 'PostgreSQL', 'Database', 'Comparison'],
      },
      {
        'title': 'Modern UI/UX Design Principles',
        'excerpt': 'Essential design principles and trends that every developer should know to create better user experiences.',
        'date': '2023-12-28',
        'readTime': '7 min read',
        'category': 'Design',
        'tags': ['UI/UX', 'Design', 'User Experience', 'Trends'],
      },
      {
        'title': 'Cloud Computing: AWS vs Azure vs GCP',
        'excerpt': 'Comparing the major cloud platforms and their services to help you choose the best fit for your needs.',
        'date': '2023-12-20',
        'readTime': '10 min read',
        'category': 'Cloud',
        'tags': ['AWS', 'Azure', 'GCP', 'Cloud Computing'],
      },
      {
        'title': 'Getting Started with DevOps',
        'excerpt': 'A beginner-friendly guide to DevOps practices, tools, and methodologies for modern software development.',
        'date': '2023-12-15',
        'readTime': '9 min read',
        'category': 'DevOps',
        'tags': ['DevOps', 'CI/CD', 'Automation', 'Development'],
      },
    ];
  }

  Widget _buildBlogCard(BuildContext context, Map<String, dynamic> post, int index) {
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
          // Blog post header with category
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _getCategoryColor(post['category']).withOpacity(0.8),
                  _getCategoryColor(post['category']).withOpacity(0.6),
                ],
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    _getCategoryIcon(post['category']),
                    size: 48,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      post['category'],
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
                      post['readTime'],
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
                    post['title'],
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    post['date'],
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.accent,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: Text(
                      post['excerpt'],
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (post['tags'] != null)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: (post['tags'] as List<dynamic>)
                          .take(3)
                          .map((tag) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).dividerColor.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  tag.toString(),
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 10,
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
                        _showBlogDetails(context, post);
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppTheme.accent),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Read More',
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

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'flutter':
        return Colors.blue;
      case 'backend':
        return Colors.green;
      case 'database':
        return Colors.orange;
      case 'design':
        return Colors.purple;
      case 'cloud':
        return Colors.cyan;
      case 'devops':
        return Colors.red;
      default:
        return AppTheme.accent;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'flutter':
        return Icons.phone_android;
      case 'backend':
        return Icons.storage;
      case 'database':
        return Icons.data_usage;
      case 'design':
        return Icons.palette;
      case 'cloud':
        return Icons.cloud;
      case 'devops':
        return Icons.settings;
      default:
        return Icons.article;
    }
  }

  void _showBlogDetails(BuildContext context, Map<String, dynamic> post) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            post['title'],
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(post['category']).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _getCategoryColor(post['category']).withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        post['category'],
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: _getCategoryColor(post['category']),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      post['date'],
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  post['excerpt'],
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'This is a sample blog post. In a real application, you would fetch the full content from your backend API or content management system.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.6,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 16),
                if (post['tags'] != null) ...[
                  Text(
                    'Tags:',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: (post['tags'] as List<dynamic>)
                        .map((tag) => Chip(
                              label: Text(tag.toString()),
                              backgroundColor: AppTheme.accent.withOpacity(0.1),
                              labelStyle: TextStyle(
                                color: AppTheme.accent,
                                fontSize: 12,
                              ),
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
