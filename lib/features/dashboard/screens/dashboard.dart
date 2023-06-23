import 'package:defiscan/core/app_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../settings/screens/settings.dart';
import '../bloc/dashboard_cubit.dart';
import 'widgets/custom_navigation_bar.dart';

part 'dashboard_content.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final page = ModalRoute.of(context)!.settings.arguments as int?;
    PageController _pageController = PageController(initialPage: page ?? 1);

    return BlocProvider(
      create: (context) => DashboardCubit()..swipeTo(page ?? 1),
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
                        title: Text(e.title.i18n()),
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
