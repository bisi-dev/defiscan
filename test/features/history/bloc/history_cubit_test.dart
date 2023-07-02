import 'package:bloc_test/bloc_test.dart';
import 'package:defiscan/features/history/bloc/history_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  late HistoryCubit historyCubit;

  setUp(() {
    historyCubit = HistoryCubit();
  });

  group('History Cubit Test', () {
    blocTest(
      'emits [] when nothing is added',
      build: () => historyCubit,
      act: (bloc) => historyCubit,
      expect: () => [],
    );
  });
}
