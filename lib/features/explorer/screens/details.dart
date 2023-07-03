import 'package:defiscan/core/app_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/theme/app_decoration.dart';
import '../../../shared/utils/extensions/app_extensions.dart';
import '../bloc/explorer_cubit.dart';
import '../models/account.dart';
import '../models/transaction.dart';
import '../repository/explorer_repository.dart';
import 'widgets/contest_tab_header.dart';
import 'widgets/details_banner.dart';
import 'widgets/details_title.dart';
import 'widgets/loading_list.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  final ScrollController _scrollController = ScrollController();
  late Account account;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    account = ModalRoute.of(context)!.settings.arguments as Account;
    return BlocProvider(
      create: (context) =>
          ExplorerCubit(RepositoryProvider.of<ExplorerRepository>(context))
            ..getTransactionList(account),
      child: BlocConsumer<ExplorerCubit, ExplorerState>(
        listener: (context, state) {},
        builder: (context, state) {
          final eCubit = context.read<ExplorerCubit>();

          return Scaffold(
            body: InkWell(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: Column(
                children: <Widget>[
                  Container(
                    color: Theme.of(context).primaryColor,
                    height: MediaQuery.of(context).padding.top,
                  ),
                  Expanded(
                    child: NestedScrollView(
                      controller: _scrollController,
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              return Column(
                                children: [
                                  DetailsBanner(
                                    animationController: _animationController,
                                    account: account,
                                  ),
                                ],
                              );
                            }, childCount: 1),
                          ),
                          SliverPersistentHeader(
                            pinned: true,
                            floating: true,
                            delegate: ContestTabHeader(
                                ui: DetailsTitle(account: account), max: 148.0),
                          ),
                        ];
                      },
                      body: NotificationListener<ScrollEndNotification>(
                        onNotification: (scrollEnd) {
                          final metrics = scrollEnd.metrics;
                          if (metrics.atEdge) {
                            bool isTop = metrics.pixels == 0;
                            if (isTop) {
                            } else {
                              eCubit.getTransactionList(account);
                            }
                          }
                          return true;
                        },
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              state is ExplorerLoading
                                  ? const LoadingList()
                                  : state.data.transactionList.isNotEmpty
                                      ? listUI(state)
                                      : const SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget listUI(ExplorerState state) {
    List<Transaction> transactionList = state.data.transactionList;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(transactionList[0].date.formatDate()),
          ListView.separated(
            padding: const EdgeInsets.only(top: 8),
            itemCount: transactionList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final isDebit =
                  transactionList[index].type == TransactionType.debit
                      ? true
                      : false;

              return ListTile(
                shape:
                    const RoundedRectangleBorder(borderRadius: borderRadius8),
                tileColor: Theme.of(context).colorScheme.shadow,
                leading: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 30),
                  child: CircleAvatar(
                    minRadius: 20,
                    backgroundColor: isDebit
                        ? AppColor.kRed.withOpacity(0.1)
                        : AppColor.kGreen.withOpacity(0.1),
                    child: Icon(
                      isDebit ? Icons.arrow_upward : Icons.arrow_downward,
                      color: isDebit ? AppColor.kRed : AppColor.kGreen,
                    ),
                  ),
                ),
                minLeadingWidth: 0,
                title: Text(transactionList[index].address),
                trailing: SizedBox(
                  width: 72,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(child: Text(transactionList[index].value)),
                      FittedBox(child: Text(transactionList[index].fee)),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              if (transactionList[index].date.formatDate() ==
                  transactionList[index + 1].date.formatDate()) {
                return const SizedBox(height: 4);
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(transactionList[index + 1].date.formatDate()),
                );
              }
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
