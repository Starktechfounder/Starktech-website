import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/theme.dart';
import '../widgets/app_drawer.dart';

class HomePage extends StatelessWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const HomePage({
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
            _buildServicesSection(context),
            _buildStatsSection(context),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppTheme.primary.withOpacity(0.9),
            AppTheme.dark.withOpacity(0.7),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background pattern
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topRight,
                radius: 1.5,
                colors: [
                  AppTheme.accent.withOpacity(0.1),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Crafting the Future of Tech',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 48,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.3, end: 0),
                  const SizedBox(height: 16),
                  Text(
                    'One Line of Code at a Time',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: AppTheme.accent,
                      fontSize: 32,
                    ),
                    textAlign: TextAlign.center,
                  ).animate(delay: 300.ms).fadeIn(duration: 800.ms).slideY(begin: 0.3, end: 0),
                  const SizedBox(height: 32),
                  Text(
                    'Where innovation meets technology. We build modern, efficient, and scalable solutions for the digital era.',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.normal,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ).animate(delay: 600.ms).fadeIn(duration: 800.ms).slideY(begin: 0.3, end: 0),
                  const SizedBox(height: 48),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, '/projects'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.accent,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        ),
                        child: const Text('View Projects'),
                      ).animate(delay: 900.ms).fadeIn(duration: 600.ms).scale(begin: const Offset(0.8, 0.8)),
                      const SizedBox(width: 16),
                      OutlinedButton(
                        onPressed: () => Navigator.pushNamed(context, '/contact'),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white),
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        ),
                        child: Text(
                          'Let\'s Work Together',
                          style: TextStyle(color: Colors.white),
                        ),
                      ).animate(delay: 1100.ms).fadeIn(duration: 600.ms).scale(begin: const Offset(0.8, 0.8)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Column(
        children: [
          Text(
            'Our Services',
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'We offer comprehensive solutions tailored to your needs, from web development to mobile applications.',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildServiceCard(context, 'Web Development', 'Full-stack solutions with modern technologies and frameworks.', Icons.code)),
                    const SizedBox(width: 24),
                    Expanded(child: _buildServiceCard(context, 'Mobile Development', 'Cross-platform mobile applications that deliver exceptional user experience.', Icons.phone_android)),
                    const SizedBox(width: 24),
                    Expanded(child: _buildServiceCard(context, 'Cloud Services', 'Scalable cloud solutions for modern businesses.', Icons.cloud)),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildServiceCard(context, 'Web Development', 'Full-stack solutions with modern technologies and frameworks.', Icons.code),
                    const SizedBox(height: 24),
                    _buildServiceCard(context, 'Mobile Development', 'Cross-platform mobile applications that deliver exceptional user experience.', Icons.phone_android),
                    const SizedBox(height: 24),
                    _buildServiceCard(context, 'Cloud Services', 'Scalable cloud solutions for modern businesses.', Icons.cloud),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, String title, String description, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(32),
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
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppTheme.accent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: AppTheme.accent,
              size: 32,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      decoration: const BoxDecoration(
        color: AppTheme.accent,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem(context, '20+', 'Projects Completed'),
                _buildStatItem(context, '15+', 'Happy Clients'),
                _buildStatItem(context, '2+', 'Years Experience'),
                _buildStatItem(context, '24/7', 'Support'),
              ],
            );
          } else {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatItem(context, '20+', 'Projects Completed'),
                    _buildStatItem(context, '15+', 'Happy Clients'),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatItem(context, '2+', 'Years Experience'),
                    _buildStatItem(context, '24/7', 'Support'),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.white.withOpacity(0.8),
          ),
          textAlign: TextAlign.center,
        ),
      ],
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
