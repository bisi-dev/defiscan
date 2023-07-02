import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:defiscan/features/explorer/bloc/explorer_cubit.dart';
import 'package:defiscan/features/explorer/models/account.dart';
import 'package:defiscan/features/explorer/repository/explorer_repository.dart';
import 'package:defiscan/shared/prefs/app_preferences.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockExplorerRepository extends Mock implements ExplorerRepository {}

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  await AppPreferences.init();
  late ExplorerCubit explorerCubit;
  late MockExplorerRepository mockExplorerRepository;
  late ExplorerState state;

  setUp(() {
    state = const ExplorerInitial(Data.initial);
    mockExplorerRepository = MockExplorerRepository();
    explorerCubit = ExplorerCubit(mockExplorerRepository);
  });

  group('Explorer Cubit Tests for Success Situations', () {
    String btcAddress = '1CFVqfigwSX6DbCtPVNcpEEVmYV2VBZsRc';
    blocTest(
      'emits Success when correct bitcoin address is searched',
      build: () => explorerCubit,
      setUp: () {
        when(() => mockExplorerRepository.getBalanceBTC(any()))
            .thenAnswer((_) => Future.value(const Right(1000)));

        when(() => mockExplorerRepository.getCoinRate(any()))
            .thenAnswer((_) => Future.value(0.0));
      },
      act: (bloc) => explorerCubit.getAccountList(btcAddress),
      expect: () => [
        ExplorerLoading(
            state.data.copyWith(entry: btcAddress, info: "searching")),
        ExplorerLoading(
            state.data.copyWith(entry: btcAddress, info: "retrieve_account")),
        ExplorerSuccess(
          state.data.copyWith(
            entry: btcAddress,
            info: "account_found",
            accountList: [demoAccount(btcAddress)],
          ),
        ),
      ],
    );

    String ensAddress = 'nick.eth';
    String ethAddress = '0xb8c2c29ee19d8307cb7255e1cd9cbde883a267d5';
    blocTest(
      'emits Success when correct eth address is searched',
      build: () => explorerCubit,
      setUp: () {
        when(() => mockExplorerRepository.getETHAddress(any()))
            .thenAnswer((_) => Future.value(ethAddress));

        when(() => mockExplorerRepository.getBalanceETH(any(), any()))
            .thenAnswer((_) => Future.value(0.0));

        when(() => mockExplorerRepository.getETHUsername(any()))
            .thenAnswer((_) => Future.value(ensAddress));

        when(() => mockExplorerRepository.getCoinRate(any()))
            .thenAnswer((_) => Future.value(0.0));
      },
      act: (bloc) => explorerCubit.getAccountList(ensAddress),
      expect: () => [
        ExplorerLoading(
            state.data.copyWith(entry: ensAddress, info: "searching")),
        ExplorerLoading(
            state.data.copyWith(entry: ensAddress, info: "retrieve_account")),
        ExplorerSuccess(
          state.data.copyWith(
            entry: ensAddress,
            info: "account_found",
            accountList: [
              demoAccount(ethAddress),
              demoAccount(ethAddress),
              demoAccount(ethAddress),
              demoAccount(ethAddress),
            ],
          ),
        ),
      ],
    );
  });

  group('Explorer Cubit Tests for Failure Situations', () {
    String address = 'aaabbbccc';
    blocTest(
      'emits Failure when non-crypto address is searched',
      build: () => explorerCubit,
      act: (bloc) => explorerCubit.getAccountList(address),
      expect: () => [
        isA<ExplorerLoading>(),
        isA<ExplorerFailure>(),
      ],
    );

    String ensAddress = 'cookoorookoo.eth';
    String ethAddress = '';
    blocTest(
      'emits Failure when ens address cannot be identified',
      build: () => explorerCubit,
      setUp: () {
        when(() => mockExplorerRepository.getETHAddress(any()))
            .thenAnswer((_) => Future.value(ethAddress));
      },
      act: (bloc) => explorerCubit.getAccountList(ensAddress),
      expect: () => [
        isA<ExplorerLoading>(),
        isA<ExplorerLoading>(),
        isA<ExplorerFailure>(),
      ],
    );
  });
}

Account demoAccount(String address) => Account(
      id: address,
      chain: '',
      balance: '',
      fiatBalance: '',
      image: '',
      timestamp: DateTime.now(),
    );
