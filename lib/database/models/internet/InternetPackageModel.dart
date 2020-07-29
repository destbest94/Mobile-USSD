class InternetPackageModel {
  final int id;
  final String historyType;
  final String name;
  final String subscriptionFee;
  final String mobileInternetAmount;
  final String validityPeriod;
  final String shiftCode;
  final String description;
  final int internetPackagesGroup;

  InternetPackageModel({
    this.id,
    this.historyType,
    this.name,
    this.subscriptionFee,
    this.mobileInternetAmount,
    this.validityPeriod,
    this.shiftCode,
    this.description,
    this.internetPackagesGroup,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'history_type': historyType,
      'name': name,
      'subscription_fee': subscriptionFee,
      'mobile_internet_amount': mobileInternetAmount,
      'validity_period': validityPeriod,
      'shift_code': shiftCode,
      'description': description,
      'internet_packages_group': internetPackagesGroup,
    };
  }

  factory InternetPackageModel.fromJson(Map<String, dynamic> json) {
    return InternetPackageModel(
      id: json['id'],
      historyType: json['history_type'],
      name: json['name'],
      subscriptionFee: json['subscription_fee'],
      mobileInternetAmount: json['mobile_internet_amount'],
      validityPeriod: json['validity_period'],
      shiftCode: json['shift_code'],
      description: json['description'],
      internetPackagesGroup: json['internet_packages_group'],
    );
  }
}
