import 'package:defiscan/core/app_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/theme/app_decoration.dart';
import '../../../shared/theme/app_style.dart';
import '../bloc/settings_cubit.dart';
import '../models/network.dart';
import 'widgets/app_bar.dart';

class NetworksScreen extends StatelessWidget {
  const NetworksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          final sCubit = context.read<SettingsCubit>();
          return Scaffold(
            appBar: SettingsAppBar(title: 'networks'.i18n()),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(children: [allNetworksUI(sCubit)]),
                  ),
                ),
                const Divider(height: 1),
                applyButton(sCubit)
              ],
            ),
          );
        },
      ),
    );
  }

  Widget allNetworksUI(SettingsCubit sCubit) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            'select_network'.i18n(),
            style: const TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: getNetworksListUI(sCubit)),
        ),
      ],
    );
  }

  List<Widget> getNetworksListUI(SettingsCubit sCubit) {
    final List<Widget> list = <Widget>[];
    for (int i = 0; i < Network.list.length; i++) {
      final network = Network.list[i];

      list.add(
        InkWell(
          borderRadius: borderRadius4,
          onTap: () => sCubit.setNetworks(network.chain),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: Text(network.chain)),
                CupertinoSwitch(
                  activeColor: sCubit.state.networks.contains(network.chain)
                      ? AppColor.kMainColor
                      : Colors.grey.withOpacity(0.6),
                  onChanged: (bool value) => sCubit.setNetworks(network.chain),
                  value: sCubit.state.networks.contains(network.chain),
                ),
              ],
            ),
          ),
        ),
      );
      if (i == 0) {
        list.add(const Divider(height: 1));
      }
    }
    return list;
  }

  Widget applyButton(SettingsCubit sCubit) {
    return Builder(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            height: 48,
            decoration: AppDecoration.buttonDecoration,
            child: InkWell(
              borderRadius: borderRadius24,
              onTap: () {
                sCubit.saveNetworkList();
                Navigator.pop(context);
              },
              child: Center(
                child: Text(
                  'apply'.i18n(),
                  style: AppStyle.buttonText.copyWith(color: AppColor.kWhite),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
