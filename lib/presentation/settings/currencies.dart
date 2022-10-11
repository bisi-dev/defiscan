import '../../core/app_core.dart';
import '../../data/app_data.dart';
import '../components/app_components.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';

class CurrenciesScreen extends StatefulWidget {
  const CurrenciesScreen({Key? key}) : super(key: key);

  @override
  _CurrenciesScreenState createState() => _CurrenciesScreenState();
}

class _CurrenciesScreenState extends State<CurrenciesScreen> {
  int _currencyIndex = 0;
  final List<Currency> _currencyList = Currency.currencyList;

  void changeCurrency(Currency currency) {
    AppPreference.setCurrencyPref([
      currency.symbol,
      currency.shortName,
      currency.longName,
      currency.index.toString()
    ]);
    setState(() => _currencyIndex = currency.index);
  }

  void _setUp() async {
    List list = await AppPreference.getCurrency();
    int index = int.parse(list[3]);
    setState(() => _currencyIndex = index);
  }

  @override
  void initState() {
    super.initState();
    _setUp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DeFiAppBar(title: 'Currencies'),
      body: SettingsList(
        backgroundColor: Theme.of(context).primaryColor,
        sections: [
          SettingsSection(
            tiles: _currencyList.map((currency) {
              return SettingsTile(
                  title:
                      "${currency.shortName.toUpperCase()} - ${currency.longName}",
                  trailing: trailingWidget(currency.index),
                  theme: SettingsTileTheme(
                    tileColor: Theme.of(context).primaryColor,
                  ),
                  onPressed: (BuildContext context) {
                    changeCurrency(currency);
                  });
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget trailingWidget(int index) {
    return (_currencyIndex == index)
        ? const Icon(Icons.check, color: AppColor.kMainColor)
        : const Icon(null);
  }
}
