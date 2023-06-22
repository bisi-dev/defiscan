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
    DashboardContent(title: 'History', icon: Icons.history, child: SizedBox()),
    DashboardContent(title: 'Explorer', icon: Icons.search, child: SizedBox()),
    DashboardContent(
        title: 'Settings', icon: Icons.settings, child: SizedBox()),
  ];
}
