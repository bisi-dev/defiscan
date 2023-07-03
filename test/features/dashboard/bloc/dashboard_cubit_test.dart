import 'package:bloc_test/bloc_test.dart';
import 'package:defiscan/features/dashboard/bloc/dashboard_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  late DashboardCubit dashboardCubit;

  setUp(() => dashboardCubit = DashboardCubit());

  group('Dashboard Cubit Test', () {
    blocTest(
      'emits state with current index of selected page',
      build: () => dashboardCubit,
      act: (bloc) => dashboardCubit.swipeTo(0),
      expect: () => [const DashboardState(0)],
    );
  });
}
