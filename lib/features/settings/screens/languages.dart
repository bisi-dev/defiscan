import 'package:defiscan/core/app_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/locale/app_locale.dart';
import '../../../shared/theme/app_style.dart';
import '../bloc/settings_cubit.dart';
import 'widgets/app_bar.dart';

class LanguagesScreen extends StatelessWidget {
  const LanguagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: SettingsAppBar(title: 'languages'.i18n()),
          body: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: AppLocale.list.length,
              itemBuilder: (_, index) {
                final item = AppLocale.list[index];

                return InkWell(
                  onTap: () async {
                    if (state.languageCode == item.code) return;
                    context.read<SettingsCubit>().switchLocale(item.code);
                    await Future.delayed(const Duration(milliseconds: 500));
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoute.home, (route) => false,
                        arguments: 2);
                  },
                  child: ListTile(
                    title: Text(item.value.i18n(), style: AppStyle.link),
                    dense: true,
                    trailing: state.languageCode == item.code
                        ? const Icon(Icons.check, color: AppColor.kMainColor)
                        : const Icon(null),
                    visualDensity: const VisualDensity(vertical: -2),
                  ),
                );
              },
              separatorBuilder: (_, index) => const Divider(),
            ),
          ),
        );
      },
    );
  }
}
