import 'package:defiscan/core/app_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../history/bloc/history_cubit.dart';
import '../bloc/explorer_cubit.dart';
import 'widgets/contest_tab_header.dart';
import 'widgets/explorer_card.dart';
import 'widgets/filter_bar.dart';
import 'widgets/search_bar.dart';

class ExplorerScreen extends StatefulWidget {
  const ExplorerScreen({Key? key}) : super(key: key);

  @override
  _ExplorerScreenState createState() => _ExplorerScreenState();
}

class _ExplorerScreenState extends State<ExplorerScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExplorerCubit, ExplorerState>(
      listener: (context, state) {
        if (state is ExplorerSuccess) {
          final hCubit = context.read<HistoryCubit>();
          hCubit.addHistory(state.data.accountList);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.shadow,
          body: SafeArea(
            child: InkWell(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: _body(state),
            ),
          ),
        );
      },
    );
  }

  Widget _body(ExplorerState state) {
    final eCubit = context.read<ExplorerCubit>();
    _textEditingController.text = state.data.entry;
    return Column(
      children: [
        Expanded(
          child: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return AppSearchBar(
                      controller: _textEditingController,
                      onSearch: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        eCubit.getAccountList(_textEditingController.text);
                      },
                      onPaste: () async {
                        final data = await Clipboard.getData('text/plain');
                        if (data != null) {
                          if (data.text != null) {
                            _textEditingController.text = data.text!;
                          }
                        }
                      },
                      onClear: () {
                        _textEditingController.clear();
                        eCubit.clear();
                      },
                    );
                  }, childCount: 1),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: ContestTabHeader(
                    ui: FilterBar(state is ExplorerInitial
                        ? 'start_search'.i18n()
                        : state.data.info),
                  ),
                ),
              ];
            },
            body: state is ExplorerLoading
                ? Lottie.asset(AppAnimation.blockchain)
                : state is ExplorerFailure
                    ? Lottie.asset(AppAnimation.error)
                    : listUI(state),
          ),
        )
      ],
    );
  }

  Widget listUI(ExplorerState state) {
    final accountList = state.data.accountList;

    return Container(
      color: Theme.of(context).primaryColor,
      child: ListView.builder(
        itemCount: accountList.length,
        padding: const EdgeInsets.only(top: 8),
        itemBuilder: (BuildContext context, int index) {
          final int count = accountList.length > 3 ? 3 : accountList.length;
          final Animation<double> animation =
              Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: _animationController,
                curve: Interval((1 / count) * index, 1.0,
                    curve: Curves.fastOutSlowIn)),
          );
          _animationController.forward();
          return ExplorerCard(
            callback: () {},
            account: accountList[index],
            expandInfo: index == 0 ? true : false,
            animation: animation,
            animationController: _animationController,
          );
        },
      ),
    );
  }
}
