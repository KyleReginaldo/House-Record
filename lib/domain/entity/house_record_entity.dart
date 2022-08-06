class HouseRecordEntity {
  String uid;
  final String paymentNumber;
  final String date;
  final String ownerName;
  final String amount;
  final String coveredMonth;
  final String address;
  final String phase;
  final String manager;
  HouseRecordEntity({
    this.uid = '',
    required this.paymentNumber,
    required this.date,
    required this.ownerName,
    required this.amount,
    required this.coveredMonth,
    required this.address,
    required this.phase,
    required this.manager,
  });
}
