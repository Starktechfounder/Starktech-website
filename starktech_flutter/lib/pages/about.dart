import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/theme.dart';
import '../widgets/app_drawer.dart';

class AboutPage extends StatelessWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const AboutPage({
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
            _buildCEOSection(context),
            _buildSkillsSection(context),
            _buildTechnologiesSection(context),
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
            'Our Expertise',
            style: Theme.of(context).textTheme.displayLarge,
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.3, end: 0),
          const SizedBox(height: 24),
          Text(
            'Delivering cutting-edge technology solutions with a focus on scalability, performance, and innovation.',
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

  Widget _buildCEOSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      color: Theme.of(context).cardColor,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            return Row(
              children: [
                Expanded(
                  child: _buildCEOImage(context),
                ),
                const SizedBox(width: 48),
                Expanded(
                  child: _buildCEOInfo(context),
                ),
              ],
            );
          } else {
            return Column(
              children: [
                _buildCEOImage(context),
                const SizedBox(height: 32),
                _buildCEOInfo(context),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildCEOImage(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.accent.withOpacity(0.1),
                  AppTheme.secondary.withOpacity(0.1),
                ],
              ),
            ),
            child: const Icon(
              Icons.person,
              size: 120,
              color: AppTheme.accent,
            ),
          ),
          Positioned(
            bottom: -16,
            right: -16,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.accent,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.accent.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Text(
                'CEO & Founder',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCEOInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Leadership',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 16),
        Text(
          'Akati Omkar Reddy',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: AppTheme.accent,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'As the CEO and Founder of Stark Tech, Omkar brings a passion for innovation and a deep understanding of modern technology solutions. His vision drives our commitment to delivering cutting-edge solutions that help businesses thrive in the digital age.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            height: 1.6,
          ),
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            _buildSocialButton(context, Icons.code, 'GitHub'),
            const SizedBox(width: 16),
            _buildSocialButton(context, Icons.business, 'LinkedIn'),
            const SizedBox(width: 16),
            _buildSocialButton(context, Icons.email, 'Email'),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton(BuildContext context, IconData icon, String label) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          icon,
          color: Theme.of(context).iconTheme.color,
        ),
        tooltip: label,
      ),
    );
  }

  Widget _buildSkillsSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Column(
        children: [
          Text(
            'Core Technologies',
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildSkillsList(context)),
                    const SizedBox(width: 48),
                    Expanded(child: _buildTechStack(context)),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildSkillsList(context),
                    const SizedBox(height: 48),
                    _buildTechStack(context),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsList(BuildContext context) {
    final skills = [
      {'name': 'Frontend Development', 'percentage': 95},
      {'name': 'Backend Development', 'percentage': 90},
      {'name': 'Mobile Development', 'percentage': 88},
      {'name': 'Cloud Services', 'percentage': 85},
      {'name': 'DevOps & CI/CD', 'percentage': 82},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: skills.map((skill) => _buildSkillBar(context, skill['name'] as String, skill['percentage'] as int)).toList(),
    );
  }

  Widget _buildSkillBar(BuildContext context, String skill, int percentage) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                skill,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                '$percentage%',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: Theme.of(context).dividerColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percentage / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.accent,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechStack(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.2,
      children: [
        _buildTechCard(context, 'Frontend Stack', Icons.web, ['React & Next.js', 'Vue.js & Nuxt', 'Tailwind CSS', 'TypeScript']),
        _buildTechCard(context, 'Backend Stack', Icons.storage, ['Node.js & Express', 'Python & Django', 'GraphQL', 'RESTful APIs']),
        _buildTechCard(context, 'Mobile Stack', Icons.phone_android, ['Flutter & Dart', 'React Native', 'iOS Development', 'Android Development']),
        _buildTechCard(context, 'Cloud & DevOps', Icons.cloud, ['AWS Services', 'Docker & Kubernetes', 'CI/CD Pipelines', 'Microservices']),
      ],
    );
  }

  Widget _buildTechCard(BuildContext context, String title, IconData icon, List<String> technologies) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: AppTheme.accent,
            size: 32,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: technologies.take(3).map((tech) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  '• $tech',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechnologiesSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          Text(
            'Additional Technologies',
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: MediaQuery.of(context).size.width > 800 ? 4 : 2,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: 1.0,
            children: [
              _buildTechCategory(context, 'Databases', ['MongoDB', 'PostgreSQL', 'Redis', 'Firebase']),
              _buildTechCategory(context, 'Testing', ['Jest', 'Cypress', 'Selenium', 'PyTest']),
              _buildTechCategory(context, 'Tools', ['Git & GitHub', 'Jira & Confluence', 'Figma', 'Postman']),
              _buildTechCategory(context, 'AI/ML', ['TensorFlow', 'PyTorch', 'OpenCV', 'Scikit-learn']),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTechCategory(BuildContext context, String title, List<String> technologies) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: technologies.map((tech) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  '• $tech',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              )).toList(),
            ),
          ),
        ],
      ),
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
