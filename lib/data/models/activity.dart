class Activity {
  String? from;
  String? to;
  String? value;
  String? timeStamp;
  String? gas;
  bool isSent = false;

  Activity(
    this.from,
    this.to,
    this.value,
    this.timeStamp,
    this.gas,
    this.isSent,
  );
}
