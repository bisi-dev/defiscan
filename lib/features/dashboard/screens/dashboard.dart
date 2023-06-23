import 'package:defiscan/core/app_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../settings/screens/settings.dart';
import '../bloc/dashboard_cubit.dart';
import 'widgets/custom_navigation_bar.dart';

part 'dashboard_content.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  static final PageController _pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(),
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          return Scaffold(
            body: SizedBox.expand(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  context.read<DashboardCubit>().swipeTo(index);
                },
                children: DashboardContent.list.map((e) => e.child).toList(),
              ),
            ),
            bottomNavigationBar: CustomNavigationBar(
              backgroundColor: Theme.of(context).primaryColor,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              selectedIndex: state.currentIndex,
              onItemSelected: (index) {
                _pageController.jumpToPage(index);
                context.read<DashboardCubit>().swipeTo(index);
              },
              items: DashboardContent.list
                  .map((e) => CustomNavigationBarItem(
                        title: Text(e.title),
                        icon: Icon(e.icon),
                      ))
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
