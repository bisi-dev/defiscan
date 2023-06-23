import 'package:defiscan/core/app_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/services/store/store_service.dart';
import '../../../shared/themes/app_style.dart';
import '../../../shared/themes/theme_cubit.dart';

part 'settings_content.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Settings'),
      ),
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
            if (item.leading == null) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 12, 0),
                child: Text(item.title),
              );
            } else {
              return InkWell(
                onTap: () {
                  if (item.route == "store") StoreService.launchStore();
                  Navigator.pushNamed(context, item.route);
                },
                child: ListTile(
                  title: Text(item.title, style: AppStyle.link),
                  leading: Icon(item.leading),
                  dense: true,
                  trailing:
                      item.route.isEmpty ? _darkModeToggle() : const Text(''),
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
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return CupertinoSwitch(
            value: state.isDarkMode,
            onChanged: (val) => context.read<ThemeCubit>().toggle());
      },
    );
  }
}
