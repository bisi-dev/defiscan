import '../../core/app_core.dart';
import '../../data/app_data.dart';
import '../components/app_components.dart';
import 'package:flutter/cupertino.dart';

class NetworksScreen extends StatefulWidget {
  const NetworksScreen({Key? key}) : super(key: key);

  @override
  _NetworksScreenState createState() => _NetworksScreenState();
}

class _NetworksScreenState extends State<NetworksScreen> {
  final List<Network> _networksList = Network.networksList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DeFiAppBar(title: 'Networks'),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[allNetworksUI()],
              ),
            ),
          ),
          const Divider(height: 1),
          applyButton()
        ],
      ),
    );
  }

  Widget applyButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: AppColor.kMainColor,
          borderRadius: const BorderRadius.all(Radius.circular(24.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              blurRadius: 8,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            highlightColor: Colors.transparent,
            onTap: () => Navigator.pop(context),
            child: Center(
              child: Text(
                'Apply',
                style: AppStyle.buttonText.copyWith(color: AppColor.kWhite),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget allNetworksUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            'Select Blockchain networks',
            style: TextStyle(
              color: Colors.grey,
              fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: getNetworksListUI()),
        ),
      ],
    );
  }

  List<Widget> getNetworksListUI() {
    final List<Widget> noList = <Widget>[];
    for (int i = 0; i < _networksList.length; i++) {
      final Network data = _networksList[i];
      noList.add(
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            onTap: () {
              setState(() => checkAppPosition(i));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(data.titleTxt),
                  ),
                  CupertinoSwitch(
                    activeColor: data.isSelected
                        ? AppColor.kMainColor
                        : Colors.grey.withOpacity(0.6),
                    onChanged: (bool value) {
                      setState(() => checkAppPosition(i));
                    },
                    value: data.isSelected,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      if (i == 0) {
        noList.add(const Divider(height: 1));
      }
    }
    return noList;
  }

  void checkAppPosition(int index) {
    if (index == 0) {
      if (_networksList[0].isSelected) {
        for (var d in _networksList) {
          d.isSelected = false;
        }
      } else {
        for (var d in _networksList) {
          d.isSelected = true;
        }
      }
    } else {
      _networksList[index].isSelected = !_networksList[index].isSelected;

      int count = 0;
      for (int i = 0; i < _networksList.length; i++) {
        if (i != 0) {
          final Network data = _networksList[i];
          if (data.isSelected) {
            count += 1;
          }
        }
      }

      if (count == _networksList.length - 1) {
        _networksList[0].isSelected = true;
      } else {
        _networksList[0].isSelected = false;
      }
    }
  }
}
