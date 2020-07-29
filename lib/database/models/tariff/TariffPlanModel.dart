class TariffPlanModel {
  final int id;
  final String historyType;
  final String name;
  final String subscriptionFeeTitle;
  final String subscriptionFee;
  final String mobileInternetTitle;
  final String mobileInternetAmount;
  final String minuteTitle;
  final String minuteAmount;
  final String messageTitle;
  final String messageAmount;
  final String shiftCode;
  final String description;
  final int tariffPlansGroup;


  TariffPlanModel({
    this.id,
    this.historyType,
    this.name,
    this.subscriptionFeeTitle,
    this.subscriptionFee,
    this.mobileInternetTitle,
    this.mobileInternetAmount,
    this.minuteTitle,
    this.minuteAmount, 
    this.messageTitle,
    this.messageAmount,
    this.shiftCode,
    this.description,
    this.tariffPlansGroup,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'history_type': historyType,
      'name': name,
      'subscription_fee_title': subscriptionFeeTitle,
      'subscription_fee': subscriptionFee,
      'mobile_internet_title': mobileInternetTitle,
      'mobile_internet_amount': mobileInternetAmount,
      'minute_title': minuteTitle,
      'minute_amount': minuteAmount,
      'message_title': messageTitle,
      'message_amount': messageAmount,
      'shift_code': shiftCode,
      'description': description,
      'tariff_plans_group': tariffPlansGroup,
    };
  }

  factory TariffPlanModel.fromJson(Map<String, dynamic> json) {
    return TariffPlanModel(
      id: json['id'],
      historyType: json['history_type'],
      name: json['name'],
      subscriptionFeeTitle: json['subscription_fee_title'],
      subscriptionFee: json['subscription_fee'],
      mobileInternetTitle: json['mobile_internet_title'],
      mobileInternetAmount: json['mobile_internet_amount'],
      minuteTitle: json['minute_title'],
      minuteAmount: json['minute_amount'],
      messageTitle: json['message_title'],
      messageAmount: json['message_amount'],
      shiftCode: json['shift_code'],
      description: json['description'],
      tariffPlansGroup: json['tariff_plans_group'],
    );
  }
}