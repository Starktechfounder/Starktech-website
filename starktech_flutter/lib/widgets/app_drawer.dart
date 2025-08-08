import 'package:flutter/material.dart';
import '../constants/theme.dart';

class AppDrawer extends StatelessWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const AppDrawer({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              gradient: LinearGradient(
                colors: [
                  AppTheme.accent,
                  AppTheme.accent.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'STARK TECH',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Innovative Technology Solutions',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  context,
                  icon: Icons.home_outlined,
                  title: 'Home',
                  route: '/',
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.person_outline,
                  title: 'About',
                  route: '/about',
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.work_outline,
                  title: 'Projects',
                  route: '/projects',
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.article_outlined,
                  title: 'Blog',
                  route: '/blog',
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.contact_mail_outlined,
                  title: 'Contact',
                  route: '/contact',
                ),
                const Divider(),
                ListTile(
                  leading: Icon(
                    isDarkMode ? Icons.light_mode : Icons.dark_mode,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  title: Text(
                    isDarkMode ? 'Light Mode' : 'Dark Mode',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  onTap: () {
                    toggleTheme();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              '© 2024 Stark Tech',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
  }) {
    final isCurrentRoute = ModalRoute.of(context)?.settings.name == route;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isCurrentRoute 
          ? AppTheme.accent.withOpacity(0.1)
          : Colors.transparent,
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isCurrentRoute 
            ? AppTheme.accent 
            : Theme.of(context).iconTheme.color,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: isCurrentRoute 
              ? AppTheme.accent 
              : Theme.of(context).textTheme.bodyLarge?.color,
            fontWeight: isCurrentRoute ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        onTap: () {
          Navigator.pop(context);
          if (!isCurrentRoute) {
            Navigator.pushReplacementNamed(context, route);
          }
        },
      ),
    );
  }
}
