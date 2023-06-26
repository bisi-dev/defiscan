import 'package:defiscan/core/app_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/theme/app_style.dart';
import '../bloc/settings_cubit.dart';
import '../models/currency.dart';
import 'widgets/app_bar.dart';

class CurrenciesScreen extends StatelessWidget {
  const CurrenciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: SettingsAppBar(title: 'currencies'.i18n()),
          body: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: Currency.list.length,
              itemBuilder: (_, index) {
                final item = Currency.list[index];

                return InkWell(
                  splashColor: Colors.grey.withOpacity(0.2),
                  onTap: () {
                    context.read<SettingsCubit>().switchCurrency(item.code);
                    Navigator.pop(context);
                  },
                  child: ListTile(
                    title: Text(
                        "${item.code.toUpperCase()} - ${item.code.i18n()}",
                        style: AppStyle.link),
                    dense: true,
                    trailing: state.currencyCode == item.code
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
