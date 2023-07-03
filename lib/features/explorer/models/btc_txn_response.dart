class BtcTxnResponse {
  final int finalBalance;
  final List<BtcTxn> txs;

  const BtcTxnResponse({required this.finalBalance, required this.txs});

  factory BtcTxnResponse.fromJson(Map<String, dynamic> json) => BtcTxnResponse(
        finalBalance: json["final_balance"],
        txs: List<BtcTxn>.from(json["txs"].map((x) => BtcTxn.fromJson(x))),
      );
}

class BtcTxn {
  final int fee;
  final int time;
  final int result;
  final int balance;
  final String from;
  final String to;

  BtcTxn({
    required this.fee,
    required this.time,
    required this.result,
    required this.balance,
    required this.from,
    required this.to,
  });

  factory BtcTxn.fromJson(Map<String, dynamic> json) => BtcTxn(
        fee: json["fee"],
        time: json["time"],
        result: json["result"],
        balance: json["balance"],
        from: json["inputs"][0]["prev_out"]["addr"],
        to: json["out"][0]["addr"],
      );
}
