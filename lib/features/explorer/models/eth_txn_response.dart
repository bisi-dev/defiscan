class EthTxnResponse {
  final List<EthTxn> result;

  const EthTxnResponse({required this.result});

  factory EthTxnResponse.fromJson(Map<String, dynamic> json) => EthTxnResponse(
        result: List<EthTxn>.from(
          json["result"].map((x) => EthTxn.fromJson(x)),
        ),
      );
}

class EthTxn {
  final String timeStamp;
  final String from;
  final String to;
  final String value;
  final String gas;

  const EthTxn({
    required this.timeStamp,
    required this.from,
    required this.to,
    required this.value,
    required this.gas,
  });

  factory EthTxn.fromJson(Map<String, dynamic> json) => EthTxn(
        timeStamp: json["timeStamp"],
        from: json["from"],
        to: json["to"],
        value: json["value"],
        gas: json["gas"],
      );
}
