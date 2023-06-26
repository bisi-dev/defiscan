import 'package:defiscan/core/app_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/services/store/store_service.dart';
import '../../../shared/theme/app_style.dart';
import '../bloc/settings_cubit.dart';
import 'widgets/app_bar.dart';

part 'settings_content.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SettingsAppBar(title: 'settings'.i18n(), canPop: false),
      body: _buildSettingsList(context),
    );
  }

  Widget _buildSettingsList(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          itemCount: SettingsContent.list.length,
          itemBuilder: (_, index) {
            final item = SettingsContent.list[index];
            final state = context.watch<SettingsCubit>().state;
            if (item.leading == null) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 12, 0),
                child: Text(item.title.i18n()),
              );
            } else {
              return InkWell(
                onTap: () {
                  if (item.route.isEmpty) return;
                  if (item.route == "store") {
                    StoreService.launchStore();
                  } else {
                    Navigator.pushNamed(context, item.route);
                  }
                },
                child: ListTile(
                  title: Text(item.title.i18n(), style: AppStyle.link),
                  leading: Icon(item.leading),
                  dense: true,
                  trailing: item.route.isEmpty
                      ? _darkModeToggle()
                      : _subtitle(item, state),
                  visualDensity: const VisualDensity(vertical: -3),
                ),
              );
            }
          },
          separatorBuilder: (_, index) => const Divider(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 8),
          child: Image.asset(
            AppImage.settingsImage,
            height: 50,
            width: 50,
            color: AppColor.kFairGrey,
          ),
        ),
        const Text(
          'Version: 1.1.0',
          style: TextStyle(color: AppColor.kFairGrey),
        ),
      ],
    );
  }

  Widget _darkModeToggle() {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return CupertinoSwitch(
            value: state.isDarkMode,
            onChanged: (val) => context.read<SettingsCubit>().toggleTheme());
      },
    );
  }

  Widget _subtitle(SettingsContent item, SettingsState state) {
    return FittedBox(
      child: Row(
        children: [
          Text(
            item.provideSubtitle(state),
            style: const TextStyle(
              color: AppColor.kFairGrey,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.arrow_forward_ios_sharp,
            color: AppColor.kFairGrey,
            size: 14,
          )
        ],
      ),
    );
  }
}
