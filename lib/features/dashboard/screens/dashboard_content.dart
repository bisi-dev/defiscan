part of 'dashboard.dart';

class DashboardContent {
  final String title;
  final IconData icon;
  final Widget child;

  const DashboardContent({
    required this.title,
    required this.icon,
    required this.child,
  });

  static const List<DashboardContent> list = [
    DashboardContent(title: 'history', icon: Icons.history, child: SizedBox()),
    DashboardContent(title: 'explorer', icon: Icons.search, child: SizedBox()),
    DashboardContent(
        title: 'settings', icon: Icons.settings, child: SettingsScreen()),
  ];
}
