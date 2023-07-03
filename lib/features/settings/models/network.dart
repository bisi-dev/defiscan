import 'package:defiscan/shared/services/network/app_network.dart';

class Network {
  final String chain;
  final String currency;
  final String rpc;
  final String network;

  const Network({
    required this.chain,
    required this.currency,
    required this.rpc,
    required this.network,
  });

  static const List<Network> list = [
    Network(
      chain: 'All',
      currency: '',
      rpc: '',
      network: '',
    ),
    Network(
      chain: 'Bitcoin',
      currency: 'BTC',
      rpc: '',
      network: 'bitcoin',
    ),
    Network(
      chain: 'Ethereum',
      currency: 'ETH',
      rpc: NetworkConstants.mainnetRPC,
      network: 'ethereum',
    ),
    Network(
      chain: 'Polygon',
      currency: 'MATIC',
      rpc: NetworkConstants.polygonRPC,
      network: 'matic-network',
    ),
    Network(
      chain: 'Goerli',
      currency: 'ETH',
      rpc: NetworkConstants.goerliRPC,
      network: 'ethereum',
    ),
    Network(
      chain: 'Sepolia',
      currency: 'ETH',
      rpc: NetworkConstants.sepoliaRPC,
      network: 'ethereum',
    ),
  ];
}
