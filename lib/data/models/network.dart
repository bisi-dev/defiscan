class Network {
  String titleTxt;
  bool isSelected;

  Network({
    this.titleTxt = '',
    this.isSelected = false,
  });

  static List<Network> networksList = [
    Network(
      titleTxt: 'All',
      isSelected: true,
    ),
    Network(
      titleTxt: 'Bitcoin',
      isSelected: true,
    ),
    Network(
      titleTxt: 'Ethereum',
      isSelected: true,
    ),
    Network(
      titleTxt: 'Polygon',
      isSelected: true,
    ),
    Network(
      titleTxt: 'Ropsten',
      isSelected: true,
    ),
    Network(
      titleTxt: 'Rinkeby',
      isSelected: true,
    ),
    Network(
      titleTxt: 'Goerli',
      isSelected: true,
    ),
    Network(
      titleTxt: 'Kovan',
      isSelected: true,
    ),
  ];
}
